#!/bin/bash

CORPUS=$1
MODEL_PATH=$2
MODEL_DIR=$(dirname "${MODEL_PATH}")
VOCAB_FILE=$MODEL_DIR/vocab.txt
COOCCURRENCE_FILE=$MODEL_DIR/cooccurrence.bin
COOCCURRENCE_SHUF_FILE=$MODEL_DIR/cooccurrence.shuf.bin
BUILDDIR=glove/build
MEMORY=6.0
MAX_VOCAB=10000
VECTOR_SIZE=200
MAX_ITER=25
WINDOW_SIZE=15
BINARY=2
NUM_THREADS=8
X_MAX=10

$BUILDDIR/vocab_count \
  -max-vocab $MAX_VOCAB \
  < $CORPUS \
  > $MODEL_DIR/$VOCAB_FILE

$BUILDDIR/cooccur \
  -memory $MEMORY \
  -vocab-file $VOCAB_FILE \
  -window-size $WINDOW_SIZE \
  < $CORPUS \
  > $COOCCURRENCE_FILE

$BUILDDIR/shuffle \
  -memory $MEMORY \
  < $COOCCURRENCE_FILE \
  > $COOCCURRENCE_SHUF_FILE

$BUILDDIR/glove \
  -save-file $MODEL_PATH \
  -threads $NUM_THREADS \
  -input-file $COOCCURRENCE_SHUF_FILE \
  -iter $MAX_ITER \
  -vector-size $VECTOR_SIZE \
  -vocab-file $VOCAB_FILE
