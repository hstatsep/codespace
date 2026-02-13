#!/bin/bash
read -p "Enter your GitHub personal access token: " TOKEN
rm -rf /workspaces/codespace/.ssh
rm -rf /home/vscode/.ssh
mkdir -p /workspaces/codespace/.ssh
chmod 700 /workspaces/codespace/.ssh
ln -sf /workspaces/codespace/.ssh /home/vscode/.ssh
echo -e "\n" | ssh-keygen -t rsa -N "" -f /workspaces/codespace/.ssh/id_rsa
chmod 600 /workspaces/codespace/.ssh/id_rsa
PUBKEY=$(cat /workspaces/codespace/.ssh/id_rsa.pub)
TITLE=$(hostname)
RESPONSE=$(curl -s -H "Authorization: token ${TOKEN}" \
-X POST --data-binary "{\"title\":\"${TITLE}\",\"key\":\"${PUBKEY}\"}" \
https://api.github.com/user/keys)
KEYID=$(echo $RESPONSE \
| grep -o '"id.*' \
| grep -o "[0-9]*" \
| grep -m 1 "[0-9]*")
if [ -z "$KEYID" ]; then
  echo "Something went wrong. Response was:"
  echo $RESPONSE
else
  echo "SSH key successfully uploaded to GitHub (Key ID: $KEYID)"
fi
rm -f /workspaces/codespace/.ssh/config
echo "Host github.com" >> /workspaces/codespace/.ssh/config
echo " Hostname ssh.github.com" >> /workspaces/codespace/.ssh/config
echo " Port 443" >> /workspaces/codespace/.ssh/config
echo " StrictHostKeyChecking no" >> /workspaces/codespace/.ssh/config
echo " IdentityFile /workspaces/codespace/.ssh/id_rsa" >> /workspaces/codespace/.ssh/config
chmod 600 /workspaces/codespace/.ssh/config
ssh -T git@github.com
