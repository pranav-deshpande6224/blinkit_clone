from pydantic import BaseModel
from datetime import datetime

class CouponCode(BaseModel):
    coupon_code:str
    minimum_amount:float
    validity_date: datetime
    discount_percentage:float
    description:str