import json
import boto3
import uuid

s3 = boto3.client('s3')

BUCKET = "Enter you S3 bucket name here" 

def lambda_handler(event, context):

    print("EVENT RECEIVED:", event)

    for record in event['Records']:

        body = json.loads(record['body'])
        print("MESSAGE:", body)

        # simulate application failure
        if body['status'] == "error":
            raise Exception("Simulated application failure")

        filename = f"logs/{uuid.uuid4()}.json"

        s3.put_object(
            Bucket=BUCKET,
            Key=filename,
            Body=json.dumps(body)
        )

        print("File stored in S3")

    return {"status": "processed"}