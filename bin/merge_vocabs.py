#!/usr/bin/env python


import click

from sources import parse_glove_vocab, intersect_glove_vocabs


@click.command()
@click.argument('paths', nargs=-1, required=True)
def main(paths):
    """Merge Glove vocabs.
    """
    vocabs = [parse_glove_vocab(path) for path in paths]

    vocab = intersect_glove_vocabs(*vocabs)

    for token, count in vocab.most_common():
        click.echo(f'{token} {count}')


if __name__ == '__main__':
    main()
