assert = require('assert')

describe 'Aggr', -> 
  it 'simple request', done->
    aggr = new Aggr() 
    aggr
    .request('/parent/:parentId', {parentId : 1})
    .exec(callback) 


