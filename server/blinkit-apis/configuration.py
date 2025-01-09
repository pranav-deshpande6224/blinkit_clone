from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
uri = "mongodb+srv://pranav:Pranav6224@blinkit.nzlbb.mongodb.net/?retryWrites=true&w=majority&appName=blinkit"
client = MongoClient(uri, server_api=ServerApi('1'))


db = client.blinkit_db
admin_collection = db["admin_collection"]
title_collection = db["title_collection"]
category_collection = db["category_collection"]
subcategory_collection = db["subcategory_collection"]
product_collection = db["product_collection"]
coupon_collection = db["coupon_collection"]

