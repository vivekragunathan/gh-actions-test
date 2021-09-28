import sys
import os
from utils import *

print(
    f"""{banner(Identification Header)}
    Hello {who_are_u} * {ts_now()}
    Env(WHOAREYOU): {os.environ['WHOAREYOU']}
    """
)
