#!/bin/bash
git config --global pull.rebase false
cp /home/vscode/.bashrc /workspaces/codespace/.bashrc 2>/dev/null || true
cp /home/vscode/.gitconfig /workspaces/codespace/.gitconfig 2>/dev/null || true
cp /workspaces/codespace/.devcontainer/.bash_profile /workspaces/codespace/.bash_profile
grep -q 'source ~/.bash_profile' /workspaces/codespace/.bashrc || echo 'source ~/.bash_profile' >> /workspaces/codespace/.bashrc
ln -sf /workspaces/codespace/.ssh /home/vscode/.ssh
chmod +x /workspaces/codespace/.devcontainer/setup_ssh.sh
chmod +x /workspaces/codespace/.devcontainer/setup_folder.sh
