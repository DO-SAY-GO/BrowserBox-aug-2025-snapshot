# Docker daemon
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/proxy.conf >/dev/null <<'EOF'
[Service]
Environment="HTTP_PROXY=socks5://127.0.0.1:9050"
Environment="HTTPS_PROXY=socks5://127.0.0.1:9050"
Environment="NO_PROXY=localhost,127.0.0.1,::1"
EOF

# containerd (image pulls go through it)
sudo mkdir -p /etc/systemd/system/containerd.service.d
sudo tee /etc/systemd/system/containerd.service.d/proxy.conf >/dev/null <<'EOF'
[Service]
Environment="HTTP_PROXY=socks5://127.0.0.1:9050"
Environment="HTTPS_PROXY=socks5://127.0.0.1:9050"
Environment="NO_PROXY=localhost,127.0.0.1,::1"
EOF

# apply and restart
sudo systemctl daemon-reload
sudo systemctl restart containerd
sudo systemctl restart docker

# sanity check envs applied
systemctl show docker -p Environment
systemctl show containerd -p Environment


curl -I -x socks5h://127.0.0.1:9050 https://registry-1.docker.io/v2/

