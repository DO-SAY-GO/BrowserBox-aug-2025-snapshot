# edit the drop-in to use socks5 (not socks5h)
sudo tee /etc/systemd/system/docker.service.d/proxy.conf >/dev/null <<'EOF'
[Service]
Environment="ALL_PROXY=socks5://127.0.0.1:9050"
Environment="all_proxy=socks5://127.0.0.1:9050"
Environment="NO_PROXY=localhost,127.0.0.1,::1"
EOF

# reload + restart docker
sudo systemctl daemon-reload
sudo systemctl restart docker

# sanity check envs applied
systemctl show docker -p Environment

