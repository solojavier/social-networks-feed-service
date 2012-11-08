/**
 * File Name: app.js
 * Date: November 2012
 * Description: Main application javascripts go here.
 */
$(document).ready(function() {
    $.ajax({
        url: 'http://localhost:4567/feed',
        success:function(data) {
            var data_json = $.parseJSON(data);

            $.each(data_json.facebook_feed, function(index, value) { 
                $("#facebook-feed").append("<li>" + value + "</li>");
            });

            $.each(data_json.twitter_feed, function(index, value) { 
                $("#twitter-feed").append("<li>" + value + "</li>");
            });
        }
    });

    $("#send").click(function() {
        var message = $("#post-message").val();
        $.ajax({
            url: 'http://localhost:4567/feed',
            type: "POST",
            data: {message: message},
            success:function(data){
                $("#result").html(data);
            }
        });
    });

});