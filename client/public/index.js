// pull in desired CSS/SASS files
//require( './styles/mt.css/mt.scss' );
//require( './styles/app.css' );

//var Elm = require( './Main' );
//var app = Elm.Main.embed( document.getElementById( 'main' ) );

var app = Elm.Main.fullscreen();
var popup = L.popup();
var map;

app.ports.sendInitValues.subscribe(function(params) {
  console.log("Elm APP has been initialized", params);

  mapId = params.cssId;
  map = L.map(params.cssId);

  //L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
  //  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  //}).addTo(map);

  L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/streets-v9/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoidmpvdXNzZSIsImEiOiJjaXJnYTN6NnMwMDFqajJtNXdjem9odWw5In0.mvzP-IYwYQPlWzc0-TJNwQ', {
  }).addTo(map);


  var coordsWithZoom = params.coordsWithZoom

  lPosition = [coordsWithZoom.c.lat, coordsWithZoom.c.lng];
  lZoom = coordsWithZoom.zoom;
  map.setView(lPosition, lZoom);

  L.marker(lPosition).addTo(map)
    .bindPopup('<strong>Square des tanneries</strong><br /> Une description de ce lieu exceptionnel.');

  map.on('click', onMapClick);
  map.on('move', onMapMove);

  const bounds = map.getBounds();
  setTimeout(function(){ 
    app.ports.getMapInfo.send({
      southWest : {
        lat: bounds.getSouthWest().lat,
        lng: bounds.getSouthWest().lng
      },
      northEast : {
        lat: bounds.getNorthEast().lat,
        lng: bounds.getNorthEast().lng
      }
    });

  }, 0)

        
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
      app.ports.getMapInfo.send({
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



});

app.ports.sendPositionAndZoom.subscribe(function(coordsWithZoom) {

  console.log("Setting position and Zoom: ", coordsWithZoom);
  lPosition = [coordsWithZoom.c.lat, coordsWithZoom.c.lng];
  lZoom = coordsWithZoom.zoom;
  map.setView(lPosition, lZoom);

});


app.ports.sendCurrentLocation.subscribe(function(l) {

  console.log("Setting position: ", l);

  radius = l.accuracy / 2;

  var latlng = L.latLng(l.latitude, l.longitude);

  //L.marker(latlng).addTo(map)
  //  .bindPopup("Current position: " + radius + " meters from this point").openPopup();

  L.circle(latlng, radius).addTo(map);

  map.setView(latlng);

});

app.ports.sendZoom.subscribe(function(zoom) {
  console.log("Setting zoom: ", zoom);
  map.setZoom(zoom);
});

