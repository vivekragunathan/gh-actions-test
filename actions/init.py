import sys
import os
from utils import *

who_are_u = sys.argv[1]

print(
    f"""{banner('Identification Header')}
    Hello {who_are_u} * {ts_now()}
    Env(WHORU): {os.environ['WHORU']}
    """
)
