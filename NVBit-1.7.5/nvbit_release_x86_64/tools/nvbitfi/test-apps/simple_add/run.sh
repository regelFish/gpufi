#!/bin/bash
eval ${PRELOAD_FLAG} ${BIN_DIR}/simple_add > stdout.txt 2> >(grep -v "WARNING: Do not call CUDA memory allocation in nvbit_at_ctx_init(). It will cause deadlocks. Do them in nvbit_tool_init(). If you encounter deadlocks, remove CUDA API calls to debug." > stderr.txt)

