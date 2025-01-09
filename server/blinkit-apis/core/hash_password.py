from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
def get_password_hash(password) -> str :
    return pwd_context.hash(password)

def verify_password(plain_password:str, hashed_password:str) -> bool:
    # converts the plain password into hashed password
    # and compares it with the hashed password
    return pwd_context.verify(plain_password, hashed_password)