from pydantic import BaseModel
from typing import Optional

class Category(BaseModel):
    image_url:str # here upload the image by selecting the image 
    category_name:str
    title_id: Optional[str] = None

