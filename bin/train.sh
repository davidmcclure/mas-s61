#!/bin/bash

python bin/train_w2v.py /mnt/midwest.txt /mnt/midwest.bin
python bin/train_w2v.py /mnt/northeast.txt /mnt/northeast.bin
python bin/train_w2v.py /mnt/west.txt /mnt/west.bin
python bin/train_w2v.py /mnt/south.txt /mnt/south.bin
