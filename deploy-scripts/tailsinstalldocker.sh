#!/usr/bin/env bash
set -euo pipefail

echo "[*] Updating apt..."
sudo apt-get update

echo "[*] Installing prerequisites..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "[*] Setting up Docker’s official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "[*] Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[*] Updating apt with new repo..."
sudo apt-get update

echo "[*] Installing Docker CE, CLI, containerd, buildx, compose..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[*] Enabling and starting docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "[*] Adding current user to docker group (you*]()

