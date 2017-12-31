(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var App, React;

React = require('react');

App = require('./app');

React.render(React.createElement(App, null), document.getElementById('app'));



},{"./app":2,"react":"react"}],2:[function(require,module,exports){
var App, Configs, Node, Path, React, ee;

React = require('react');

ee = require('./global/Events');

Node = require("./figures/Node");

Path = require("./figures/Path");

Configs = require('./config/Configs');

App = React.createClass({
  getInitialState: function() {
    return {
      figures: [],
      val: 0,
      IdsPath: [],
      Paths: [],
      Matrix: [],
      colorNodes: "#2e9f5c"
    };
  },
  displayName: 'App',
  handleClick: function(e) {
    this.setState({
      val: this.state.val + 1
    });
    if (e.target.nodeName === "svg") {
      this.AddNode(e.nativeEvent.offsetX, e.nativeEvent.offsetY, "circle" + this.state.val, this.state.colorNodes);
    }
    if (e.target.nodeName === "circle") {
      return this.AddPath(e.target.id);
    }
  },
  AddNode: function(cx, cy, id, color) {
    return this.state.figures.push({
      cx: cx,
      cy: cy,
      id: id,
      color: color
    });
  },
  AddPath: function(id) {
    this.state.IdsPath.push(id);
    if (this.state.IdsPath.length === 2) {
      this.DrawPath(this.state.IdsPath);
      this.state.Matrix.push(this.state.IdsPath);
      return this.setState({
        IdsPath: []
      });
    }
  },
  DrawPath: function(ids) {
    var coords, cx, cy, i, j, k, l, len, len1, str;
    coords = [];
    str = "M";
    if (ids[0] === ids[1]) {
      coords.push({
        cx: document.getElementById(ids[0]).attributes.cx.value,
        cy: document.getElementById(ids[0]).attributes.cy.value
      });
      cx = +coords[0].cx;
      cy = +coords[0].cy;
      str = "M" + cx + " " + cy + " C " + (cx - 150) + " " + (cy - 150) + ", " + (cx + 150) + " " + (cy - 150) + ", " + cx + " " + cy;
    } else {
      for (k = 0, len = ids.length; k < len; k++) {
        i = ids[k];
        coords.push({
          cx: document.getElementById(i).attributes.cx.value,
          cy: document.getElementById(i).attributes.cy.value
        });
      }
      for (j = l = 0, len1 = coords.length; l < len1; j = ++l) {
        i = coords[j];
        if (j === 0) {
          str += " " + i.cx + ", " + i.cy;
        } else {
          str += "L " + i.cx + ", " + i.cy + "Z";
        }
      }
    }
    return this.state.Paths.push(str);
  },
  componentWillMount: function() {
    return ee.on('changeColorNodes', ((function(_this) {
      return function(color) {
        console.log(color);
        return _this.setState({
          colorNodes: color.color
        });
      };
    })(this)));
  },
  render: function() {
    return React.createElement("div", {
      "id": "wrap"
    }, React.createElement("svg", {
      "height": "100%",
      "version": "1.1",
      "width": "100%",
      "xmlns": "http://www.w3.org/2000/svg",
      "onClick": ((function(_this) {
        return function(e) {
          return _this.handleClick(e);
        };
      })(this))
    }, React.createElement("desc", null, "Created with Daniil(den50)"), React.createElement("defs", null), this.state.Paths.map(function(i) {
      return React.createElement(Path, {
        "d": i
      });
    }), this.state.figures.map((function(_this) {
      return function(i) {
        return React.createElement(Node, {
          "cx": i.cx,
          "cy": i.cy,
          "id": i.id,
          "bgc": i.color
        });
      };
    })(this))), React.createElement(Configs, null));
  }
});

module.exports = App;



},{"./config/Configs":3,"./figures/Node":5,"./figures/Path":6,"./global/Events":7,"react":"react"}],3:[function(require,module,exports){
var COLORS, Colors, Configs, React, ee;

React = require('react');

Colors = require("./colors");

ee = require('../global/Events');

COLORS = ["#2e9f5c", "#47356C", "#FF0018", "#0DF6FF", "#440BDB", "#FFAA0D"];

Configs = React.createClass({
  displayName: 'Configs',
  getInitialState: function() {
    return {
      active: 0,
      Items: [],
      colorNow: "#2e9f5c"
    };
  },
  handleChangeColor: function(id) {
    var i, j, k, len, ref, results;
    this.setState({
      active: id
    });
    ref = this.state.Items;
    results = [];
    for (j = k = 0, len = ref.length; k < len; j = ++k) {
      i = ref[j];
      if (i.active) {
        this.state.Items[j].active = false;
        continue;
      }
      if (i.id === id) {
        this.state.Items[j].active = true;
        this.setState({
          colorNow: i.color
        });
        results.push(ee.emit("changeColorNodes", {
          color: i.color
        }));
      } else {
        results.push(void 0);
      }
    }
    return results;
  },
  componentWillMount: function() {
    var i, j, k, len, results;
    results = [];
    for (j = k = 0, len = COLORS.length; k < len; j = ++k) {
      i = COLORS[j];
      results.push(this.state.Items.push({
        color: i,
        id: j,
        active: j === 0 ? true : false
      }));
    }
    return results;
  },
  render: function() {
    return React.createElement("div", {
      "className": "wrap_configs"
    }, React.createElement("div", {
      "className": "configs"
    }, React.createElement(Colors, {
      "colors": this.state.Items,
      "onChange": ((function(_this) {
        return function(id) {
          return _this.handleChangeColor(id);
        };
      })(this))
    }), React.createElement("hr", null)));
  }
});

module.exports = Configs;



},{"../global/Events":7,"./colors":4,"react":"react"}],4:[function(require,module,exports){
var Colors, React;

React = require('react');

Colors = React.createClass({
  displayName: 'Colors',
  handleSwitch: function(id) {
    return console.log(id);
  },
  render: function() {
    return React.createElement("div", {
      "className": "colors_switch"
    }, React.createElement("span", {
      "id": "span_switch_color"
    }, "Switch color nodes:"), React.createElement("br", null), this.props.colors.map((function(_this) {
      return function(i) {
        return React.createElement("div", {
          "style": {
            backgroundColor: i.color
          },
          "className": (i.active ? "color_item active" : "color_item"),
          "onClick": _this.props.onChange.bind(null, i.id)
        });
      };
    })(this)));
  }
});

module.exports = Colors;



},{"react":"react"}],5:[function(require,module,exports){
var Node, React;

React = require('react');

Node = React.createClass({
  displayName: 'Node',
  render: function() {
    return React.createElement("circle", {
      "cx": this.props.cx,
      "cy": this.props.cy,
      "r": "20",
      "fill": this.props.bgc,
      "id": this.props.id
    });
  }
});

module.exports = Node;



},{"react":"react"}],6:[function(require,module,exports){
var Path, React;

React = require('react');

Path = React.createClass({
  displayName: 'Path',
  render: function() {
    return React.createElement("path", {
      "d": this.props.d,
      "fill": "transparent",
      "stroke": "black",
      "style": {
        strokeWidth: 2
      }
    });
  }
});

module.exports = Path;



},{"react":"react"}],7:[function(require,module,exports){
var EventEmitter, ee;

EventEmitter = require("events").EventEmitter;

ee = new EventEmitter;

module.exports = ee;



},{"events":8}],8:[function(require,module,exports){
// Copyright Joyent, Inc. and other Node contributors.
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
// NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.

function EventEmitter() {
  this._events = this._events || {};
  this._maxListeners = this._maxListeners || undefined;
}
module.exports = EventEmitter;

// Backwards-compat with node 0.10.x
EventEmitter.EventEmitter = EventEmitter;

EventEmitter.prototype._events = undefined;
EventEmitter.prototype._maxListeners = undefined;

// By default EventEmitters will print a warning if more than 10 listeners are
// added to it. This is a useful default which helps finding memory leaks.
EventEmitter.defaultMaxListeners = 10;

// Obviously not all Emitters should be limited to 10. This function allows
// that to be increased. Set to zero for unlimited.
EventEmitter.prototype.setMaxListeners = function(n) {
  if (!isNumber(n) || n < 0 || isNaN(n))
    throw TypeError('n must be a positive number');
  this._maxListeners = n;
  return this;
};

EventEmitter.prototype.emit = function(type) {
  var er, handler, len, args, i, listeners;

  if (!this._events)
    this._events = {};

  // If there is no 'error' event listener then throw.
  if (type === 'error') {
    if (!this._events.error ||
        (isObject(this._events.error) && !this._events.error.length)) {
      er = arguments[1];
      if (er instanceof Error) {
        throw er; // Unhandled 'error' event
      }
      throw TypeError('Uncaught, unspecified "error" event.');
    }
  }

  handler = this._events[type];

  if (isUndefined(handler))
    return false;

  if (isFunction(handler)) {
    switch (arguments.length) {
      // fast cases
      case 1:
        handler.call(this);
        break;
      case 2:
        handler.call(this, arguments[1]);
        break;
      case 3:
        handler.call(this, arguments[1], arguments[2]);
        break;
      // slower
      default:
        len = arguments.length;
        args = new Array(len - 1);
        for (i = 1; i < len; i++)
          args[i - 1] = arguments[i];
        handler.apply(this, args);
    }
  } else if (isObject(handler)) {
    len = arguments.length;
    args = new Array(len - 1);
    for (i = 1; i < len; i++)
      args[i - 1] = arguments[i];

    listeners = handler.slice();
    len = listeners.length;
    for (i = 0; i < len; i++)
      listeners[i].apply(this, args);
  }

  return true;
};

EventEmitter.prototype.addListener = function(type, listener) {
  var m;

  if (!isFunction(listener))
    throw TypeError('listener must be a function');

  if (!this._events)
    this._events = {};

  // To avoid recursion in the case that type === "newListener"! Before
  // adding it to the listeners, first emit "newListener".
  if (this._events.newListener)
    this.emit('newListener', type,
              isFunction(listener.listener) ?
              listener.listener : listener);

  if (!this._events[type])
    // Optimize the case of one listener. Don't need the extra array object.
    this._events[type] = listener;
  else if (isObject(this._events[type]))
    // If we've already got an array, just append.
    this._events[type].push(listener);
  else
    // Adding the second element, need to change to array.
    this._events[type] = [this._events[type], listener];

  // Check for listener leak
  if (isObject(this._events[type]) && !this._events[type].warned) {
    var m;
    if (!isUndefined(this._maxListeners)) {
      m = this._maxListeners;
    } else {
      m = EventEmitter.defaultMaxListeners;
    }

    if (m && m > 0 && this._events[type].length > m) {
      this._events[type].warned = true;
      console.error('(node) warning: possible EventEmitter memory ' +
                    'leak detected. %d listeners added. ' +
                    'Use emitter.setMaxListeners() to increase limit.',
                    this._events[type].length);
      if (typeof console.trace === 'function') {
        // not supported in IE 10
        console.trace();
      }
    }
  }

  return this;
};

EventEmitter.prototype.on = EventEmitter.prototype.addListener;

EventEmitter.prototype.once = function(type, listener) {
  if (!isFunction(listener))
    throw TypeError('listener must be a function');

  var fired = false;

  function g() {
    this.removeListener(type, g);

    if (!fired) {
      fired = true;
      listener.apply(this, arguments);
    }
  }

  g.listener = listener;
  this.on(type, g);

  return this;
};

// emits a 'removeListener' event iff the listener was removed
EventEmitter.prototype.removeListener = function(type, listener) {
  var list, position, length, i;

  if (!isFunction(listener))
    throw TypeError('listener must be a function');

  if (!this._events || !this._events[type])
    return this;

  list = this._events[type];
  length = list.length;
  position = -1;

  if (list === listener ||
      (isFunction(list.listener) && list.listener === listener)) {
    delete this._events[type];
    if (this._events.removeListener)
      this.emit('removeListener', type, listener);

  } else if (isObject(list)) {
    for (i = length; i-- > 0;) {
      if (list[i] === listener ||
          (list[i].listener && list[i].listener === listener)) {
        position = i;
        break;
      }
    }

    if (position < 0)
      return this;

    if (list.length === 1) {
      list.length = 0;
      delete this._events[type];
    } else {
      list.splice(position, 1);
    }

    if (this._events.removeListener)
      this.emit('removeListener', type, listener);
  }

  return this;
};

EventEmitter.prototype.removeAllListeners = function(type) {
  var key, listeners;

  if (!this._events)
    return this;

  // not listening for removeListener, no need to emit
  if (!this._events.removeListener) {
    if (arguments.length === 0)
      this._events = {};
    else if (this._events[type])
      delete this._events[type];
    return this;
  }

  // emit removeListener for all listeners on all events
  if (arguments.length === 0) {
    for (key in this._events) {
      if (key === 'removeListener') continue;
      this.removeAllListeners(key);
    }
    this.removeAllListeners('removeListener');
    this._events = {};
    return this;
  }

  listeners = this._events[type];

  if (isFunction(listeners)) {
    this.removeListener(type, listeners);
  } else {
    // LIFO order
    while (listeners.length)
      this.removeListener(type, listeners[listeners.length - 1]);
  }
  delete this._events[type];

  return this;
};

EventEmitter.prototype.listeners = function(type) {
  var ret;
  if (!this._events || !this._events[type])
    ret = [];
  else if (isFunction(this._events[type]))
    ret = [this._events[type]];
  else
    ret = this._events[type].slice();
  return ret;
};

EventEmitter.listenerCount = function(emitter, type) {
  var ret;
  if (!emitter._events || !emitter._events[type])
    ret = 0;
  else if (isFunction(emitter._events[type]))
    ret = 1;
  else
    ret = emitter._events[type].length;
  return ret;
};

function isFunction(arg) {
  return typeof arg === 'function';
}

function isNumber(arg) {
  return typeof arg === 'number';
}

function isObject(arg) {
  return typeof arg === 'object' && arg !== null;
}

function isUndefined(arg) {
  return arg === void 0;
}

},{}]},{},[1]);
