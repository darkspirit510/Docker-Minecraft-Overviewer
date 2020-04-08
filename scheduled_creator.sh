#!/usr/bin/env bash

while true; do
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py --genpoi
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py

  # Add JS magic to map
  sed -i '/<script src="leaflet.js"><\/script>/a <script src="https://unpkg.com/leaflet.marker.slideto@0.2.0/Leaflet.Marker.SlideTo.js"><\/script>' /tmp/export/index.html

  echo "Sleeping 1h... 🥱"
  sleep 1h
done