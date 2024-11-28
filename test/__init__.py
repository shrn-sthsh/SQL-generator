import os
import logging

logging.basicConfig(
    format="%(levelname)s: %(message)s",
    level=logging.INFO
)

from functools import lru_cache

@lru_cache(maxsize=1)
def project_test_path() -> str:
    curr: str = os.path.dirname(os.path.abspath(__file__))

    while curr and not os.path.exists(os.path.join(curr, 'setup.py')):
        curr = os.path.dirname(curr)

    return os.path.join(curr, "test")
