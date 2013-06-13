assert = require 'assert'
HttpMock = require './mocks/httpMock'
Aggr = require './../lib/aggr'
should = require 'should'

httpMock = new HttpMock() 

describe 'Aggr', -> 
  parent = 
    name : 'parent'
  children = [
      name: "child1"
    ,
      name: "child2"
    ]

  it 'single request', (done) -> 
    httpMock.expectGET('/parent/1', parent, 200)
    aggr = new Aggr(httpMock) 
    aggr
    .request('/parent/:parentId', {parentId : 1})
    .exec((error, result)->
      result.should.have.property('name', parent.name )
      done() 
      ) 
   it.skip 'it should fail to get request', -> 
    ## todo: return error in the callback and the data that was 
    ## was retreived successfully. 
    should.fail() 

  it 'should get parent with children', (done) ->
    httpMock.expectGET('/parent/1', parent, 200)
    httpMock.expectGET('/parent/1/children', children, 200)

    aggr = new Aggr(httpMock) 
    aggr
    .request('/parent/:parentId', {parentId : 1})
    .append('/parent/:parentId/children')
    .exec((error, result)->
      result.should.have.property('name', parent.name )
      result.should.have.property('children', children)
      done() 
      ) 

  it 'get parent and its children by children ids from parent', (done) ->
    parentsWithChildIds = 
      name : 'parent'
      childIds : [2, 3]
    myChildren = [
      id : 2 
      name: "child1"
    ,
      id : 3 
      name: "child2"
    ]

    httpMock.expectGET('/parent/1', parentsWithChildIds, 200)
    httpMock.expectGET('/parent/1/children/2', myChildren[0], 200)
      
    aggr = new Aggr(httpMock) 
    aggr
    .request('/parent/:parentId', {parentId : 1})
    .append('/parent/:parentId/children/:childId',  (childProp)-> return (child)-> child)
    .exec((error, result)->
      result.should.have.property('name', parent.name )
      result.should.have.property('children', myChildren)
      done() 
      ) 



