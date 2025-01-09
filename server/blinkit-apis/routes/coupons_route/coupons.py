from fastapi import APIRouter, HTTPException, status, Depends
from bson import ObjectId
from model.coupon_model.coupon_code import CouponCode
from routes.auth_routes.auth import validate_token_return_str
from configuration import coupon_collection
router = APIRouter(prefix="/coupon", tags=["Add Coupon"])

@router.post("/add_coupon", status_code=status.HTTP_201_CREATED)
def add_new_coupon(coupon:CouponCode, _:str = Depends(validate_token_return_str)):
    old_coupon = coupon_collection.find_one({"coupon_code": coupon.coupon_code})
    if old_coupon:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Coupon already exists"
        )
    coupon_document = {
        **coupon.model_dump(exclude={"validity_date"}),
        "validity_date": coupon.validity_date.isoformat()
    }
    coupon_collection.insert_one(coupon_document)
    return {
        "message": "Coupon added successfully"
    }
