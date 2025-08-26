# 1) Create a systemd drop-in for dockerd
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/proxy.conf >/dev/null <<'EOF'
[Service]
Environment="HTTP_PROXY=socks5h://127.0.0.1:9050"
Environment="HTTPS_PROXY=socks5h://127.0.0.1:9050"
Environment="ALL_PROXY=socks5h://127.0.0.1:9050"
Environment="NO_PROXY=localhost,127.0.0.1"
EOF

# 2) Reload and restart Docker
sudo systemctl daemon-reload
sudo systemctl restart docker

# 3) (Optional) verify envs are applied
systemctl show docker -p Environment

