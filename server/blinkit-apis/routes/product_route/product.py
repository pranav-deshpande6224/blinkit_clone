from fastapi import APIRouter, HTTPException, status, Depends
from bson import ObjectId
from model.product_model.product import Product
from routes.auth_routes.auth import validate_token_return_str
from routes.subcategory_route.subcategory import validate_sub_category
from configuration import product_collection

router = APIRouter(prefix="/product", tags=["Add Product"])

@router.post("/add_product", status_code=status.HTTP_201_CREATED)
def add_new_product(product:Product, _:str = Depends(validate_token_return_str)):
    # so the cloudinary url is the image url
    sub_category = validate_sub_category(product.subcategory_id)
    old_product = product_collection.find_one({"product_name": product.product_name})
    if old_product:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Product already exists"
        )
    product_document = {
        **product.model_dump(exclude={"subcategory_id", "info"}), 
        "subcategory_id": ObjectId(product.subcategory_id),  
        "info": product.info.model_dump(),  
        "additional_info": product.additional_info
    }
    product_collection.insert_one(product_document)
    return {
        "message": f'Product {product.product_name} added successfully to {sub_category.get("subcategory_name")}'
    }

def validate_product(product_id:str):
    if not ObjectId.is_valid(product_id):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid product id"
        )
    product = product_collection.find_one({"_id": ObjectId(product_id)})
    if not product:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Product not found"
        )
    return product

@router.put("/update_product/{product_id}", status_code=status.HTTP_200_OK)
def update_product(product_id:str, new_product:Product, _:str = Depends(validate_token_return_str)):
    validate_product(product_id)
    validate_sub_category(new_product.subcategory_id)
    updated_product = {
        **new_product.model_dump(exclude={"subcategory_id", "info"}),
        "subcategory_id": ObjectId(new_product.subcategory_id),
        "info": new_product.info.model_dump(),
        "additional_info": new_product.additional_info
    }
    product_collection.update_one({"_id": ObjectId(product_id)}, {"$set": updated_product})
    return {
        "message": f'Product {new_product.product_name} updated successfully'
    }

@router.delete("/delete_product/{product_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_product(product_id:str, _:str = Depends(validate_token_return_str)):
    validate_product(product_id)
    product_collection.delete_one({"_id": ObjectId(product_id)})

def serialize_product_document(doc):
    return {
        "id": str(doc["_id"]),
        "product_image_url": doc["product_image_url"],
        "product_name": doc["product_name"],
        "discount_percentage": doc["discount_percentage"],
        "weight": doc["weight"],
        "fast_delivery": doc["fast_delivery"],
        "support_24_7": doc["support_24_7"],
        "freshly_sourceed": doc["freshly_sourceed"],
        "replacement_in_72_hours": doc["replacement_in_72_hours"],
        "quality_assured": doc["quality_assured"],
        "mrp_price": doc["mrp_price"],
        "subcategory_id": str(doc["subcategory_id"]),
        "info": doc["info"],
        "additional_info": doc["additional_info"],
        "stock_quantity": doc["stock_quantity"]
    }
@router.get("/get_all_products", status_code=status.HTTP_200_OK)
def get_all_products(_:str = Depends(validate_token_return_str)):
    products = list(product_collection.find())
    serialized_products = [serialize_product_document(doc) for doc in products]
    return {
        "products": serialized_products
    }
