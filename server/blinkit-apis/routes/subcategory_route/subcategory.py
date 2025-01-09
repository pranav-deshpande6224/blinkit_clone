from fastapi import APIRouter, Depends, HTTPException, status
from routes.auth_routes.auth import validate_token_return_str
from bson  import ObjectId
from configuration import subcategory_collection,product_collection
from model.subcategory_model.subcategory import Subcategory
from routes.category_route.category import validate_category

router = APIRouter(prefix="/subcategory", tags=["Add New Subcategory"])

@router.post("/add_subcategory", status_code=status.HTTP_201_CREATED)
def add_new_subcategory(subcategory: Subcategory, _:str = Depends(validate_token_return_str)):
    category = validate_category(subcategory.category_id)
    exist_subcategory =  subcategory_collection.find_one({"subcategory_name": subcategory.subcategory_name})
    if exist_subcategory:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Subcategory already exists under this category"
        )
    subcategory_document = {
        "image_url": subcategory.image_url,
        "subcategory_name": subcategory.subcategory_name,
        "category_id": ObjectId(subcategory.category_id)
    }
    subcategory_collection.insert_one(subcategory_document)
    return {
        "message": f'Subcategory {subcategory.subcategory_name} added successfully to {category.get("category_name")}'
    }

def serialize_subcategory_document(doc):
    return {
        "id": str(doc["_id"]),
        "image_url": doc["image_url"],
        "subcategory_name": doc["subcategory_name"],
        "category_id": str(doc["category_id"])
    }

@router.get("/get_all_subcategories", status_code=status.HTTP_200_OK)
def get_all_subcategories( _ : str = Depends(validate_token_return_str)):
    subcategories = list(subcategory_collection.find())
    serialized_subcategories = [serialize_subcategory_document(doc) for doc in subcategories]
    return {
        "subcategories": serialized_subcategories
    }
def validate_sub_category(subcategory_id:str):
    if not ObjectId.is_valid(subcategory_id):
        raise  HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid subcategory ID"
        )
    subCategory = subcategory_collection.find_one({"_id": ObjectId(subcategory_id)})
    if not subCategory:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="subcategory not found"
        )
    return subCategory

@router.put("/update_subcategory/{subcategory_id}", status_code=status.HTTP_200_OK)
def update_subcategory(subcategory_id: str, new_subcategory: Subcategory, _: str = Depends(validate_token_return_str)):
    validate_sub_category(subcategory_id)
    validate_category(new_subcategory.category_id)
    subcategory_document = {
        "image_url": new_subcategory.image_url,
        "subcategory_name": new_subcategory.subcategory_name,
        "category_id": ObjectId(new_subcategory.category_id)
    }
    subcategory_collection.update_one({"_id": ObjectId(subcategory_id)}, {"$set": subcategory_document})
    return {
        "message": f'Subcategory {new_subcategory.subcategory_name} updated successfully'
    }

@router.delete("/delete_subcategory/{subcategory_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_subcategory(subcategory_id: str, _: str = Depends(validate_token_return_str)):
    validate_sub_category(subcategory_id)
    product_collection.delete_many({"subcategory_id": ObjectId(subcategory_id)})
    subcategory_collection.delete_one({"_id": ObjectId(subcategory_id)})