#!/bin/bash

MAX_VOCAB=10000

VOCAB_COUNT_CMD=$(dirname $0)/glove/build/vocab_count
MERGE_VOCABS_CMD=$(dirname $0)/merge_vocabs.py

# All but last arg are corpora.
CORPUS_PATHS=${@:1:$#-1}

# Last arg is output.
MERGED_VOCAB_PATH=${!#}

VOCAB_DIR=$(dirname "${MERGED_VOCAB_PATH}")

VOCAB_PATHS=()
for path in $CORPUS_PATHS
do

  echo ${path}

  name=$(basename $path .txt)
  vpath=$VOCAB_DIR/.$name.vocab.txt

  $VOCAB_COUNT_CMD -max-vocab $MAX_VOCAB < $path > $vpath
  VOCAB_PATHS+=($vpath)

done

$MERGE_VOCABS_CMD ${VOCAB_PATHS[@]} > $MERGED_VOCAB_PATH

rm ${VOCAB_PATHS[@]}
