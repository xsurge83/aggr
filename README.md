- [ ] get simple request 
- [ ] a task list item
```javascript 
aggr
  .load('simple case')
  .request('/item/{id}', 1)
  .exec(callback)
````

- [ ] get parent and child its childern  
```javascript 
parent = {
  parentId : 1, 
  childId: 2 
}
aggr
.load('parent with children id from parent')
.request('/parent/{parentId}', {parentId : '1'})
.append('/parent/{parentId}/children/{childId}','childId', 'child')
.exec(callback)
```
- [ ] get parent
```javascript 
aggr
 .load('parent with child id from outside')
 .request('/parent/{parentId}', {parentId: '1'})
 .appendReq('/parent/{parentId}/child/{childId}', { childId : 2} , 'child')
 .exec(callback) 
 ``` 