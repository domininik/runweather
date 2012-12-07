(function() {
  function httpGet(url) {
    var xmlHttp = null;
    xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", url, false);
    xmlHttp.send(null);
    return xmlHttp.responseText;
  }

  var fn = function() {
    var city = geoip_city();
    var url = '/cities/' + city
    var response = httpGet(url);
    var div = document.getElementById('info')
    div.innerHTML = response;
  };

  if (window.addEventListener) {
    window.addEventListener("load", fn);
  } else if (window.attachEvent) {
    window.attachEvent("onload", fn);
  };
})();
