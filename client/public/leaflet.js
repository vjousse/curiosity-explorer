const map = L.map('main-map');
var popup = L.popup();

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);


map.on('click', onMapClick);
map.on('move', onMapMove);
      
//Listener function taking an event object 
function onMapClick(e) {
    //map click event object (e) has latlng property which is a location at which the click occured.
    popup
      .setLatLng(e.latlng)
      .setContent("You clicked the map at " + e.latlng.toString())
      .openOn(map);
}

function onMapMove(e) {
    //map click event object (e) has latlng property which is a location at which the click occured.
    const bounds = map.getBounds();
    console.log("On map move", bounds);
    app.ports.mapInfo.send({
      southWest : {
        lat: bounds.getSouthWest().lat,
        lng: bounds.getSouthWest().lng
      },
      northEast : {
        lat: bounds.getNorthEast().lat,
        lng: bounds.getNorthEast().lng
      }
    });
}

