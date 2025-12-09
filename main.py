import os
import time
import logging
from datetime import datetime
from fastapi import FastAPI, Request, HTTPException
from pymongo import MongoClient

# ---------- Logging Setup (Single-line Structured Logs) ----------
logging.basicConfig(
    level=logging.INFO,
    format="method=%(method)s path=%(path)s status=%(status)s latency_ms=%(latency)s"
)
logger = logging.getLogger("app")

# ---------- Read Environment Variables ----------
MONGO_URI = os.getenv("MONGO_URI")
MONGO_DB = os.getenv("MONGO_DB", "app")
MONGO_COLLECTION = os.getenv("MONGO_COLLECTION", "orders")

if not MONGO_URI:
    raise RuntimeError("MONGO_URI environment variable is required")

# ---------- MongoDB Client ----------
client = MongoClient(MONGO_URI)
db = client[MONGO_DB]
collection = db[MONGO_COLLECTION]

# ---------- FastAPI App ----------
app = FastAPI()


# ---------- Helper: Log each request ----------
@app.middleware("http")
async def log_requests(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    latency = int((time.time() - start_time) * 1000)

    logger.info(
        "",
        extra={
            "method": request.method,
            "path": request.url.path,
            "status": response.status_code,
            "latency": latency,
        },
    )
    return response


# ---------- Health Endpoint ----------
@app.get("/healthz")
def health_check():
    try:
        # Fast Mongo ping
        client.admin.command("ping")
        return {"status": "ok"}
    except Exception:
        raise HTTPException(status_code=503, detail="MongoDB not reachable")


# ---------- Insert Order ----------
@app.post("/orders")
async def create_order(payload: dict):
    order_id = payload.get("orderId")

    if not order_id:
        raise HTTPException(status_code=400, detail="orderId is required")

    doc = {
        "orderId": order_id,
        "ts": datetime.utcnow()
    }

    result = collection.insert_one(doc)

    return {
        "inserted": True,
        "id": str(result.inserted_id)
    }


# ---------- Count Orders ----------
@app.get("/orders/count")
def count_orders():
    count = collection.count_documents({})
    return {"count": count}

