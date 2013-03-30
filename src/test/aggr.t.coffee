assert = require('assert')
HttpMock = require './mocks/httpMock'

httpMock = new HttpMock() 

describe 'Aggr', -> 
  it 'simple request', (done) ->
    url = '/parent/:parentId'
    data = 
      name : 'parent'
    httpMock.expectGET(url, data, 200)
    aggr = new Aggr(httpMock) 
    aggr
    .request(url, {parentId : 1})
    .exec((error, result)->
      console.log result) 


