

import click
import logging
import gensim

from sources import LineCorpus


logging.basicConfig(
    format='%(asctime)s : %(levelname)s : %(message)s',
    level=logging.INFO,
)


@click.command()
@click.argument('corpus_path', type=click.Path())
@click.argument('model_path', type=click.Path())
@click.option('--size', default=200)
@click.option('--min_count', default=1000)
@click.option('--workers', default=20)
def main(corpus_path, model_path, size, min_count, workers):

    sentences = LineCorpus(corpus_path)

    model = gensim.models.Word2Vec(
        sentences,
        size=size,
        min_count=min_count,
        workers=workers,
    )

    model.save(model_path)


if __name__ == '__main__':
    main()
