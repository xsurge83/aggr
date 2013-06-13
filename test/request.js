var Aggr, assert;

assert = require('assert');

Aggr = require('./../lib/aggr');

describe('Request', function() {
  return describe('assignParamsToUrl', function() {
    it('should create url with id mapping', function() {
      var request;
      request = new Aggr.Request('/parents/:parentId', {
        parentId: 3
      });
      request.assignParamsToUrl();
      return assert.equal(request.url, '/parents/3');
    });
    return it('should create url with multiple id mapping', function() {
      var request;
      request = new Aggr.Request('/parents/:parentId/items/:itemId', {
        parentId: 3,
        itemId: 4
      });
      request.assignParamsToUrl();
      return assert.equal(request.url, '/parents/3/items/4');
    });
  });
});
