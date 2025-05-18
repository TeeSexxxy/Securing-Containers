This project is a **containerized Python Flask web application** with security hardening applied at the application and Docker levels. It includes secure code practices, hardened Dockerfile, a `docker-compose.yml` setup, and automated tests to verify protection against common vulnerabilities.
Features
- Secure endpoints with validation
-  Hardened Docker container:
  - Minimal base image
  - Non-root user
  - Healthcheck
  - Read-only filesystem
- Automated test script for security checks
-  Multi-stage Docker build
- `docker-compose` for easy orchestration

Getting Started
1. Clone the Repository
git clone https://github.com/gwuml/seas-8405/tree/main/week-7/homework7
cd secure-flask-app
2. Build and Run the App
docker-compose up --build
The web app will run on:
http://127.0.0.1:15000/
3. Test the Endpoints
You can test using a browser or curl:
curl http://127.0.0.1:15000/
curl http://127.0.0.1:15000/ping?ip=8.8.8.8
curl http://127.0.0.1:15000/calculate?expr=2+3

4. Run Security Test Suite
chmod +x test_hardened_app.sh
./test_hardened_app.sh
This will verify:
Endpoint security
Command injection prevention
Eval protection
Container read-only filesystem
Healthcheck status
CONCLUSION
 Security Hardening Summary
 Removed command injection and eval
 Input validation added
 Docker:
Alpine base image
Runs as non-root user
Read-only filesystem
Memory and PID limits
Healthcheck

Secrets managed via .env file (not committed)
