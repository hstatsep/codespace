#!/bin/bash
read -p "Which grade are you in? (10, 11, or 12): " GRADE

if [ "$GRADE" = "10" ]; then
  REPO="wd"
elif [ "$GRADE" = "11" ]; then
  REPO="js"
elif [ "$GRADE" = "12" ]; then
  REPO="apcsa"
else
  echo "Invalid grade. Please enter 10, 11, or 12."
  exit 1
fi

DIR=/workspaces/codespace
command git clone git@github.com:hstatsep/$REPO.git $DIR/$REPO
rm -rf $DIR/$REPO/.git
echo "Done"
