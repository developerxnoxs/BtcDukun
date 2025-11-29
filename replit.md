# BTC/USDT Technical Analysis Bot

## Overview
Tool CLI berbasis Python untuk analisa teknikal BTC/USDT menggunakan Telegram Bot dan Gemini AI Vision. Bot ini mengambil data candlestick dari KuCoin, generate chart dengan indikator teknikal, dan menganalisa menggunakan AI.

## Current State
- Bot aktif dan berjalan
- Terintegrasi dengan KuCoin API untuk data harga
- Menggunakan Gemini Vision API untuk analisa chart
- Telegram bot untuk interface user

## Project Architecture

### Main Files
- `btc_analyzer.py` - Script utama bot

### Dependencies
- python-telegram-bot: Telegram bot framework
- mplfinance: Chart candlestick generator
- pandas: Data processing
- requests: HTTP client untuk API calls
- pytz: Timezone handling

### Environment Variables (Secrets)
- `TELEGRAM_BOT_TOKEN` - Token dari @BotFather
- `GEMINI_API_KEY` - API key dari Google AI Studio

## Features
1. Fetch data BTC/USDT dari KuCoin dengan berbagai timeframe (1m, 5m, 15m, 1h, 4h, 1d)
2. Generate chart candlestick dengan EMA20 dan EMA50
3. Analisa teknikal menggunakan Gemini Vision AI
4. Hasil analisa termasuk: Sinyal, Entry, TP, SL, Pola, Trend, Support/Resistance

## Telegram Commands
- `/start` - Pilih timeframe dengan inline keyboard
- `/analyze <timeframe>` - Analisa langsung (contoh: /analyze 15min)
- `/help` - Panduan penggunaan

## Recent Changes
- 2025-11-29: Script diperbaiki dengan proper async handling untuk CLI
- 2025-11-29: Improved Gemini API integration dengan better prompt
- 2025-11-29: Added error handler untuk conflict detection
- 2025-11-29: Added drop_pending_updates untuk menghindari conflict

## User Preferences
- Bahasa: Indonesia
- Ini adalah CLI tool, bukan web app
