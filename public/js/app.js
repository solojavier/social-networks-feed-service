/**
 * File Name: app.js
 * Date: November 2012
 * Description: Main application javascripts go here.
 */
 var SocialFeed = function() {};

/**
 * Name: SocialFeed.loadJSON();
 * Description: Makes a request to load the JSON.
 */
SocialFeed.prototype.loadJSON = function(options) {
    var that = this;
    
    $.ajax({
        /* URL to request the JSON data */
        url: '/feed',

        /* Type of request we're doing */
        type: 'GET',

        /* Set a maximum ammount of time to await for a response (in milliseconds) */
        timeout: 5000,

        /* Set the current attempt number */
        tries: 0,

        /* Set a maximum ammount of tries to make before throwing an error */
        retryLimit: 3,

        /* If we get a hold of the JSON data, we call SocialFeed.parseItems */
        success: function(data) {
            that.parseItems(data, options);
        },

        /* If we get an error while retrieving the JSON data, we retry or display an error */
        error: function(XMLHttpRequest) {
            /* We add 1 to the number of tries attempted */
            this.tries++;

            /* We check if the limit of tries has been surpassed, either to try again or display an error */
            if (this.tries <= this.retryLimit) {
                $.ajax(this);
                return;
            } else {
                alert("There was an error loading the JSON data. Error thrown was: " + XMLHttpRequest);
            }
        }
    });

};
/**
 * Name: SocialFeed.parseItems();
 * Description: Creates a template for every item, passes the array to be prepended.
 */
SocialFeed.prototype.parseItems = function(data, options) {
    // This will hold our final array to append
    var $template,
        // Temporary array that will store our templates
        markupTemp = [],
        // Parsing the JSON using jQuery
        items = $.parseJSON(data);

    for (var i = 0; i < items.length; i++) {
        // Generating HTML from icanhaz template
        var $item = ich.item(items[i].item);

        // Pushing item to markupTemp array
        markupTemp.push($item);
    }

    // Making markupTemp something more... appendable.
    $template = $.map(markupTemp, function(value, index) {
        return(value.get());
    });

    // Finally prepending our items
    options.prependItem($template);

};

/**
 * Name: SocialFeed.post();
 * Description: Posts a new item.
 */
SocialFeed.prototype.post = function(options) {
    $.ajax({
        /* URL to request the JSON data */
        url: '/feed',

        /* Type of request we're doing. This time, we're POSTing. */
        type: 'POST',

        /* Set a maximum ammount of time to await for a response (in milliseconds) */
        timeout: 5000,

        /* Set the current attempt number */
        tries: 0,

        /* Set a maximum ammount of tries to make before throwing an error */
        retryLimit: 3,

        /* The data we're posting */
        data: { message: options.text },

        /* If the message was posted, do this */
        success: options.success,

        /* If we get an error while retrieving the JSON data, we retry or display an error */
        error: function(XMLHttpRequest) {
            /* We add 1 to the number of tries attempted */
            this.tries++;

            /* We check if the limit of tries has been surpassed, either to try again or display an error */
            if (this.tries <= this.retryLimit) {
                $.ajax(this);
                return;
            } else {
                alert("There was an error posting your message. Error thrown was: " + XMLHttpRequest);
            }
        }
    });
};

/**
 * Name: SocialFeedView();
 * Description: Feed Views
 */
 var SocialFeedView = function(options) {
    this.items = options.feed;

    /* Load Posts */
    this.items.loadJSON(this);

    /* Passing context. */
    var post = $.proxy(this.postStatus, this);

    /* Posting form binder */
    $('#new_post').submit(post);
};

/* Post Status Function */
SocialFeedView.prototype.postStatus = function(e) {
    /* Preventing default browser behaviour */
    e.preventDefault();

    /* Keyword to make things more readable */
    var that = this;

    /* Posting item */
    this.items.post({
        message: $('#message').val(),
        success: function(data) {
            that.appendItem(data);
            that.clearInput();
        }
    });
};

/* Post prepend Function */
SocialFeedView.prototype.prependItem = function(data) {
    /* Prepend data to the list and remove loading class if it exists */
    $('#news_list').prepend(data);
    $('#network_feed').removeClass('loading');
};

/* Clear input Function */
SocialFeedView.prototype.clearInput = function() {
    /* Clearing input value */
    $('#message').val('').css('height', '2em');
};

/**
 * jQuery version of Autogrow script from
 * Mobile HTML5 Boilerplate - http://bit.ly/l4j1RZ
 * Adapted by Iraê http://bit.ly/kBfnaD
 */
$(document).delegate('textarea', 'keyup', function(event) {
    var self = $(this),
        textLineHeight = self.data('textLineHeight'),
        currentHeight = self.data('currentHeight'),
        startingHeight = this.scrollHeight,
        newHeight = this.scrollHeight;

    if (!textLineHeight) {
        textLineHeight = parseInt(self.css('line-height'),10);
        currentHeight = self.height();
        self.css('overflow','hidden');
    }

    if (newHeight > currentHeight) {
        newHeight = newHeight + 1 * textLineHeight;
        self.height(newHeight);
        self.data('currentHeight',newHeight);
    }
});

/**
 * jQuery $(document).ready() function. This function
 * will be executed as soon as the document has finished loading.
 */
$(document).ready(function() {
    var feed = new SocialFeed();

    new SocialFeedView({ feed: feed });
});