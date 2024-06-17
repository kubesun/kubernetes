#!/bin/bash
# 此文件用于配置Containerd的国内源,
# 当镜像的路径是server的某一条时,
# 就会通过这些源进行代理

# 此命令用于生成containerd默认的配置文件
generate_default_config_file () {
  containerd config default | tee /etc/containerd/config.toml
}

# 添加源命令参数
update_config_file (){
  export CONTAINERD_CONFIG_FILE_PATH="/etc/containerd/config.toml"
  sed -i '/\[plugins\."io\.containerd\.grpc\.v1\.cri"\.registry\]/!b;n;s/config_path = .*/config_path = "\/etc\/containerd\/certs.d"/' /etc/containerd/config.toml
  cat -n /etc/containerd/config.toml | grep -A 1 "\[plugins\.\"io\.containerd\.grpc\.v1\.cri\"\.registry\]"
}

set_proxy_url () {
  # docker hub镜像加速
  mkdir -p /etc/containerd/certs.d/docker.io
  cat > /etc/containerd/certs.d/docker.io/hosts.toml << EOF
server = "https://docker.io"
[host."https://docker.kubesre.xyz"]
capabilities = ["pull", "resolve"]

[host."https://dockerproxy.com"]
  capabilities = ["pull", "resolve"]

[host."https://docker.m.daocloud.io"]
  capabilities = ["pull", "resolve"]

[host."https://reg-mirror.qiniu.com"]
  capabilities = ["pull", "resolve"]

[host."https://registry.docker-cn.com"]
  capabilities = ["pull", "resolve"]

[host."http://hub-mirror.c.163.com"]
  capabilities = ["pull", "resolve"]
EOF

  # registry.k8s.io镜像加速
  mkdir -p /etc/containerd/certs.d/registry.k8s.io
  tee /etc/containerd/certs.d/registry.k8s.io/hosts.toml << 'EOF'
server = "https://registry.k8s.io"

[host."registry-k8s-io.mirrors.sjtug.sjtu.edu.cn"]
  capabilities = ["pull", "resolve", "push"]

[host."https://k8s.kubesre.xyz"]
  capabilities = ["pull", "resolve", "push"]

[host."registry.cn-hangzhou.aliyuncs.com/google_containers"]
capabilities = ["pull", "resolve", "push"]

[host."https://k8s.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]

[host."k8s.nju.edu.cn"]
  capabilities = ["pull", "resolve", "push"]

EOF

  # docker.elastic.co镜像加速
  mkdir -p /etc/containerd/certs.d/docker.elastic.co
  tee /etc/containerd/certs.d/docker.elastic.co/hosts.toml << 'EOF'
server = "https://docker.elastic.co"
[host."https://elastic.kubesre.xyz"]
  capabilities = ["pull", "resolve", "push"]

[host."https://elastic.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]
EOF

  # gcr.io镜像加速
  mkdir -p /etc/containerd/certs.d/gcr.io
  tee /etc/containerd/certs.d/gcr.io/hosts.toml << 'EOF'
server = "https://gcr.io"

[host."https://gcr.kubesre.xyz"]
  capabilities = ["pull", "resolve", "push"]
EOF

  # ghcr.io镜像加速
  mkdir -p /etc/containerd/certs.d/ghcr.io
  tee /etc/containerd/certs.d/ghcr.io/hosts.toml << 'EOF'
server = "https://ghcr.io"
[host."https://ghcr.nju.edu.cn"]
  capabilities = ["pull", "resolve", "push"]

[host."https://ghcr.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]
EOF

  # k8s.gcr.io镜像加速
  mkdir -p /etc/containerd/certs.d/k8s.gcr.io
  tee /etc/containerd/certs.d/k8s.gcr.io/hosts.toml << 'EOF'
server = "https://k8s.gcr.io"
[host."https://k8s-gcr-io.mirrors.sjtug.sjtu.edu.cn"]
  capabilities = ["pull", "resolve", "push"]

[host."https://gcr.nju.edu.cn"]
  capabilities = ["pull", "resolve", "push"]

[host."https://k8s-gcr.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]
EOF

  # mcr.m.daocloud.io镜像加速
  mkdir -p /etc/containerd/certs.d/mcr.microsoft.com
  tee /etc/containerd/certs.d/mcr.microsoft.com/hosts.toml << 'EOF'
server = "https://mcr.microsoft.com"
[host."https://mcr.kubesre.xyz"]
  capabilities = ["pull", "resolve", "push"]

[host."https://mcr.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]
EOF

  # nvcr.io镜像加速
  mkdir -p /etc/containerd/certs.d/nvcr.io
  tee /etc/containerd/certs.d/nvcr.io/hosts.toml << 'EOF'
server = "https://nvcr.io"
[host."https://nvcr.nju.edu.cn"]
  capabilities = ["pull", "resolve", "push"]

[host."https://nvcr.kubesre.xyz"]
  capabilities = ["pull", "resolve", "push"]

[host."https://nvcr.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]
EOF

  # quay.io镜像加速
  mkdir -p /etc/containerd/certs.d/quay.io
  tee /etc/containerd/certs.d/quay.io/hosts.toml << 'EOF'
server = "https://quay.io"
[host."https://quay.nju.edu.cn"]
  capabilities = ["pull", "resolve", "push"]

[host."https://quay.mirrors.ustc.edu.cn"]
  capabilities = ["pull", "resolve", "push"]

[host."https://quay.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]
EOF

  # registry.jujucharms.com镜像加速
  mkdir -p /etc/containerd/certs.d/registry.jujucharms.com
  tee /etc/containerd/certs.d/registry.jujucharms.com/hosts.toml << 'EOF'
server = "https://registry.jujucharms.com"
[host."https://jujucharms.kubesre.xyz"]
  capabilities = ["pull", "resolve", "push"]

[host."https://jujucharms.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]
EOF

  # rocks.canonical.com镜像加速
  mkdir -p /etc/containerd/certs.d/rocks.canonical.com
tee /etc/containerd/certs.d/rocks.canonical.com/hosts.toml << 'EOF'
server = "https://rocks.canonical.com"

[host."https://rocks-canonical.m.daocloud.io"]
  capabilities = ["pull", "resolve", "push"]
EOF

  systemctl restart containerd
  # systemctl status containerd

  ls /etc/containerd/certs.d

}

verify () {

  cat -n /etc/containerd/config.toml | grep -A 1 "\[plugins\.\"io\.containerd\.grpc\.v1\.cri\"\.registry\]"

  if [[ -d /etc/containerd/certs.d ]];then
    echo "目录生成成功"
  fi

  echo containerd test
  ctr --debug  i pull \
  registry.k8s.io/prometheus-adapter/prometheus-adapter:latest \
  # --hosts-dir=$CONTAINERD_CONFIG_FILE_PATH
  #crictl pull registry.k8s.io/prometheus-adapter/prometheus-adapter:v0.11.2
}

main () {
  update_config_file
  set_proxy_url
  verify
}

main
