fs = require 'fs'
util = require 'util'
_ = require 'undescore'

class MockHttpExpectation
  constructor: (@method, @url, @data)->

  matchUrl:(url)-> 
    return @url == url 
  
module.exports = class HttpMock
  expectations: [] 
  constructor: (@filePath)->
  expectGET:(method, url)-> 
    @expect("GET", url)
  
  ###
    use: 
      expect(url).response(200, {ResponseObject})
  ###
  expect: (method, url, data)-> 
    expectation = new MockHttpExpectation(method, url, data, headers)
    expectations.push expectation
    respond : (status, data) ->
      expectation.response = 
        status : status 
        data  : data 

  get :(url, callback) -> 
    matchedExpectation = _.find(@expectations, (expectation)-> return expectation.matchUrl(url))
    callback(null, matchedExpectation.response)

    
    



    