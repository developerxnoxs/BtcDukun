#!/bin/bash

echo "=============================================="
echo "  BTC & XAU Analyzer Bot Runner"
echo "=============================================="
echo ""

# Cek environment variables
check_env() {
    if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
        echo "[!] TELEGRAM_BOT_TOKEN belum di-set!"
        echo "    Jalankan: export TELEGRAM_BOT_TOKEN='your_token'"
        return 1
    fi
    
    if [ -z "$TELEGRAM_BOT_TOKEN_XAU" ]; then
        echo "[!] TELEGRAM_BOT_TOKEN_XAU belum di-set!"
        echo "    Jalankan: export TELEGRAM_BOT_TOKEN_XAU='your_token'"
        return 1
    fi
    
    if [ -z "$GEMINI_API_KEY" ]; then
        echo "[!] GEMINI_API_KEY belum di-set!"
        echo "    Jalankan: export GEMINI_API_KEY='your_key'"
        return 1
    fi
    
    return 0
}

# Menu pilihan
echo "Pilih opsi:"
echo "1. Jalankan BTC Analyzer Bot"
echo "2. Jalankan XAU Analyzer Bot"
echo "3. Jalankan KEDUA bot (background)"
echo "4. Stop semua bot"
echo "5. Lihat status bot"
echo "6. Set Environment Variables"
echo ""
read -p "Masukkan pilihan (1-6): " choice

case $choice in
    1)
        check_env || exit 1
        echo "Starting BTC Analyzer Bot..."
        python btc_analyzer.py
        ;;
    2)
        check_env || exit 1
        echo "Starting XAU Analyzer Bot..."
        python xau_analyzer.py
        ;;
    3)
        check_env || exit 1
        echo "Starting both bots in background..."
        nohup python btc_analyzer.py > btc_log.txt 2>&1 &
        echo "BTC Bot PID: $!"
        nohup python xau_analyzer.py > xau_log.txt 2>&1 &
        echo "XAU Bot PID: $!"
        echo ""
        echo "Bot berjalan di background!"
        echo "Lihat log: tail -f btc_log.txt atau tail -f xau_log.txt"
        ;;
    4)
        echo "Stopping all Python bots..."
        pkill -f "python btc_analyzer.py"
        pkill -f "python xau_analyzer.py"
        echo "All bots stopped."
        ;;
    5)
        echo "Status bot:"
        echo "----------------------------------------------"
        ps aux | grep -E "(btc_analyzer|xau_analyzer)" | grep -v grep
        if [ $? -ne 0 ]; then
            echo "Tidak ada bot yang berjalan."
        fi
        ;;
    6)
        echo ""
        echo "Masukkan environment variables:"
        echo "----------------------------------------------"
        read -p "TELEGRAM_BOT_TOKEN (BTC): " btc_token
        read -p "TELEGRAM_BOT_TOKEN_XAU: " xau_token
        read -p "GEMINI_API_KEY: " gemini_key
        
        # Simpan ke .bashrc
        echo "" >> ~/.bashrc
        echo "# Bot Analyzer Environment Variables" >> ~/.bashrc
        echo "export TELEGRAM_BOT_TOKEN='$btc_token'" >> ~/.bashrc
        echo "export TELEGRAM_BOT_TOKEN_XAU='$xau_token'" >> ~/.bashrc
        echo "export GEMINI_API_KEY='$gemini_key'" >> ~/.bashrc
        
        # Set untuk session ini
        export TELEGRAM_BOT_TOKEN="$btc_token"
        export TELEGRAM_BOT_TOKEN_XAU="$xau_token"
        export GEMINI_API_KEY="$gemini_key"
        
        echo ""
        echo "Environment variables tersimpan!"
        echo "Akan otomatis load saat buka Termux baru."
        ;;
    *)
        echo "Pilihan tidak valid!"
        ;;
esac
