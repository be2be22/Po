FROM alpine:latest

RUN apk add --no-cache git build-base

WORKDIR /app

# دانلود و کامپایل پروکسی تلگرام (نسخه سبک و سریع)
RUN git clone https://github.com/alexbers/mtprotoproxy.git . && \
    make

# تنظیمات پروکسی (یوزرنیم و سکرت)
# سکرت باید ۳۲ کاراکتر هگزادسیمال باشد
ENV PORT=443
ENV SECRET=00112233445566778899aabbccddeeff
ENV USERS={"tg_user": "00112233445566778899aabbccddeeff"}

# اجرای پروکسی
CMD ["python3", "mtprotoproxy.py"]
