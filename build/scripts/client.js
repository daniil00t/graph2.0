(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var App, React;

React = require('react');

App = require('./app');

React.render(React.createElement(App, null), document.getElementById('app'));



},{"./app":2,"react":"react"}],2:[function(require,module,exports){
var App, Configs, Node, Path, React;

React = require('react');

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
      CONFIGS: {}
    };
  },
  displayName: 'App',
  handleClick: function(e) {
    this.setState({
      val: this.state.val + 1
    });
    if (e.target.nodeName === "svg") {
      this.AddNode(e.nativeEvent.offsetX, e.nativeEvent.offsetY, "circle" + this.state.val);
    }
    if (e.target.nodeName === "circle") {
      return this.AddPath(e.target.id);
    }
  },
  AddNode: function(cx, cy, id) {
    return this.state.figures.push({
      cx: cx,
      cy: cy,
      id: id
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
    }, React.createElement("desc", null, "Created with Snap"), React.createElement("defs", null), this.state.Paths.map(function(i) {
      return React.createElement(Path, {
        "d": i
      });
    }), this.state.figures.map(function(i) {
      return React.createElement(Node, {
        "cx": i.cx,
        "cy": i.cy,
        "id": i.id
      });
    })), React.createElement(Configs, null));
  }
});

module.exports = App;



},{"./config/Configs":3,"./figures/Node":5,"./figures/Path":6,"react":"react"}],3:[function(require,module,exports){
var COLORS, Colors, Configs, React;

React = require('react');

Colors = require("./colors");

COLORS = ["#2e9f5c", "#000", "blue", "red", "green", "gold"];

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
        results.push(this.setState({
          colorNow: i.color
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



},{"./colors":4,"react":"react"}],4:[function(require,module,exports){
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
      "fill": "#2e9f5c",
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



},{"react":"react"}]},{},[1]);
