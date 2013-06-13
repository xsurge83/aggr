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
    var aggr;
    httpMock.expectGET('/parent/1', parent, 200);
    aggr = new Aggr(httpMock);
    return aggr.request('/parent/:parentId', {
      parentId: 1
    }).exec(function(error, result) {
      result.should.have.property('name', parent.name);
      return done();
    });
  });
  it.skip('it should fail to get request', function() {
    return should.fail();
  });
  it('should get parent with children', function(done) {
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
  return it('get parent and its children by children ids from parent', function(done) {
    var aggr, myChildren, parentsWithChildIds;
    parentsWithChildIds = {
      name: 'parent',
      childIds: [2, 3]
    };
    myChildren = [
      {
        id: 2,
        name: "child1"
      }, {
        id: 3,
        name: "child2"
      }
    ];
    httpMock.expectGET('/parent/1', parentsWithChildIds, 200);
    httpMock.expectGET('/parent/1/children/2', myChildren[0], 200);
    aggr = new Aggr(httpMock);
    return aggr.request('/parent/:parentId', {
      parentId: 1
    }).append('/parent/:parentId/children/:childId', function(childProp) {
      return function(child) {
        return child;
      };
    }).exec(function(error, result) {
      result.should.have.property('name', parent.name);
      result.should.have.property('children', myChildren);
      return done();
    });
  });
});
