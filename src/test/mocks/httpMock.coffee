fs = require 'fs'
util = require 'util'
#_ = require 'undescore'

class MockHttpExpectation
  constructor: (@method, @url, @data)->

  matchUrl:(url)-> 
    return @url == url 
  
module.exports = class HttpMock
  expectations: [] 
  constructor: (@filePath)->
  expectGET:( url, data, status)-> 
    @expect("GET", url, data, status)
  
  ###
    use: 
      expect(url).response(200, {ResponseObject})
  ###
  expect: (method, url, data, status)->
    if not status 
      status = 200  
    expectation = new MockHttpExpectation(method, url, data)
    @expectations.push expectation
    expectation.response = 
      status : status 
      data : data 

  get :(url, callback) -> 
    matchedExpectation = null 
    for exp in @expectations
      if exp.matchUrl url 
        matchedExpectation = exp 
        break;
    #matchedExpectation = _.find(@expectations, (expectation)-> return expectation.matchUrl(url))
    callback(null, matchedExpectation.response)
   
  clear: => 
    @expectations = []  