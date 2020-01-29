#!/usr/bin/env bash

while true; do
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py --genpoi
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py

  echo "Sleeping 1h... 🥱"
  sleep 1h
done