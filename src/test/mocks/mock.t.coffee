HttpMock = require './httpMock'
assert = require 'assert'

describe 'setMock', -> 
  it 'mock', (done) -> 
    httpMock = new HttpMock()
    url = '/resources'
    httpMock.expectGET  url, 'data'
    httpMock.get url, (error, result) -> 
      assert.equal(result.data, 'data')
      assert.equal(result.status, 200)
    done() 



