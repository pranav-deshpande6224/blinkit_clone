from bson import ObjectId
from fastapi import APIRouter, Depends, HTTPException, status
from routes.auth_routes.auth import validate_token_return_str
from bson  import ObjectId
from configuration import category_collection,subcategory_collection,product_collection
from model.category_model.category import Category
from routes.title_route.add_title import validate_title


router = APIRouter(prefix="/category", tags=["Add New Category"])
@router.post("/add_category", status_code=status.HTTP_201_CREATED)
def add_new_category(category: Category, _:str = Depends(validate_token_return_str)):
    title = validate_title(category.title_id)
    exist_category =  category_collection.find_one({"category_name": category.category_name})
    if exist_category:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Category already exists under this title"
        )
    category_document = {
        "image_url": category.image_url,
        "category_name": category.category_name,
        "title_id": ObjectId(category.title_id)
    }
    category_collection.insert_one(category_document)
    return {
        "message": f'Category {category.category_name} added successfully to {title.get("title")}'
    }

def serialize_category_document(doc):
    return {
        "id": str(doc["_id"]),
        "image_url": doc["image_url"],
        "category_name": doc["category_name"],
        "title_id": str(doc["title_id"])
    }

def validate_category(category_id:str):
    if not ObjectId.is_valid(category_id):
        raise  HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid category ID"
        )
    category = category_collection.find_one({"_id": ObjectId(category_id)})
    if not category:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Category not found"
        )
    return category

@router.get("/get_all_categories", status_code=status.HTTP_200_OK)
def get_all_categories( _ : str = Depends(validate_token_return_str)):
    categories = list(category_collection.find())
    categories = [serialize_category_document(doc) for doc in categories]
    return {
        "categories": categories
    }

@router.put("/update_category/{category_id}", status_code=status.HTTP_200_OK)
def update_category(category_id: str, new_category: Category, _: str = Depends(validate_token_return_str)):
    category_document = validate_category(category_id)
    category_document["image_url"] = new_category.image_url
    category_document["category_name"] = new_category.category_name
    category_document["title_id"] = ObjectId(new_category.title_id)
    category_collection.update_one({"_id": ObjectId(category_id)}, {"$set": category_document})
    return {
        "message": "Category updated successfully"
    }
@router.delete("/delete_category/{category_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_category(category_id: str, _: str = Depends(validate_token_return_str)):
    validate_category(category_id)
    subcategories = subcategory_collection.find({"category_id": ObjectId(category_id)})
    for subcategory in subcategories:
        product_collection.delete_many({"subcategory_id": ObjectId(subcategory["_id"])})
        subcategory_collection.delete_one({"_id": ObjectId(subcategory["_id"])})
    category_collection.delete_one({"_id": ObjectId(category_id)})
