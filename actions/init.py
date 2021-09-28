import sys
import os
from utils import *

if len(sys.argv) <= 1:
    sys.exit('Required arg not specified')
else:
    who_are_u = sys.argv[1]

    print(
        f"""{banner('Identification Header')}
        Hello {who_are_u} * {ts_now()}
        Env(WHO_ARE_U): {os.environ['WHO_ARE_U']}
        """
    )
