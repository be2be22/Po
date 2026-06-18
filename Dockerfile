FROM python:3.11-slim

WORKDIR /app

# نصب پیش‌نیازهای کامپایل و اجرای پایتون
RUN apt-get update && apt-get install -y --no-install-recommends \
    git gcc python3-dev && \
    rm -rf /var/lib/apt/lists/*

# نصب کتابخانه uvloop برای سرعت بالا در پایتون
RUN pip install --no-cache-dir uvloop

# دانلود پروژه
RUN git clone https://github.com/alexbers/mtprotoproxy.git .

# ساخت فایل کانفیگ مستقیماً در کانتینر (جلوگیری از خطای داکر)
RUN echo 'PORT = 443' > config.py && \
    echo 'USERS = {"tg_user": "00112233445566778899aabbccddeeff"}' >> config.py

EXPOSE 443

# اجرای پروکسی
CMD ["python3", "mtprotoproxy.py"]
