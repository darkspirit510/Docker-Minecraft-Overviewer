#!/usr/bin/env bash

while true; do
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py --genpoi
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py

  echo "Extending map scripts 🚀"

  sed -i '/<script src="leaflet.js"><\/script>/a <script src="https://unpkg.com/leaflet.marker.slideto@0.2.0/Leaflet.Marker.SlideTo.js"><\/script>' /tmp/export/index.html
  sed -i '/<script src="leaflet.js"><\/script>/a <script src="map_magic.js"><\/script>' /tmp/export/index.html
  sed -i -e 's/overviewer.util.initialize()/overviewer.util.initialize();map_magic();/g' /tmp/export/index.html

  cp /map_magic.js /tmp/export/

  echo "Sleeping 1h... 🥱"
  sleep 1h
done
