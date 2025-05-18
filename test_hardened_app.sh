#!/bin/bash

set -e
echo "========================="
echo "✅ Starting Test Suite"
echo "========================="

echo ""
echo "[1] Testing root endpoint..."
curl -s http://127.0.0.1:5000/ | grep "Hello, World!" && echo "✔ Root endpoint works"

echo ""
echo "[2] Testing /ping with valid IP..."
curl -s "http://127.0.0.1:5000/ping?ip=8.8.8.8" | grep "PING" && echo "✔ Ping works"

echo ""
echo "[3] Testing /ping with invalid IP..."
curl -s "http://127.0.0.1:5000/ping?ip=badinput" | grep "Invalid IP" && echo "✔ Command injection prevented"

echo ""
echo "[4] Testing /calculate with safe input..."
curl -s "http://127.0.0.1:5000/calculate?expr=2+3" | grep "5" && echo "✔ Safe eval works"

echo ""
echo "[5] Testing /calculate with malicious input..."
curl -s "http://127.0.0.1:5000/calculate?expr=__import__('os').system('ls')" | grep "Invalid expression" && echo "✔ Unsafe eval blocked"

echo ""
echo "[6] Checking container settings..."
CID=$(docker ps -qf "ancestor=$(docker images --format '{{.Repository}}:{{.Tag}}' | head -n 1)")
docker inspect $CID | grep -q '"ReadonlyRootfs": true' && echo "✔ Read-only filesystem enabled"
docker inspect $CID | grep -q '"NoNewPrivileges": true' && echo "✔ No new privileges enabled"

echo ""
echo "[7] Checking container health status..."
docker inspect --format='{{.State.Health.Status}}' $CID | grep "healthy" && echo "✔ Healthcheck passed"

echo ""
echo "========================="
echo "��� All Tests Passed"
echo "========================="
#!/bin/bash

set -e
echo "========================="
echo "✅ Starting Test Suite"
echo "========================="

echo ""
echo "[1] Testing root endpoint..."
curl -s http://127.0.0.1:5000/ | grep "Hello, World!" && echo "✔ Root endpoint works"

echo ""
echo "[2] Testing /ping with valid IP..."
curl -s "http://127.0.0.1:5000/ping?ip=8.8.8.8" | grep "PING" && echo "✔ Ping works"

echo ""
echo "[3] Testing /ping with invalid IP..."
curl -s "http://127.0.0.1:5000/ping?ip=badinput" | grep "Invalid IP" && echo "✔ Command injection prevented"

echo ""
echo "[4] Testing /calculate with safe input..."
curl -s "http://127.0.0.1:5000/calculate?expr=2+3" | grep "5" && echo "✔ Safe eval works"

echo ""
echo "[5] Testing /calculate with malicious input..."
curl -s "http://127.0.0.1:5000/calculate?expr=__import__('os').system('ls')" | grep "Invalid expression" && echo "✔ Unsafe eval blocked"

echo ""
echo "[6] Checking container settings..."
CID=$(docker ps -qf "ancestor=$(docker images --format '{{.Repository}}:{{.Tag}}' | head -n 1)")
docker inspect $CID | grep -q '"ReadonlyRootfs": true' && echo "✔ Read-only filesystem enabled"
docker inspect $CID | grep -q '"NoNewPrivileges": true' && echo "✔ No new privileges enabled"

echo ""
echo "[7] Checking container health status..."
docker inspect --format='{{.State.Health.Status}}' $CID | grep "healthy" && echo "✔ Healthcheck passed"

echo ""
echo "========================="
echo "��� All Tests Passed"
echo "========================="
