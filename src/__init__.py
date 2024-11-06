import os
import logging

logging.basicConfig(
    format="%(levelname)s: %(message)s",
    level=logging.DEBUG
)

def project_source_path() -> str:
    curr: str = os.path.dirname(os.path.abspath(__file__))

    while curr and not os.path.exists(os.path.join(curr, 'setup.py')):
        curr = os.path.dirname(curr)

    return os.path.join(curr, "src")
