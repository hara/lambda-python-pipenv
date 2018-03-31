import sys
import os

EXAMPLE_ROOT = os.path.dirname(os.path.abspath(__file__))
EXAMPLE_VENDOR = os.path.join(os.path.dirname(EXAMPLE_ROOT), 'vendor')

sys.path.append(EXAMPLE_VENDOR)

import requests


def hello_world(event, context):
    r = requests.get('https://example.com/')
    return r.status_code


if __name__ == '__main__':
    print(hello_world({}, None))
