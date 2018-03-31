from example.handler import hello_world


def test_hello_world():
    status = hello_world(None, None)
    assert status == 200
