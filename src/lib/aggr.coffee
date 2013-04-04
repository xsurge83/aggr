superagent  = require 'superagent'
async = require 'async'
_ = require 'underscore'

class Request   
  url : null 
  constructor:(@urlTemplate, @urlParams)->
  assignParamsToUrl : -> 
    @url = @urlTemplate.toLowerCase() 
    for own urlParam, value of @urlParams 
      @url = @url.replace(':' + urlParam.toLowerCase(), value) 

###
Todo:
 - add append logic 
 - persist params to for reuse of other requests 
    - reuse param unless specified for that request 
### 
class Aggr
  requests : [] 
  params : {} 
  
  constructor: (@http = new superagent.agent())->
    @getBindings = @http.get.bind(@http)

  request:(urlTemplate, urlParam)->
    if typeof(ulrParam) is 'object'
      urlParam = 
        id : urlParam 
    request = new Request urlTemplate, urlParam
    request.assignParamsToUrl() 
    @requests.push request
    return@ 
  
  exec:(callback)-> 
    asyncTasks = [] 
    debugger
    for request in @requests
      console.log request.url 
      asyncTasks.push async.apply @getBindings, request.url
    async.parallel asyncTasks , (error, responses)-> 
      if responses.length == 1 
        responses = responses[0] 
      callback(error, responses)


Aggr.Request = Request  
exports = module.exports = Aggr  


