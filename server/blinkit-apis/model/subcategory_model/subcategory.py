from pydantic import BaseModel

class Subcategory(BaseModel):
    image_url: str
    subcategory_name: str
    category_id: str