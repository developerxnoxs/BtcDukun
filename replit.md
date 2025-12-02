# Overview

This is a multi-cryptocurrency and forex/commodities technical analysis bot system that provides automated technical analysis through Telegram. The system consists of two separate bot implementations: one for cryptocurrency analysis (BTC, ETH, SOL, BNB, XRP, ADA, DOGE, AVAX, MATIC, LINK, DOT, ATOM, UNI, LTC) and another for forex pairs and commodities (XAUUSD, XAGUSD, EURUSD, GBPUSD, USDJPY, USDCHF). Both bots leverage Gemini AI Vision API for chart analysis and provide interactive command interfaces through Telegram.

# User Preferences

Preferred communication style: Simple, everyday language.

# System Architecture

## Bot Architecture

The system implements two independent Telegram bot instances:
- **Crypto Bot** (`btc_analyzer.py`): Handles cryptocurrency technical analysis
- **Forex/Commodities Bot** (`xau_analyzer.py`): Handles forex pairs and precious metals analysis

Each bot operates as a standalone Python application using the python-telegram-bot library with an async/await pattern for handling user interactions.

## Data Source Strategy

Both bots now use a unified fallback mechanism for market data retrieval:

### Forex/Commodities Bot (xau_analyzer.py):
1. **Primary Source**: TradingView DataFeed (`tvDatafeed`) - Exchanges: OANDA, FXCM, FX_IDC, FOREXCOM, CAPITALCOM
2. **Fallback Source**: Yahoo Finance (`yfinance`) - Used when TradingView is unavailable

### Crypto Bot (btc_analyzer.py):
1. **Primary Source**: TradingView DataFeed (`tvDatafeed`) - Exchanges: BINANCE, BYBIT, COINBASE, KRAKEN, BITSTAMP
2. **Secondary Fallback**: Yahoo Finance (`yfinance`) - Used when TradingView is unavailable
3. **Tertiary Fallback**: KuCoin API - Used when both TradingView and Yahoo Finance fail

This multi-source approach ensures reliability, with graceful degradation if primary data sources fail. The system checks availability at runtime using try-except imports.

## Chart Generation

Technical analysis charts are generated using `mplfinance` (matplotlib finance), which creates candlestick charts with technical indicators. Charts are:
- Generated on-demand based on user requests
- Stored temporarily in memory
- Encoded to base64 for API transmission
- Not persisted to disk (stateless design)

## AI Analysis Integration

The system integrates Google's Gemini AI Vision API for intelligent chart interpretation:
- Chart images are sent as base64-encoded data to Gemini API
- The AI provides technical analysis including trend detection, support/resistance levels, and trading suggestions
- Results are formatted and returned to users through Telegram

This architecture separates data visualization from AI interpretation, allowing for independent scaling and updates to either component.

## Interactive User Interface

The Telegram interface uses inline keyboards for navigation:
- Coin/pair selection menus
- Timeframe selection (1H, 4H, 1D intervals)
- Command-based interaction pattern (`/start`, `/analyze`, etc.)

The callback query handler pattern enables stateful navigation without requiring conversation state management.

## Configuration Management

Environment-based configuration for sensitive credentials:
- `TELEGRAM_BOT_TOKEN` - Main crypto bot authentication
- `TELEGRAM_BOT_TOKEN_XAU` - Forex/commodities bot authentication  
- `GEMINI_API_KEY` - AI vision API authentication

This approach keeps secrets out of code and allows for environment-specific deployments.

# External Dependencies

## Third-Party APIs

1. **Telegram Bot API**: Real-time messaging platform for user interaction and command handling
2. **Google Gemini AI Vision API**: AI-powered chart analysis and technical interpretation
3. **TradingView DataFeed**: Primary source for financial market data (cryptocurrency and forex)
4. **Yahoo Finance API** (via yfinance): Fallback data source for market prices

## Python Libraries

- **python-telegram-bot**: Telegram bot framework with async support
- **tvDatafeed**: TradingView data connector
- **yfinance**: Yahoo Finance data connector
- **mplfinance**: Financial charting and candlestick visualization
- **pandas**: Data manipulation and time-series handling
- **requests**: HTTP client for API calls
- **pytz**: Timezone handling for global market hours

## Runtime Environment

- Python 3.x runtime
- No database requirements (stateless architecture)
- Environment variable support for configuration
- Supports multiple concurrent bot instances