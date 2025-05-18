# ===== Stage 1: Install dependencies =====
FROM python:3.9-slim AS builder

WORKDIR /app

# Install pip and dependencies
COPY requirements.txt .
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt

# ===== Stage 2: Final secure image =====
FROM python:3.9-slim

# Install wget for healthcheck
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Set working directory
WORKDIR /app

# Copy installed packages
COPY --from=builder /install /usr/local

# Copy app code
COPY . .

# Switch to non-root user
USER appuser

# Add HEALTHCHECK to monitor app
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --spider --quiet http://localhost:5000/ || exit 1

# Expose only if necessary
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
