#!/bin/bash

file="$1"
cat "$file" | grep "func (" | sed -E "s/func \([^\(]*\) //g" | sed -E "s/ {//g"
