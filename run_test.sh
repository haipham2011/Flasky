#!/bin/bash

# Run Flask server in background
./run.sh &

# Run tests
mkdir test/api_tests/results
mkdir test/ui_tests/results

cd test/api_tests/results
robot ../
cd ../../ui_tests/results
robot ../

# Shutdown Flask server
kill $(lsof -t -i:8080)