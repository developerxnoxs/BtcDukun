# Panduan Deployment Docker - Trading Analysis Bot

## Prasyarat

- Docker Engine 20.10+
- Docker Compose 2.0+

## Mode Bot

Bot mendukung 2 mode operasi:

| Mode | Kegunaan | Keterangan |
|------|----------|------------|
| **Polling** | Development | Default, tidak perlu URL publik |
| **Webhook** | Production | Lebih efisien, butuh URL publik (HTTPS) |

## Auto-Detect Webhook (Baru!)

Bot secara otomatis mendeteksi webhook URL dari environment variables:

| Prioritas | Variable | Contoh |
|-----------|----------|--------|
| 1 | `WEBHOOK_URL` | `https://bot.example.com` |
| 2 | `APP_DOMAIN` | `bot.example.com` |
| 3 | `VIRTUAL_HOST` | `bot.example.com` (nginx-proxy) |

**Webhook path juga auto-generate** jika tidak diset manual.

## Langkah Deployment

### 1. Clone atau Copy Project

```bash
git clone <repository-url>
cd trading-analysis-bot
```

### 2. Buat File Environment

**Mode Polling (Development):**
```bash
# .env
TELEGRAM_BOT_TOKEN=your_token
GEMINI_API_KEY=your_key
BOT_MODE=polling
```

**Mode Webhook (Production) - Auto-detect:**
```bash
# .env
TELEGRAM_BOT_TOKEN=your_token
GEMINI_API_KEY=your_key
BOT_MODE=webhook
APP_DOMAIN=bot.yourdomain.com
```

### 3. Build dan Jalankan

```bash
docker-compose up -d --build
```

### 4. Cek Log & Status

```bash
docker-compose logs -f trading-bot
```

Output saat auto-detect berhasil:
```
✓ WEBHOOK_URL: https://bot.yourdomain.com (auto-detect)
✓ WEBHOOK_PATH: /webhook_abc12345 (auto-generate)
```

### 5. Stop Bot

```bash
docker-compose down
```

## Environment Variables

| Variable | Deskripsi | Default |
|----------|-----------|---------|
| `TELEGRAM_BOT_TOKEN` | Token bot dari @BotFather | - (wajib) |
| `GEMINI_API_KEY` | API key dari Google AI Studio | - (opsional) |
| `BOT_MODE` | `polling` atau `webhook` | `polling` |
| `APP_DOMAIN` | Domain aplikasi (auto-detect webhook) | - |
| `VIRTUAL_HOST` | Domain untuk nginx-proxy | - |
| `WEBHOOK_URL` | URL lengkap webhook (override auto) | - |
| `WEBHOOK_PORT` | Port webhook server | `5000` |
| `WEBHOOK_PATH` | Path webhook (auto-generate jika kosong) | - |

## Contoh Deployment

### Docker Compose Standar

```bash
# .env
TELEGRAM_BOT_TOKEN=123456:ABC...
GEMINI_API_KEY=AIza...
BOT_MODE=webhook
APP_DOMAIN=trading-bot.example.com
```

```bash
docker-compose up -d --build
```

### Dengan Nginx Reverse Proxy

```bash
# .env
TELEGRAM_BOT_TOKEN=123456:ABC...
GEMINI_API_KEY=AIza...
BOT_MODE=webhook
VIRTUAL_HOST=trading-bot.example.com
LETSENCRYPT_HOST=trading-bot.example.com
```

Bot akan otomatis menggunakan `VIRTUAL_HOST` sebagai webhook URL.

### Dengan Traefik

```yaml
services:
  trading-bot:
    labels:
      - "traefik.http.routers.bot.rule=Host(`bot.example.com`)"
    environment:
      - APP_DOMAIN=bot.example.com
      - BOT_MODE=webhook
```

## Perintah Berguna

| Perintah | Fungsi |
|----------|--------|
| `docker-compose up -d` | Jalankan di background |
| `docker-compose down` | Hentikan |
| `docker-compose restart` | Restart |
| `docker-compose logs -f` | Log realtime |
| `docker-compose build --no-cache` | Rebuild |

## Troubleshooting

### Cek mode yang aktif
```bash
docker-compose logs trading-bot | grep "BOT_MODE"
```

### Webhook tidak terdeteksi
Pastikan salah satu variabel ini diset:
- `WEBHOOK_URL`
- `APP_DOMAIN`  
- `VIRTUAL_HOST`

### Bot fallback ke polling
Jika webhook URL tidak terdeteksi, bot otomatis fallback ke mode polling.

### Rebuild setelah update
```bash
docker-compose down && docker-compose up -d --build
```

## Catatan Keamanan

- Jangan commit file `.env` ke repository
- Gunakan Docker secrets untuk production
- Pastikan SSL certificate valid untuk webhook
- Batasi akses port 5000 dari reverse proxy saja
