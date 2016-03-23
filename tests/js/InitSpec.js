
requirejs.config({
    baseUrl: 'js/lib',
    paths: {
        // the left side is the module ID,
        // the right side is the path to
        // the jQuery file, relative to baseUrl.
        // Also, the path should NOT include
        // the '.js' file extension. This example
        // is using jQuery 1.9.0 located at
        // js/lib/jquery-1.9.0.js, relative to
        // the HTML page.
        jquery: 'jquery-1.9.0'
    }
});

describe("Standard initialization and debugging suite", function() {
  it("should know that true equals true", function() {
    expect(true).toBe(true);
  });
  it('should have access to the main app', function(){
    expect(app).toBeDefined();
  });
});