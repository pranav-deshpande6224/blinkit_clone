from fastapi import FastAPI
from routes.auth_routes.auth import router as auth_router
from routes.title_route.add_title import router as title_router
from routes.category_route.category import router as category_router
from routes.subcategory_route.subcategory import router as subcategory_router
from routes.product_route.product import router as product_router
from routes.coupons_route.coupons import router as coupon_router
app = FastAPI()

app.include_router(router= auth_router)
app.include_router(router= title_router)
app.include_router(router= category_router)
app.include_router(router= subcategory_router)
app.include_router(router= product_router)
app.include_router(router= coupon_router)

