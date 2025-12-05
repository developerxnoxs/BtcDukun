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

## Langkah Deployment

### 1. Clone atau Copy Project

```bash
git clone <repository-url>
cd trading-analysis-bot
```

### 2. Buat File Environment

Buat file `.env` di folder project:

**Mode Polling (Development):**
```bash
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
GEMINI_API_KEY=your_gemini_api_key_here
BOT_MODE=polling
```

**Mode Webhook (Production):**
```bash
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
GEMINI_API_KEY=your_gemini_api_key_here
BOT_MODE=webhook
WEBHOOK_URL=https://your-domain.com
WEBHOOK_PORT=5000
WEBHOOK_PATH=/webhook
```

### 3. Build dan Jalankan

```bash
docker-compose up -d --build
```

### 4. Cek Status Bot

```bash
docker-compose logs -f trading-bot
```

### 5. Stop Bot

```bash
docker-compose down
```

## Konfigurasi Environment Variables

| Variable | Deskripsi | Default |
|----------|-----------|---------|
| `TELEGRAM_BOT_TOKEN` | Token bot dari @BotFather | - (wajib) |
| `GEMINI_API_KEY` | API key dari Google AI Studio | - (opsional) |
| `BOT_MODE` | Mode bot: `polling` atau `webhook` | `polling` |
| `WEBHOOK_URL` | URL publik untuk webhook (HTTPS) | - |
| `WEBHOOK_PORT` | Port untuk webhook server | `5000` |
| `WEBHOOK_PATH` | Path endpoint webhook | `/webhook` |

## Deployment Production dengan Webhook

### Menggunakan Nginx Reverse Proxy

1. Jalankan bot dengan mode webhook:
```bash
BOT_MODE=webhook
WEBHOOK_URL=https://your-domain.com
```

2. Konfigurasi Nginx:
```nginx
server {
    listen 443 ssl;
    server_name your-domain.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location /webhook {
        proxy_pass http://localhost:5000/webhook;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

3. Restart Nginx dan jalankan bot:
```bash
sudo systemctl restart nginx
docker-compose up -d --build
```

## Perintah Berguna

| Perintah | Fungsi |
|----------|--------|
| `docker-compose up -d` | Jalankan bot di background |
| `docker-compose down` | Hentikan bot |
| `docker-compose restart` | Restart bot |
| `docker-compose logs -f` | Lihat log realtime |
| `docker-compose build --no-cache` | Rebuild image dari awal |

## Troubleshooting

### Bot tidak merespon
```bash
docker-compose logs trading-bot
```

### Cek mode yang aktif
Lihat log saat startup, akan muncul:
- `Mode: POLLING (Development)` - jika mode polling
- `Mode: WEBHOOK (Production)` - jika mode webhook

### Webhook tidak bekerja
1. Pastikan `WEBHOOK_URL` sudah benar dan menggunakan HTTPS
2. Pastikan port 5000 terbuka dan dapat diakses dari internet
3. Cek apakah SSL certificate valid

### Rebuild setelah update code
```bash
docker-compose down
docker-compose up -d --build
```

### Hapus semua data dan mulai fresh
```bash
docker-compose down -v
docker system prune -a
docker-compose up -d --build
```

## Struktur File

```
trading-analysis-bot/
├── main.py              # Kode utama bot
├── requirements.txt     # Dependencies Python
├── Dockerfile          # Konfigurasi Docker image
├── docker-compose.yml  # Konfigurasi Docker Compose
├── .dockerignore       # File yang diabaikan saat build
├── .env                # Environment variables (buat sendiri)
├── .env.example        # Template environment variables
└── logs/               # Folder log (auto-generated)
```

## Catatan Keamanan

- Jangan commit file `.env` ke repository
- Gunakan Docker secrets untuk production
- Pastikan SSL certificate valid untuk webhook
- Batasi akses port 5000 hanya dari reverse proxy
