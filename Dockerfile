FROM golang:1.22.3-bookworm
LABEL authors="zen"
RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go env -w GOBIN=/root/go/bin

COPY debian.sources /etc/apt/sources.list.d/
RUN apt update
COPY install-retry.sh /usr/local/bin
RUN chmod +x /usr/local/bin/install-retry.sh
RUN install-retry.sh ffmpeg python3 python3-pip nano translate-shell libsqlite3-dev bsdmainutils
# RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install openai-whisper --break-system-packages
RUN rm -rf /root/.cache
CMD ["top"]
#ENTRYPOINT ["top", "-b"]
# docker run -dit --name test -v /c/Users/zen/Github/FastBuildDockerfile:/data golang:1.22.3-bookworm bash
# docker run -dit --name whisper -v /c/Users/zen/Github/WhisperInDocker:/app -v /e/pikpak/亀頭責:/data stand:v0.0.1 bash
# docker commit -p -a zen -m "基础镜像" test stand:v0.0.1