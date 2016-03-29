// Place third party dependencies in the lib folder
//
// Configure loading modules from the lib directory,
// except 'app' ones, 
requirejs.config({
    "baseUrl": "js/",
    "paths": {
      jquery: "//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min",
      angular: '//ajax.googleapis.com/ajax/libs/angularjs/1.0.4/angular.min',
      "app": "app"
    }
});

// Load the main app module to start the app
requirejs(["app/main"]);