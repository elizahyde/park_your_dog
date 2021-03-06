window.onload = function () {
  google.maps.visualRefresh = true;
  var infowindow = new google.maps.InfoWindow({ maxWidth: 300 });
  var map = window.map = new google.maps.Map(document.querySelector("#map-canvas"), {
    center: new google.maps.LatLng(37.7750, -122.4183),
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  parks.forEach(function (park, index) {
    var latlng = new google.maps.LatLng(park.latitude, park.longitude);
    var marker = new google.maps.Marker({
      position: latlng,
      map: map,
      title: park.name 
    });
    google.maps.event.addListener(marker, 'click', function() {
      var html = "<a href='/parks/" + park.id + "'>" + park.name + "</a><br>" + park.address; 
      infowindow.setContent(html);
      infowindow.open(map, marker);
    });
  });
};
