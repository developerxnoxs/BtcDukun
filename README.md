# Crypto & Forex Technical Analysis Bots

This project contains two Telegram bots for technical analysis using AI-powered chart analysis with Google Gemini Vision.

## Features

### BTC Analyzer Bot (btc_analyzer.py)
- **14 Cryptocurrencies supported**: BTC, ETH, SOL, BNB, XRP, ADA, DOGE, AVAX, MATIC, LINK, DOT, ATOM, UNI, LTC
- Multi-source data fetching (TradingView, Yahoo Finance, KuCoin)
- Real-time candlestick charts with EMA20 & EMA50 indicators
- AI-powered technical analysis using Gemini Vision
- Multiple timeframes: 1m, 5m, 15m, 30m, 1h, 4h, 1d, 1w

### Forex Analyzer Bot (xau_analyzer.py)
- **16 Forex pairs & Commodities**:
  - Commodities: XAUUSD (Gold), XAGUSD (Silver), USOIL
  - Major Pairs: EURUSD, GBPUSD, USDJPY, USDCHF, AUDUSD, USDCAD, NZDUSD
  - Cross Pairs: EURGBP, EURJPY, GBPJPY, AUDJPY, EURAUD, EURCHF
- Data from TradingView and Yahoo Finance
- Technical analysis with price levels, patterns, and signals
- Timeframes: 1m, 5m, 15m, 30m, 1h, 4h, 1d

## Setup Instructions

### Required Environment Variables

Before running the bots, you need to set these environment variables:

1. **TELEGRAM_BOT_TOKEN** - Token for the BTC Analyzer Bot
   - Get it from [@BotFather](https://t.me/BotFather) on Telegram
   
2. **TELEGRAM_BOT_TOKEN_XAU** - Token for the Forex Analyzer Bot
   - Get it from [@BotFather](https://t.me/BotFather) on Telegram
   
3. **GEMINI_API_KEY** - Google Gemini API key for AI analysis
   - Get it from [Google AI Studio](https://aistudio.google.com/app/apikey)

### How to Run

1. Set up your environment variables in the Replit Secrets panel
2. Run the BTC Analyzer Bot using the "BTC Analyzer Bot" workflow
3. Run the Forex Analyzer Bot using the "Forex Analyzer Bot" workflow

### Usage

Once the bots are running:
1. Start a chat with your bot on Telegram
2. Send `/start` to begin
3. Select the cryptocurrency or forex pair you want to analyze
4. Choose your preferred timeframe
5. Receive the chart and AI-powered analysis

## Analysis Output

The bots provide:
- **SINYAL**: Buy/Sell/Hold recommendation with reasoning
- **ENTRY**: Suggested entry price
- **TAKE PROFIT**: TP1 and TP2 targets
- **STOP LOSS**: Risk management level
- **POLA**: Candlestick patterns detected
- **TREND**: Current market trend
- **SUPPORT/RESISTANCE**: Key price levels
- **KESIMPULAN**: Summary of the analysis

## Dependencies

All required packages are already installed:
- python-telegram-bot (Telegram integration)
- yfinance (Yahoo Finance data)
- xnoxs-fetcher (TradingView data)
- mplfinance (Chart generation)
- pandas (Data processing)
- requests (API calls)
- pillow (Image handling)

## Project Structure

```
├── btc_analyzer.py     # Cryptocurrency analysis bot
├── xau_analyzer.py     # Forex & commodities analysis bot
├── main.py             # Simple entry point
├── pyproject.toml      # Python dependencies
└── README.md           # This file
```

## Notes

- The bots use multiple data sources with automatic fallback for reliability
- Charts are generated with candlestick patterns and EMA indicators
- AI analysis is performed using Google's Gemini 2.0 Flash model
- All timestamps are in Asia/Jakarta timezone (WIB)
- This is for educational and informational purposes only - not financial advice
