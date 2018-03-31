import sys
import os
example_dir = os.path.dirname(os.path.abspath(__file__))
src_dir = os.path.dirname(example_dir)
vendor_dir = os.path.join(src_dir, 'vendor')
sys.path.append(vendor_dir)

import requests


def hello_world(event, context):
    r = requests.get('https://example.com/')
    return r.status_code
