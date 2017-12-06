

import os
import attr
import re

from collections import OrderedDict, Counter
from glob import glob


@attr.s
class Corpus:

    path = attr.ib()

    def __iter__(self):
        with open(self.path) as fh:
            for line in fh:
                yield re.findall('\w+', line.lower())


def parse_glove_vocab(path):
    """Parse a Glove vocab count file.
    """
    vocab = OrderedDict()

    with open(path) as fh:
        for line in fh:

            try:
                token, count = line.strip().split()
                vocab[token] = int(count)
            except Exception as e:
                print(e)

    return vocab


def intersect_glove_vocabs(*vocabs):
    """Intersect word types, sum counts.
    """
    tokens = set.intersection(*[set(v.keys()) for v in vocabs])

    vocab = Counter()

    for token in tokens:
        vocab[token] = sum([v[token] for v in vocabs])

    return vocab
