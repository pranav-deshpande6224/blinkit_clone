from fastapi import APIRouter, Depends, HTTPException, status
from model.title_model.title import Title
from routes.auth_routes.auth import validate_token_return_str
from configuration import title_collection,category_collection,subcategory_collection,product_collection
from bson import ObjectId

router = APIRouter(prefix="/title", tags=["Add Title"])
@router.post("/add_title", status_code=status.HTTP_201_CREATED)
def add_new_title(titleRef:Title, _ : str = Depends(validate_token_return_str)):
    obj = title_collection.find_one({"title": titleRef.title})
    if obj:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Title already exists")
    title_collection.insert_one({
        "title": titleRef.title
    })
    return {
        "message": "Title added successfully"
    }


def validate_title(title_id:str):
    if not ObjectId.is_valid(title_id):
        raise  HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid title ID"
        )
    title = title_collection.find_one({"_id": ObjectId(title_id)})
    if not title:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Title not found"
        )
    return title
def serialize_title_document(doc):
    return {
        "id": str(doc["_id"]), 
        "title": doc["title"]
    }


@router.get("/get_all_titles", status_code=status.HTTP_200_OK)
async def get_all_titles( _ : str = Depends(validate_token_return_str)):
    titles = list(title_collection.find())
    serialized_tiles = [serialize_title_document(doc) for doc in titles]
    return {
        "titles": serialized_tiles
    }


@router.put("/update_title/{title_id}", status_code=status.HTTP_200_OK)
def update_title(title_id:str, new_title:Title, _ : str = Depends(validate_token_return_str)):
   validate_title(title_id)
   title_collection.update_one({"_id": ObjectId(title_id)}, {"$set": {"title": new_title.title}})
   return {
        "message": "Title updated successfully"
    }

@router.delete("/delete_title/{title_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_title(title_id:str, _ : str = Depends(validate_token_return_str)):
    validate_title(title_id)
    for category in category_collection.find({"title_id": ObjectId(title_id)}):
        for subcategory in subcategory_collection.find({"category_id": ObjectId(category["_id"])}):
            product_collection.delete_many({"subcategory_id": ObjectId(subcategory["_id"])})
            subcategory_collection.delete_one({"_id": ObjectId(subcategory["_id"])})
        category_collection.delete_one({"_id": ObjectId(category["_id"])})
    title_collection.delete_one({"_id": ObjectId(title_id)})
