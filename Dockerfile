FROM alpine:3.14
WORKDIR /app
COPY . .
RUN apk add curl
RUN source install.sh