from pydantic import BaseModel, Field
class Info(BaseModel):
    shelf_life: str = Field(..., example="6 months")
    return_policy: str = Field(..., example="10 days")
    unit: str = Field(..., example="1L")
    country_of_origin: str = Field(..., example="India")
    customer_care_details: str = Field(..., example="Mumbai Maharashtra")
    disclaimer: str = Field(..., example="some disclaimer")
    seller : str = Field(..., example="rebuy store")
    seller_Fssai_license: str = Field(..., example="xyz abc ")
    packaging_type: str = Field(..., example="plastic")
    manfacture_address: str = Field(..., example="xyz abc")
    marketer_address: str = Field(..., example="xyz abc")
    storage_tips: str = Field(..., example="store in a cool and dry place")
    