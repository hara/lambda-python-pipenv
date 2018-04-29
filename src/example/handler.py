import os
import boto3
from botocore.client import Config


def hello_world(event: dict, context):
    s3 = boto3.resource(
        's3',
        'ap-northeast-1',
        endpoint_url=os.getenv('S3_ENDPOINT'),
        config=Config(s3={'addressing_style': 'path'}))
    for bucket in s3.buckets.all():
        print(bucket.name)
