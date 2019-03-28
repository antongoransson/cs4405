#! /bin/bash
#./prepare.sh
./fragment.sh && \
rm -rf output && \
./dash.sh && \
firefox index.html