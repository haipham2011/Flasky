#!/bin/bash

# Run Flask server in background
./run.sh &

# Run tests
mkdir test/api_tests/results
mkdir test/ui_tests/results

# Wait for the server starting up
echo "Waiting to launch server on 8080..."

while ! nc -z localhost 8080; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

echo "Server launched!"
echo "Start testing..."

cd test/api_tests/results
robot ../
cd ../../ui_tests/results
robot ../

# # Shutdown Flask server
kill $(lsof -t -i:8080)
echo "Finish testing!"

