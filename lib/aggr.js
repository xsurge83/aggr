var Aggr, Hierarchy, Request, async, exports, superagent, _,
  __hasProp = {}.hasOwnProperty;

superagent = require('superagent');

async = require('async');

_ = require('underscore');

Hierarchy = {
  Parent: 1,
  Child: 2,
  Siblings: 3
};

Request = (function() {
  Request.prototype.url = null;

  function Request(urlTemplate, urlParams, heirarchy, propContName) {
    this.urlTemplate = urlTemplate;
    this.urlParams = urlParams;
    this.heirarchy = heirarchy != null ? heirarchy : Hierarchy.Parent;
    this.propContName = propContName;
  }

  Request.prototype.assignParamsToUrl = function() {
    var urlParam, value, _ref, _results;
    this.url = this.urlTemplate.toLowerCase();
    _ref = this.urlParams;
    _results = [];
    for (urlParam in _ref) {
      if (!__hasProp.call(_ref, urlParam)) continue;
      value = _ref[urlParam];
      _results.push(this.url = this.url.replace(':' + urlParam.toLowerCase(), value));
    }
    return _results;
  };

  return Request;

})();

/*
Todo:
 - add append logic 
 - persist params to for reuse of other requests 
- reuse param unless specified for that request
*/


Aggr = (function() {
  var getChildBlock;

  function Aggr(http) {
    this.http = http != null ? http : new superagent.agent();
    this.params = {};
    this.requests = [];
    this.getBindings = this.http.get.bind(this.http);
  }

  /*
  * todo: 
  * - reserve query property in param
  */


  Aggr.prototype.request = function(urlTemplate, params) {
    var key, request, value;
    if (typeof ulrParam === 'object') {
      params = {
        id: params
      };
    }
    for (key in params) {
      value = params[key];
      this.params[key] = value;
    }
    request = new Request(urlTemplate, params);
    request.assignParamsToUrl();
    this.requests.push(request);
    return this;
  };

  /* todo: 
  ## move to request 
  * /parent/child 
  * /parent/:parentid/children
  */


  getChildBlock = function(urlTemplate, level) {
    var block, urlBlocks;
    urlBlocks = urlTemplate.split('/');
    block = urlBlocks[level].trim();
    if (block[0] === ':') {
      block = urlBlocks[level * 2 - 1];
      if (block[0] === ':') {
        block = null;
      }
    } else {
      block = null;
    }
    return block;
  };

  Aggr.prototype.append = function(urlTemplate) {
    var lastBlock, request, urlBlocks;
    urlBlocks = urlTemplate.split('/');
    lastBlock = getChildBlock(urlTemplate, 2);
    console.log("d", lastBlock);
    request = new Request(urlTemplate, this.params, Hierarchy.Child, lastBlock);
    request.assignParamsToUrl();
    console.log('% request', request);
    this.requests.push(request);
    return this;
  };

  Aggr.prototype._getResult = function(request, callback) {
    return this.http.get(request.url, function(error, result) {
      if (result) {
        result.request = request;
      }
      return callback(error, result);
    });
  };

  Aggr.prototype.exec = function(callback) {
    var asyncTasks, request, _i, _len, _ref;
    asyncTasks = [];
    debugger;
    _ref = this.requests;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      request = _ref[_i];
      console.log(request.url);
      asyncTasks.push(async.apply(this._getResult.bind(this), request));
    }
    return async.parallel(asyncTasks, function(error, responses) {
      var obj;
      if (_.isArray(responses)) {
        obj = responses.shift(1).data;
        _.each(responses, function(response) {
          if (response.request.propContName) {
            return obj[response.request.propContName] = response.data;
          }
        });
      } else {
        obj = response.data;
      }
      return callback(error, obj);
    });
  };

  return Aggr;

})();

Aggr.Request = Request;

exports = module.exports = Aggr;
