import sys
import os

vendor = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'vendor')
sys.path.append(vendor)

import requests


def hello_world(event, context):
    r = requests.get('https://example.com/')
    return r.status_code


if __name__ == '__main__':
    print(hello_world({}, None))
