FROM python:3.11-slim

WORKDIR /app

# نصب پیش‌نیازها + ماژول cryptography برای سرعت بالا
RUN apt-get update && apt-get install -y --no-install-recommends \
    git gcc python3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir uvloop cryptography

# دانلود پروژه
RUN git clone https://github.com/alexbers/mtprotoproxy.git .

# ساخت فایل کانفیگ مستقیم + تغییر دامنه camouflage برای جلوگیری از فیلتر شدن سریع
RUN echo 'PORT = 443' > config.py && \
    echo 'USERS = {"tg_user": "00112233445566778899aabbccddeeff"}' >> config.py && \
    echo 'TLS_DOMAIN = "speedtest.net"' >> config.py

EXPOSE 443

# اجرای پروکسی
CMD ["python3", "mtprotoproxy.py"]
