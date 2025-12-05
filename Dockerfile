FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY main.py .

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Default mode: polling (untuk development)
ENV BOT_MODE=polling

# Webhook otomatis terdeteksi dari:
# - WEBHOOK_URL (prioritas 1)
# - APP_DOMAIN (prioritas 2) 
# - VIRTUAL_HOST (prioritas 3, untuk nginx-proxy)
# Jika tidak diset, path akan auto-generate

EXPOSE 5000

CMD ["python", "main.py"]
