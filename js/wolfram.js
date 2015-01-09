// Generated by CoffeeScript 1.8.0
(function() {
  var Wolfram,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Wolfram = (function() {
    var Rule;

    Rule = (function() {
      Rule.prototype.rule = 30;

      function Rule(rule) {
        if (rule == null) {
          rule = 30;
        }
        this.rule = rule;
      }

      Rule.prototype.apply = function(left, middle, right) {
        if (left && middle && right) {
          return (this.rule >> 7) & 1;
        } else if (left && middle && !right) {
          return (this.rule >> 6) & 1;
        } else if (left && !middle && right) {
          return (this.rule >> 5) & 1;
        } else if (left && !middle && !right) {
          return (this.rule >> 4) & 1;
        } else if (!left && middle && right) {
          return (this.rule >> 3) & 1;
        } else if (!left && middle && !right) {
          return (this.rule >> 2) & 1;
        } else if (!left && !middle && right) {
          return (this.rule >> 1) & 1;
        } else {
          return this.rule & 1;
        }
      };

      return Rule;

    })();

    Wolfram.prototype.board = null;

    Wolfram.prototype.tickLength = 100;

    Wolfram.prototype.row = 1;

    Wolfram.prototype.rule = null;

    function Wolfram(dims, rule) {
      if (rule == null) {
        rule = 30;
      }
      this.tick = __bind(this.tick, this);
      this.board = new GameBoard(dims, "wolfram");
      this.board.setCellState(0, Math.floor(this.board.getNumCols() / 2), 1);
      this.rule = new Rule(rule);
      this.tick();
    }

    Wolfram.prototype.tick = function() {
      this.board.drawGrid();
      this.evolve();
      return setTimeout(this.tick, this.tickLength);
    };

    Wolfram.prototype.evolve = function() {
      var col, state, _i, _ref;
      if (this.row >= this.board.getNumRows()) {
        return;
      }
      for (col = _i = 1, _ref = this.board.getNumCols() - 2; 1 <= _ref ? _i <= _ref : _i >= _ref; col = 1 <= _ref ? ++_i : --_i) {
        state = this.rule.apply(this.board.getCellState(this.row - 1, col - 1), this.board.getCellState(this.row - 1, col), this.board.getCellState(this.row - 1, col + 1));
        if (state) {
          this.board.setCellState(this.row, col, 1);
        } else {
          this.board.setCellState(this.row, col, 0);
        }
      }
      return this.row++;
    };

    return Wolfram;

  })();

  window.Wolfram = Wolfram;

}).call(this);
