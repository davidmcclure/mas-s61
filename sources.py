

import os
import attr
import re

from glob import glob


@attr.s
class Corpus:

    path = attr.ib()

    def __iter__(self):
        with open(self.path) as fh:
            for line in fh:
                yield re.findall('\w+', line.lower())
