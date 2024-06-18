#!/usr/bin/env bash

apply_map_magic() {
    echo "Extending map scripts 🚀"
  cat <<EOT >/tmp/export/map_magic.js
function formatDate(milliseconds) {
  const d = new Date(milliseconds);

  return d.toLocaleString('de-DE');
}
function map_magic() {
    const xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            const conf = overviewer.current_layer[overviewer.current_world].tileSetConfig;

            JSON.parse(this.responseText).forEach(player => {
                const icon = L.icon({
                    iconUrl: 'https://crafatar.com/avatars/' + player.uuid,
                    iconSize: [32, 32],
                });
                L.marker(overviewer.util.fromWorldToLatLng(player.x, player.y, player.z, conf), {icon: icon})
                    .addTo(overviewer.map)
                    .bindTooltip(player.name + " (Zuletzt Online: " + formatDate(player.lastSeen) + ")");
            });
        }
    };

    xmlhttp.open("GET", "player_positions.json", true);
    xmlhttp.send();
}
EOT

  sed -i '/<script src="leaflet.js"><\/script>/a <script src="https://unpkg.com/leaflet.marker.slideto@0.2.0/Leaflet.Marker.SlideTo.js"><\/script>' /tmp/export/index.html
  sed -i '/<script src="leaflet.js"><\/script>/a <script src="map_magic.js"><\/script>' /tmp/export/index.html
  sed -i -e 's/overviewer.util.initialize()/overviewer.util.initialize();map_magic();/g' /tmp/export/index.html
}

while true; do
  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py --genpoi
  apply_map_magic

  /tmp/overviewer/overviewer.py --config=/tmp/config/config.py
  apply_map_magic

  echo "Sleeping 1h... 🥱"
  sleep 1h
done

