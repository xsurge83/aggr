superagent  = require 'superagent'
async = require 'async'


class Request   
  constructor:(@urlTemplate, @urlParams)->

  parseUrl : -> 
    @url = @urlTemplate.toLowerCase() 
    for urlParam, value of @urlParams 
      @url = @url.replace(':' + urlParam.toLowerCase(), value) 

class Aggr
  urlTemplates : [] 
  constructor: (@http = new superagent.agent())->

  request:(urlTemplate, urlParam)->
    if typeof(ulrParam) is 'object'
      urlParam = 
        id : urlParam 
    @urlTemplate.push new Request urlTemplate, urlParam
    return@ 

Aggr.Request = Request  
exports = module.exports = Aggr  


