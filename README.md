-  get simple request 
```javascript 
aggr
  .load('simple case')
  .request('/item/:id', 1)
  .exec(callback)
````

-  get parent and it's children 
```javascript 
aggr
.load('parent with children id from parent')
.request('/parent/:parentId', {parentId : '1'})
.append('/parent/:parentId/children')
.exec(callback)
```

-  get parent and it's children by children ids from parent
```javascript 
aggr
.load('parent with children id from parent')
.request('/parent/:parentId', {parentId : '1'})
.append('/parent/:parentId/children/:childId')
.exec(callback)
```
**Note childId is a property of parent** 

-  get parent and child its child  
```javascript 
parent = {
  parentId : 1, 
  childId: 2 
}
aggr
.load('parent with children id from parent')
.request('/parent/:parentId', {parentId : '1'})
.append('/parent/:parentId/children/:childId','childId', 'child')
.exec(callback)
```
- get parent
```javascript 
aggr
 .load('parent with child id from outside')
 .request('/parent/:parentId', {parentId: '1'})
 .appendReq('/parent/:parentId/child/:childId', { childId : 2} , 'child')
 .exec(callback) 
 ``` 

## Todo: 
 - look for library for url conversions 
 - 
