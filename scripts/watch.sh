#!/bin/bash

BASE_DIR=`dirname $0`

echo ""
echo " watching " 
echo "-------------------------------------------------------------------"

coffee --watch --compile --bare --output  $BASE_DIR/../ $BASE_DIR/../src 