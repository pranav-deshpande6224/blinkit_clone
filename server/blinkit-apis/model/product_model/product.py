from pydantic import BaseModel, Field
from typing import List, Dict
from model.product_model.info import Info


class Product(BaseModel):
    product_name:str = Field(..., example="Amul Milk")
    subcategory_id:str =  Field(..., example="649e1611715709013604315c")
    product_image_url:List[str] = [Field(..., example="https://someImage.png")]
    mrp_price:float = Field(..., example="100.0")
    discount_percentage:float = Field(..., example="10.0")
    weight:str = Field(..., example="1L")
    stock_quantity:int = Field(..., example="10")
    fast_delivery:bool = Field(..., example="true")
    support_24_7:bool = Field(..., example="true")
    freshly_sourceed:bool = Field(..., example="true")
    replacement_in_72_hours:bool = Field(..., example="true")
    quality_assured:bool = Field(..., example="true")
    info:Info
    additional_info:Dict[str, str] = Field(..., example={"key": "value"})

