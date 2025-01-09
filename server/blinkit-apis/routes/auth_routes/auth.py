from fastapi import APIRouter, HTTPException, status,BackgroundTasks
from core.hash_password import get_password_hash, verify_password
from redis import Redis
import random
import smtplib
import jwt
from configuration import admin_collection
from email.mime.text import MIMEText
from model.auth_model.otp import ValidateOTP
from model.auth_model.login_admin import LoginAdmin
from model.auth_model.signup_admin import Admin


redis_client = Redis(host="localhost", port=6379, decode_responses=True)
router = APIRouter(prefix="/auth", tags=["Authentication"])
EMAIL_HOST = "smtp.gmail.com"
EMAIL_PORT = 587
EMAIL_USERNAME = "deshpande6224@gmail.com"
EMAIL_PASSWORD = "rirgxxdkcozzejvz" 
SECRET_KEY = "ea01ac0d9f42054490483623cca56915d14080eceba599737e34f0d3bc7584f7"
ALGORITHM = "HS256"


def user_exists(email:str)->bool:
    if admin_collection.find_one({"email": email}):
        return True
    return False

def get_name(email:str)->str:
    admin = admin_collection.find_one({"email": email})
    return admin["name"]

def generate_otp() -> str:
    return f"{random.randint(100000, 999999)}"

def store_otp_in_redis(email: str, otp: str, expiry_seconds: int = 300):
    # setex is the expiration method 
    redis_client.setex(email, expiry_seconds, otp)

def get_otp_from_redis(email: str) -> str:
    """Retrieve OTP from Redis."""
    return redis_client.get(email)


def send_email(email: str, otp: str):
    msg = MIMEText(f"Your OTP is: {otp}. It will expire in 5 minutes.")
    msg["Subject"] = "Your OTP Code"
    msg["From"] = EMAIL_USERNAME
    msg["To"] = email

    with smtplib.SMTP(EMAIL_HOST, EMAIL_PORT) as server:
        server.starttls()
        server.login(EMAIL_USERNAME, EMAIL_PASSWORD)
        server.send_message(msg)

def create_access_token(email: str):
    return jwt.encode({"email": email}, SECRET_KEY, algorithm=ALGORITHM)

def decode_access_token(token:str):
    try:
        payload:dict = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("email")
        if email is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")
        return email
    except :
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")

@router.post("/signup")
async def signup(admin: Admin, background_tasks:BackgroundTasks):
    if user_exists(admin.email):
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="User already exists")
    admin.password = get_password_hash(admin.password)
    admin_data = {
        "name": admin.name,
        "email": admin.email,
        "password": admin.password,
        "isVerified": admin.isVerified
    }
    result = admin_collection.insert_one(admin_data)
    if not result.acknowledged:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Unable to create the admin")
    
    otp = generate_otp()
    store_otp_in_redis(admin.email, otp)
    background_tasks.add_task(send_email, admin.email, otp)

    return {
        "message": "Admin created successfully, Please verify your email with OTP"
        }

@router.post("/verifyOtp", status_code= status.HTTP_200_OK)
async def validate_otp(data: ValidateOTP):
    """for the user who exists in db"""
    if not user_exists(data.email):
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    stored_otp = get_otp_from_redis(data.email)
    if not stored_otp:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="OTP has Expired"
        )
    if stored_otp != data.otp:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid OTP"
        )
    # update the admin collection with the isVerified field
    admin_collection.update_one(
        {"email": data.email},
        {"$set": {"isVerified": True}}
    )
    redis_client.delete(data.email)
    token = create_access_token(data.email)
    name = get_name(data.email)
    return {
        "message": "OTP verified successfully",
        "email": data.email,
        "token": token,
        "name": name
    }

@router.post("/login", status_code=status.HTTP_200_OK)
async def login(loginAdmin: LoginAdmin, background_tasks:BackgroundTasks):
    # check if the user exists
    admin = admin_collection.find_one({"email": loginAdmin.email})
    if not admin:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    # check if the password is correct
    if not verify_password(loginAdmin.password, admin["password"]):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Incorrect password")

    # check if the user is verified
    if not admin["isVerified"]:
        otp = generate_otp()
        store_otp_in_redis(admin.email, otp)
        background_tasks.add_task(send_email, admin.email, otp)  
        # move to otp screen 
    else:
        token = create_access_token(admin["email"])
        return {
            "message": "Login successful",
            "email": admin["email"],
            "token": token,
            "name": admin["name"]
        }

# this is used when the user having some token and all
@router.get("/verifyToken", status_code=status.HTTP_200_OK)
async def validate_token(token: str):
    email = decode_access_token(token)
    admin = admin_collection.find_one({"email": email})
    if not admin:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    return {
        "message": "Token verified successfully",
        "email": admin["email"],
        "name": admin["name"]
    }

def validate_token_return_str(token: str) -> str:
    email = decode_access_token(token)
    admin = admin_collection.find_one({"email": email})
    if not admin:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    return token