#!/usr/bin/env python

import sys
import os
from utils import *

who_are_u = '???' if len(sys.argv) <= 1 else sys.argv[1]

print(
    f"""{banner('Identification Header')}
    Hello {who_are_u} * {ts_now()}
    Env(WHO_ARE_U): {os.environ['WHO_ARE_U']}
    """
)
