var HttpMock, assert;

HttpMock = require('./httpMock');

assert = require('assert');

describe('setMock', function() {
  return it('mock', function(done) {
    var httpMock, url;
    httpMock = new HttpMock();
    url = '/resources';
    httpMock.expectGET(url, 'data');
    httpMock.get(url, function(error, result) {
      assert.equal(result.data, 'data');
      return assert.equal(result.status, 200);
    });
    return done();
  });
});
