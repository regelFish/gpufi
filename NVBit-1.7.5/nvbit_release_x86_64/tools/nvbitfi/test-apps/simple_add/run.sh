#!/bin/bash
eval ${PRELOAD_FLAG} ${BIN_DIR}/simple_add > stdout.txt 2> >(grep -v "WARNING: Do not call CUDA memory allocation" > stderr.txt)

