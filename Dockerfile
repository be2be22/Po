FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git gcc python3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir uvloop cryptography

RUN git clone https://github.com/alexbers/mtprotoproxy.git .

RUN echo 'PORT = 443' > config.py && \
    echo 'USERS = {"tg_user": "00112233445566778899aabbccddeeff"}' >> config.py && \
    echo 'TLS_DOMAIN = "speedtest.net"' >> config.py && \
    echo 'AD_TAG = bytes.fromhex("8a47d80dc25ea4eaf8d662c69337a7ce")' >> config.py

EXPOSE 443

CMD ["python3", "mtprotoproxy.py"]