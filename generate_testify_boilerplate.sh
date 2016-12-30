#!/bin/bash

file="$1"
mockname="$2"
methods=$(cat "$file" | grep "func (" | sed -E "s/func \([^\(]*\) //g" | sed -E "s/ {//g")

echo "$methods" | while read line
do
	arguments=$(echo "$line" | egrep -o "([a-zA-Z\.\*]+)\s")
	returnTypesWithBracket=$(echo "$line" | egrep -o "\)\s.*$")
	returnTypes=$(echo "${returnTypesWithBracket:2}")

	echo "func (m *$mockname) $line {"

	if [ ! -z "$returnTypes" -a "$returnTypes" != " " ]; then
		if [ ! -z "$arguments" -a "$arguments" != " " ]; then
			argumentsList=$(echo "$arguments" | tr ' ' ',' | tr '\n' ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | sed 's/.\{1\}$//')
			echo "	args := m.Called($argumentsList)"

			echo "	return args.Get(0).($returnTypes)"
		else
			returnValues=$(echo "$returnTypes" | sed 's/bool/true/' | sed 's/int/5/' | sed "s/int64/int64(5)/"  | sed 's/string/"test"/')
			echo "	return $returnValues"
		fi
	fi

	echo "}"
	echo ""
done
