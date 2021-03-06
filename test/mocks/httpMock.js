var HttpMock, MockHttpExpectation, fs, util,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

fs = require('fs');

util = require('util');

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
    this.clear = __bind(this.clear, this);
  }

  HttpMock.prototype.expectGET = function(url, data, status) {
    return this.expect("GET", url, data, status);
  };

  /*
    use: 
      expect(url).response(200, {ResponseObject})
  */


  HttpMock.prototype.expect = function(method, url, data, status) {
    var expectation;
    if (!status) {
      status = 200;
    }
    expectation = new MockHttpExpectation(method, url, data);
    this.expectations.push(expectation);
    return expectation.response = {
      status: status,
      data: data
    };
  };

  HttpMock.prototype.get = function(url, callback) {
    var exp, matchedExpectation, _i, _len, _ref;
    matchedExpectation = null;
    _ref = this.expectations;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      exp = _ref[_i];
      if (exp.matchUrl(url)) {
        matchedExpectation = exp;
        break;
      }
    }
    return process.nextTick(function() {
      return callback(null, matchedExpectation.response);
    });
  };

  HttpMock.prototype.clear = function() {
    return this.expectations = [];
  };

  return HttpMock;

})();
