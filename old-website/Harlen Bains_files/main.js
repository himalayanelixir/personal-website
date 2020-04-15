$(document).ready(function() {
  $.simpleWeather({
    location: 'San Jose, CA',
    woeid: '',
    unit: 'f',
    success: function(weather) {
      html = '<p class="animated fadeInUp">'+'Creating software applications in San Jose, California. <a href="https://www.linkedin.com/in/harlenbains/">Contact Me</a>.'+'</p>';
    },
    error: function(error) {
      $("#weather").html('<p>'+error+'</p>');
    }
  });
});
