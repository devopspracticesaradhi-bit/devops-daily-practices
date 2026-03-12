import boto3
import json
import random

sqs = boto3.client('sqs')

QUEUE_URL = "YOUR_SQS_QUEUE_URL"

def lambda_handler(event, context):

    status = random.choice(["success","success","error"])

    message = {
        "service": "payment-service",
        "status": status
    }

    sqs.send_message(
        QueueUrl=QUEUE_URL,
        MessageBody=json.dumps(message)
    )

    print("Message sent:", message)

    return {
        "statusCode": 200,
        "body": message
    }