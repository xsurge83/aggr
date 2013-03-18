// Generated by CoffeeScript 1.4.0
var HttpMock, MockHttpExpectation, fs, util, _;

fs = require('fs');

util = require('util');

_ = require('undescore');

MockHttpExpectation = (function() {

  function MockHttpExpectation(method, url, data) {
    this.method = method;
    this.url = url;
    this.data = data;
  }

  MockHttpExpectation.prototype.matchUrl = function(url) {
    return this.url === url;
  };

  return MockHttpExpectation;

})();

module.exports = HttpMock = (function() {

  HttpMock.prototype.expectations = [];

  function HttpMock(filePath) {
    this.filePath = filePath;
  }

  HttpMock.prototype.expectGET = function(method, url) {
    return this.expect("GET", url);
  };

  /*
      use: 
        expect(url).response(200, {ResponseObject})
  */


  HttpMock.prototype.expect = function(method, url, data) {
    var expectation;
    expectation = new MockHttpExpectation(method, url, data, headers);
    expectations.push(expectation);
    return {
      respond: function(status, data) {
        return expectation.response = {
          status: status,
          data: data
        };
      }
    };
  };

  HttpMock.prototype.get = function(url, callback) {
    var matchedExpectation;
    matchedExpectation = _.find(this.expectations, function(expectation) {
      return expectation.matchUrl(url);
    });
    return callback(null, matchedExpectation.response);
  };

  return HttpMock;

})();
