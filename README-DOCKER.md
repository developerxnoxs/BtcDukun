# Panduan Deployment Docker - Trading Analysis Bot

## Prasyarat

- Docker Engine 20.10+
- Docker Compose 2.0+

## Langkah Deployment

### 1. Clone atau Copy Project

```bash
git clone <repository-url>
cd trading-analysis-bot
```

### 2. Buat File Environment

Buat file `.env` di folder project:

```bash
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
GEMINI_API_KEY=your_gemini_api_key_here
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
└── logs/               # Folder log (auto-generated)
```
