#!/usr/bin/env bash

# 修改`crictl`配置文件，使用`containerd`作为Kubernetes默认的容器运行时, 即crictl调用containerd管理Pod
# 旧版本
set_crictl_conf_v1() {
  cat > /usr/bin/crictl.yaml << EOF
runtime-endpoint: unix:///var/run/containerd/containerd.sock
image-endpoint: unix:///var/run/containerd/containerd.sock
timeout: 10
debug: false
EOF
}

set_crictl_conf_v2() {
  ls /var/run/containerd/
  crictl config runtime-endpoint unix:///var/run/containerd/containerd.sock
}

verify () {
  # 使用crictl测试一下，确保可以打印出版本信息并且没有错误信息输出
#  crictl --runtime-endpoint=unix:///run/containerd/containerd.sock version
  crictl version
  cat /usr/bin/crictl.yaml
  # 输出版本
  crictl -v

  if ! which crictl > /dev/null 2>&1; then
    crictl pull registry.k8s.io/prometheus-adapter/prometheus-adapter:v0.11.2
  fi
  echo "crictl 未安装，跳过测试..."
}

main () {
#  set_crictl_conf_v1
  set_crictl_conf_v2
  verify
}

main
