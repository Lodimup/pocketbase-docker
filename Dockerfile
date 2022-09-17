FROM ubuntu as builder

WORKDIR /app

RUN apt update && apt install unzip wget -y
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.7.3/pocketbase_0.7.3_linux_amd64.zip -O pocketbase.zip
RUN unzip pocketbase.zip

FROM alpine

WORKDIR /app
COPY --from=builder /app/pocketbase /app
EXPOSE 8090

ENTRYPOINT [ "./pocketbase", "serve" ]
CMD ["--http=0.0.0.0:8090"]
