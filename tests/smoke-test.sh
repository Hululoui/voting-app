#!/bin/bash

BASE_URL="http://localhost:8080"

echo "=== Smoke Test ==="

echo "Test 1 - GET page principale"
curl -f $BASE_URL || exit 1
echo "✅ OK"

echo "Test 2 - POST vote Cats"
curl -f -X POST $BASE_URL -d "vote=Cats" || exit 1
echo "✅ OK"

echo "Test 3 - POST vote Dogs"
curl -f -X POST $BASE_URL -d "vote=Dogs" || exit 1
echo "✅ OK"

echo "Test 4 - Reset"
curl -f -X POST $BASE_URL -d "vote=reset" || exit 1
echo "✅ OK"

echo "=== Tous les tests sont passés ==="
