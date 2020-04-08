function map_magic() {
    const xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            JSON.parse(this.responseText).forEach(player => {
                const icon = L.icon({
                    iconUrl: 'https://crafatar.com/avatars/' + player.uuid,
                    iconSize: [32, 32],
                });
                L.marker(overviewer.util.fromWorldToLatLng(player.x, player.y, player.z, conf), {icon: icon})
                    .addTo(overviewer.map)
                    .bindTooltip(player.name);
            });
        }
    };

    xmlhttp.open("GET", "player_positions.json", true);
    xmlhttp.send();
}
