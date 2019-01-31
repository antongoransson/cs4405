#!/bin/bash
rm -rf /tmp/processing
mkdir /tmp/processing
~/processing-3.5.2/processing-java --output=/tmp/processing/ --force --sketch=$1 --run