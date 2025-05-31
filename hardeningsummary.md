# Docker Container Hardening Summary

## Flask App Security Enhancements
- ✅ Added `/health` endpoint for monitoring and health checks.
- ✅ Sanitized user input in `/` route.
-  Replace `eval()` and `shell=True` for production-safe code.

## Dockerfile Hardening
- ✅ Used minimal base image: `python:3.9-alpine`
- ✅ Added non-root user: `appuser`
- ✅ Used `--no-cache-dir` for pip installs
- ✅ Marked container `USER appuser`
- ✅ Included a `HEALTHCHECK` directive

## Docker Runtime Hardening
- ✅ `read_only: true`
- ✅ `--tmpfs /tmp`
- ✅ `--cap-drop ALL`
- ✅ Exposed ports only on `127.0.0.1`
- ✅ Limited memory & PIDs in `docker-compose.yml`

## Docker Compose Enhancements
- ✅ Port binding: `"127.0.0.1:15000:5000"`
- ✅ Memory limit: `mem_limit: 256m`
- ✅ Process cap: `pids_limit: 100`
- ✅ `security_opt: no-new-privileges:true`
- ✅ Config loaded via `.env` file (sensitive vars not committed)

- Replace `eval()` with a safe expression parser (e.g., `ast.literal_eval`, `simpleeval`)
-  Avoid `shell=True` in `subprocess` usage
- Replace Flask dev server with production WSGI (e.g., Gunicorn)
