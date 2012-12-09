(function() {
  function httpGet(url, callback) {
    var xmlHttp = null;
    xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", url, false);
    xmlHttp.send(null);
    var response = xmlHttp.responseText;
    callback(response);
  }

  var fn = function() {
    var city = geoip_city();
    var url = '/cities/' + city

    httpGet(url, function(response) {
      var div = document.getElementById('info')
      div.innerHTML = response;
    });
  };

  if (window.addEventListener) {
    window.addEventListener("load", fn);
  } else if (window.attachEvent) {
    window.attachEvent("onload", fn);
  };
})();
