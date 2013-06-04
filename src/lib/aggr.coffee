superagent  = require 'superagent'
async = require 'async'
_ = require 'underscore'

Hierarchy = 
  Parent : 1 
  Child : 2 
  Siblings : 3 

class Request    
  url : null 
  constructor : (@urlTemplate, @urlParams, @heirarchy = Hierarchy.Parent, @propContName)->
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
  constructor: (@http = new superagent.agent())->
    @params = {} 
    @requests = [] 
    @getBindings = @http.get.bind(@http)

  ###
  * todo: 
  * - reserve query property in param  
  ### 

  request:(urlTemplate, params)->
    if typeof(ulrParam) is 'object'
      params = 
        id : params 
    for key, value of params 
      @params[key] = value 
    request = new Request urlTemplate, params
    request.assignParamsToUrl() 
    @requests.push request
    return@ 
  ### todo: 
  ## move to request 
  * /parent/child 
  * /parent/:parentid/children
  ###
  getChildBlock = (urlTemplate, level)-> 
    urlBlocks = urlTemplate.split('/')
    block = urlBlocks[level].trim() 
    if block[0] is ':'
      block = urlBlocks[level*2 -1 ]
      if block[0] is ':'
        block = null 
    else 
      block = null 
    return block 

  append : (urlTemplate)->
    urlBlocks = urlTemplate.split('/')
    lastBlock = getChildBlock urlTemplate , 2
    console.log "d", lastBlock
    request = new Request urlTemplate, @params, Hierarchy.Child, lastBlock
    request.assignParamsToUrl(); 
    console.log '% request', request
    @requests.push request 
    return @
  
  _getResult : (request, callback) ->
    @http.get request.url, (error, result)-> 
      if result 
        result.request = request
      callback(error, result)

  exec:(callback)-> 
    asyncTasks = [] 
    debugger
    for request in @requests
      console.log request.url 
      asyncTasks.push async.apply @_getResult.bind(@), request 
    async.parallel asyncTasks , (error, responses)-> 
      # put the object together based on request
      if _.isArray responses
        obj = responses.shift(1).data 
        _.each responses, (response)->  
          if response.request.propContName
            obj[response.request.propContName] = response.data 
      else 
        obj = response.data 
      callback(error, obj)


Aggr.Request = Request  
exports = module.exports = Aggr  


