define('main', ["jquery", "jquery.alpha", "jquery.beta"], function($, a, b) {
    //the jquery.alpha.js and jquery.beta.js plugins have been loaded.
    $(function() {
        $('body').alpha().beta();
    });
});