#!/user/bin/env python

from datetime import datetime

def ts_now() -> str:
    return datetime.now().strftime("%d/%m/%Y %H:%M:%S")

def banner(s: str) -> str:
    return f"""✦✦✦ {s} ✦✦✦"
