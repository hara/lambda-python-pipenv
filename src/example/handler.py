import requests


def hello_world(event, context):
    r = requests.get('https://example.com/')
    return r.status_code
