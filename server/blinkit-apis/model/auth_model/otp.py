from pydantic import BaseModel, EmailStr

class ValidateOTP(BaseModel):
    email: EmailStr
    otp: str