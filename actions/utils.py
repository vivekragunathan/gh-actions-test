#!/usr/bin/env python

from datetime import datetime
import subprocess
from typing import Optional


def ts_now() -> str:
    return datetime.now().strftime("%d/%m/%Y %H:%M:%S")


def banner(s: str) -> str:
    return f"✦✦✦ {s} ✦✦✦"


def shell_cmd(cmd: str):
    return subprocess.run(cmd.split(' '), capture_output=True, text=True) # stdout=subprocess.PIPE


def print_cmd_output(cmd: str, banner_msg: Optional[str] = None) -> str:
    if banner:
        print(banner(banner_msg))

    result = subprocess.getoutput(cmd)
    print(result)
    return result
