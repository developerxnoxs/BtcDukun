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
# Ubah ke webhook untuk production
ENV BOT_MODE=polling
ENV WEBHOOK_PORT=5000
ENV WEBHOOK_PATH=/webhook

# Expose port untuk webhook mode
EXPOSE 5000

CMD ["python", "main.py"]
