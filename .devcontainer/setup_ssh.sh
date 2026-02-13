#!/bin/bash
read -p "Enter your GitHub personal access token: " TOKEN

# Delete any existing keys with this machine's hostname
echo "Removing old SSH keys from GitHub..."
EXISTING=$(curl -s -H "Authorization: token ${TOKEN}" https://api.github.com/user/keys)
OLD_IDS=$(echo $EXISTING | grep -o '"id": [0-9]*' | grep -o '[0-9]*')
TITLE=$(hostname)
EXISTING_TITLES=$(echo $EXISTING | grep -o '"title":"[^"]*"' | grep -o '"[^"]*"$' | tr -d '"')

echo "$EXISTING" | python3 -c "
import sys, json
keys = json.load(sys.stdin)
title = '$(hostname)'
for key in keys:
    if key['title'] == title:
        print(key['id'])
" | while read ID; do
  curl -s -H "Authorization: token ${TOKEN}" \
    -X DELETE https://api.github.com/user/keys/$ID
  echo "Deleted old key ID: $ID"
done

# Now proceed with fresh setup
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
