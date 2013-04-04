assert = require 'assert'
HttpMock = require './mocks/httpMock'
Aggr = require './../lib/aggr'
should = require 'should'

httpMock = new HttpMock() 

describe 'Aggr', -> 
  it 'single request', (done) ->
    url = '/parent/:parentId'
    data = 
      name : 'parent'
    httpMock.expectGET('/parent/1', data, 200)
    aggr = new Aggr(httpMock) 
    aggr
    .request(url, {parentId : 1})
    .exec((error, result)->
      result.should.have.property('status', 200 ) 
      result.data.should.have.property('name', data.name )
      done() 
      ) 



