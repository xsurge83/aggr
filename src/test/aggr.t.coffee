assert = require 'assert'
HttpMock = require './mocks/httpMock'
Aggr = require './../lib/aggr'
should = require 'should'

httpMock = new HttpMock() 

describe 'Aggr', -> 
  parent = 
    name : 'parent'
  children = [
      name: "child1"
    ,
      name: "child2"
    ]

  it 'single request', (done) -> 
    url = '/parent/:parentId'
    httpMock.expectGET('/parent/1', parent, 200)
    aggr = new Aggr(httpMock) 
    aggr
    .request(url, {parentId : 1})
    .exec((error, result)->
      # result.should.have.property('status', 200 ) 
      result.should.have.property('name', parent.name )
      done() 
      ) 
   it.skip 'it should fail to get request', -> 
    should.fail() 

  it 'should get parent with children', (done) ->
    httpMock.expectGET('/parent/1', parent, 200)
    httpMock.expectGET('/parent/1/children', children, 200)
    aggr = new Aggr(httpMock) 
    aggr
    .request('/parent/:parentId', {parentId : 1})
    .append('/parent/:parentId/children')
    .exec((error, result)->
      result.should.have.property('name', parent.name )
      result.should.have.property('children', children)
      done() 
      ) 



