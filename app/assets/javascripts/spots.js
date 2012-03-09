var loaded = false;
function success(position) {
    //on success we'll send a call out to foursquare to show us the stuff in our area
    //$.mobile.hidePageLoadingMsg();
    if(!loaded) {
    loaded = true;
    $.mobile.showPageLoadingMsg("a", "Loading Places...", false);
    //console.log('lat: ' + position.coords.latitude + ' lon: ' + position.coords.longitude);
    coords = { lat: position.coords.latitude, lon:position.coords.longitude }
    $.getJSON(
        '/search?',
        coords,
        function(data) {
            console.log(data.groups[0].items)
            $.each(data.groups[0].items, function(i, val) {
                item = '<li id="' + val.id + '"><a href="/spots/'+val.id+'">' + val.name + '</a></li>';

                $('#spot-list').append(item);

            });
            $.mobile.hidePageLoadingMsg();
            $('#spot-list').listview('refresh');
        });
    }

}

function error(msg) {
    //on deny we'll let them know thats dumb
    $.mobile.hidePageLoadingMsg();
    console.log(msg);
}

$(document).delegate("#spots", "pageshow", function() {
    //alert("page loaded");
    //change loading.. to waiting for response...
    //error shows no access div
    //success shows list
    if (navigator.geolocation) {
        $.mobile.showPageLoadingMsg("a", "Waiting for Access", false);
        navigator.geolocation.getCurrentPosition(success, error);
    } else {
        $.mobile.hidePageLoadingMsg();
        error('not supported');
    }
});

