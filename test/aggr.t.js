// Generated by CoffeeScript 1.6.2
var Aggr, HttpMock, assert, httpMock, should;

assert = require('assert');

HttpMock = require('./mocks/httpMock');

Aggr = require('./../lib/aggr');

should = require('should');

httpMock = new HttpMock();

describe('Aggr', function() {
  var children, parent;

  parent = {
    name: 'parent'
  };
  children = [
    {
      name: "child1"
    }, {
      name: "child2"
    }
  ];
  it('single request', function(done) {
    var aggr, url;

    url = '/parent/:parentId';
    httpMock.expectGET('/parent/1', parent, 200);
    aggr = new Aggr(httpMock);
    return aggr.request(url, {
      parentId: 1
    }).exec(function(error, result) {
      result.should.have.property('name', parent.name);
      return done();
    });
  });
  it.skip('it should fail to get request', function() {
    return should.fail();
  });
  return it('should get parent with children', function(done) {
    var aggr;

    httpMock.expectGET('/parent/1', parent, 200);
    httpMock.expectGET('/parent/1/children', children, 200);
    aggr = new Aggr(httpMock);
    return aggr.request('/parent/:parentId', {
      parentId: 1
    }).append('/parent/:parentId/children').exec(function(error, result) {
      result.should.have.property('name', parent.name);
      result.should.have.property('children', children);
      return done();
    });
  });
});
