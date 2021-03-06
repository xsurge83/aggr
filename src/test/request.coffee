assert = require('assert')
Aggr = require './../lib/aggr'

describe 'Request', -> 
  describe 'assignParamsToUrl', -> 
    it 'should create url with id mapping', -> 
      request = new Aggr.Request('/parents/:parentId', {parentId: 3})
      request.assignParamsToUrl() 
      assert.equal(request.url, '/parents/3')
    it 'should create url with multiple id mapping', -> 
      request = new Aggr.Request('/parents/:parentId/items/:itemId', {parentId: 3, itemId : 4 })
      request.assignParamsToUrl()
      assert.equal(request.url, '/parents/3/items/4')