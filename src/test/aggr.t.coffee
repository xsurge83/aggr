assert = require 'assert'
HttpMock = require './mocks/httpMock'
Aggr = require './../lib/aggr'
should = require 'should'

httpMock = new HttpMock() 

describe 'Aggr', -> 
  parent = 
      name : 'parent'
  child = [
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
      result.should.have.property('status', 200 ) 
      result.data.should.have.property('name', parent.name )
      done() 
      ) 

  it 'should get parent with children', (done) ->
    url = '/parent/:parentId'
    
    httpMock.expectGET('/parent/1', parent, 200)
    httpMock.expectGET('/parent/1/children', children, 200)
    aggr = new Aggr(httpMock) 
    aggr
    .request(url, {parentId : 1})
    .append('/parent/:parentId/children')
    .exec((error, result)->
      result.should.have.property('status', 200 ) 
      result.data.should.have.property('name', data.name )
      done() 
      ) 



