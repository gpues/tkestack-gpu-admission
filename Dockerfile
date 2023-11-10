FROM registry.cn-hangzhou.aliyuncs.com/acejilam/mygo:1.21 as build
COPY . .
RUN go build -o /tmp/gpu-admission .
FROM registry.cn-hangzhou.aliyuncs.com/acejilam/centos:7
COPY --from=build /tmp/gpu-admission /usr/bin/gpu-admission
EXPOSE 3456

CMD ["/bin/bash", "-c", "/usr/bin/gpu-admission --address=0.0.0.0:3456 --v=$LOG_LEVEL --logtostderr=true $EXTRA_FLAGS"]
