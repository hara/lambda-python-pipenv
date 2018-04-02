import requests


def hello_world(event: dict, context):
    r = requests.get('https://example.com/')
    return r.status_code
