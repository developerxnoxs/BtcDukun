# Troubleshooting Guide - Termux Installation

## Error: JSONDecodeError: Expecting value: line 1 column 1 (char 0)

### Penyebab:
- Yahoo Finance API return rate limit (HTTP 429)
- Network issue di Termux
- yfinance version lama yang tidak handle rate limit

### Solusi:

#### **Step 1: Upgrade yfinance ke versi terbaru**
```bash
pip uninstall yfinance -y
pip install yfinance>=0.2.54 --no-cache-dir --upgrade
```

#### **Step 2: Verifikasi instalasi**
```bash
python -c "import yfinance as yf; print('yfinance version:', yf.__version__)"
```

Output harus: `yfinance version: 0.2.54` atau lebih tinggi

#### **Step 3: Test dengan retry logic**
```bash
python -c "
import yfinance as yf
import time

symbols = ['GLD', 'IAU', 'GC=F']
for s in symbols:
    try:
        print(f'Testing {s}...')
        df = yf.download(s, period='1d', progress=False)
        if not df.empty:
            print(f'{s}: OK - Last price: {df.iloc[-1][\"Close\"]:.2f}')
            break
        else:
            print(f'{s}: Empty')
    except Exception as e:
        print(f'{s}: Error - {e}')
        time.sleep(5)
"
```

---

## Error: ModuleNotFoundError: No module named 'curl_cffi'

### Solusi:
```bash
pip uninstall curl-cffi -y
```
yfinance otomatis fallback ke `requests` library.

---

## Bot tidak start

### 1. Check Python version
```bash
python --version
# Harus: Python 3.11+
```

### 2. Check TELEGRAM_BOT_TOKEN
```bash
echo $TELEGRAM_BOT_TOKEN
# Harus keluar token (jangan kosong)
```

### 3. Run bot dengan debug
```bash
python xau_analyzer.py
# Atau
python btc_analyzer.py
```

### 4. Check error messages
Bot akan print error jika:
- Token tidak ditemukan
- Gemini API key tidak ditemukan  
- Yahoo Finance down

---

## Network Issue di Termux

Jika terus dapat error koneksi:

### 1. Check network
```bash
ping google.com
# Harus reply (bukan Connection refused)
```

### 2. Restart network (jika perlu)
```bash
# Matikan WiFi dan nyalakan lagi
# Atau use mobile data
```

### 3. Try VPN (jika IP blocked)
```bash
# Install VPN app di Termux atau gunakan ProtonVPN
```

---

## Memory/Storage Issue

Jika error "No space left" atau "Memory limit":

### Check storage
```bash
df -h
# Pastikan /data punya space >500MB
```

### Clean cache
```bash
pip cache purge
rm -rf ~/.cache/pip
```

---

## Slow/Timeout Issues

### Gunakan retry dengan delay
Bot sudah otomatis dengan:
- Retry 3x per symbol
- Delay 5-10 detik antar retry
- Fallback ke symbol lain (GLD, IAU)

Jika masih timeout:
```bash
# Add manual delay di script
time.sleep(10)  # 10 detik
```

---

## File Structure Check

```bash
# Verifikasi semua file ada
ls -la *.py
# Harus ada:
# - btc_analyzer.py
# - xau_analyzer.py
# - main.py

ls -la *.txt *.sh *.md
# Harus ada:
# - requirements.txt
# - setup.sh
# - run_bot.sh
```

---

## Full Fresh Install

Jika semua gagal, bersihkan dan install ulang:

```bash
# 1. Backup .bashrc jika ada konfigurasi penting
cp ~/.bashrc ~/.bashrc.backup

# 2. Uninstall packages
pip uninstall yfinance pandas numpy curl-cffi -y

# 3. Clear cache
pip cache purge

# 4. Run setup ulang
./setup.sh

# 5. Test
python -c "import yfinance as yf; print('OK')"
```

---

## Environment Variables

Pastikan sudah di-set di Termux:

```bash
# Check
echo $TELEGRAM_BOT_TOKEN
echo $TELEGRAM_BOT_TOKEN_XAU
echo $GEMINI_API_KEY

# Set (temporary)
export TELEGRAM_BOT_TOKEN='your_token'

# Set permanent (tambah ke ~/.bashrc)
echo "export TELEGRAM_BOT_TOKEN='your_token'" >> ~/.bashrc
```

---

## Contact & Support

Jika masih error:
1. Copy full error message
2. Check log file (jika ada)
3. Try alternative: use GLD atau IAU di setup
