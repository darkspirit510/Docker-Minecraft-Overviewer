#!/usr/bin/env bash

while true; do
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py --genpoi
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py

  echo "Extending map scripts 🚀"
  cat <<EOT > map_magic.js
function map_magic() {
  alert("TEST");
}
EOT

  sed -i '/<script src="leaflet.js"><\/script>/a <script src="https://unpkg.com/leaflet.marker.slideto@0.2.0/Leaflet.Marker.SlideTo.js"><\/script>' /tmp/export/index.html
  sed -i '/<script src="leaflet.js"><\/script>/a <script src="map_magic.js"><\/script>' /tmp/export/index.html
  sed -i '/overviewer.util.initialize()/a ; map_magic() ;' /tmp/export/index.html

  echo "Sleeping 1h... 🥱"
  sleep 1h
done