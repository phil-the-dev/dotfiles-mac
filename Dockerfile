FROM ubuntu:latest
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y curl git
RUN chmod +x ./install.sh
RUN ./install.sh