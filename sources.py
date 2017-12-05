

import attr
import os
import re

from glob import glob


@attr.s
class LineCorpus:

    root = attr.ib()

    def paths(self):
        return glob(os.path.join(self.root, '*.txt'))

    def __iter__(self):
        for path in self.paths():
            with open(path) as fh:
                for line in fh:
                    yield re.findall('[#@\w]+', line.lower())
