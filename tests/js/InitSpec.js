define(["jquery"], function($) {
    describe("Standard library inclusion", function() {
      it("should know that true equals true", function() {
        expect(true).toBe(true);
      });
      it('should have access to jQuery', function(){
        expect($).toBeDefined();
      });
    });
});

define(["app"], function(app) {
    describe("Main App", function() {
      it('should have access to the main app', function(){
        expect(app).toBeDefined();
      });
    });
});