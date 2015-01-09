class Wolfram
  class Rule
    rule: 30
    constructor: (rule = 30) ->
      @rule = rule
    apply: ( left, middle, right ) ->
      if (left && middle && right)
        return ((@rule >> 7) & 1)
      else if (left && middle && !right)
        return ((@rule >> 6) & 1)
      else if (left && !middle && right)
        return ((@rule >> 5) & 1)
      else if (left && !middle && !right)
        return ((@rule >> 4) & 1)
      else if (!left && middle && right)
        return ((@rule >> 3) & 1)
      else if (!left && middle && !right)
        return ((@rule >> 2) & 1)
      else if (!left && !middle && right)
        return ((@rule >> 1) & 1)
      else
        return (@rule & 1);

  board: null
  tickLength: 100
  row: 1
  rule: null

  constructor: (dims,rule = 30) ->
    @board = new GameBoard(dims, "wolfram")
    @board.setCellState(0, Math.floor(@board.getNumCols() / 2), 1)
    @rule = new Rule(rule)
    @tick()

  tick: =>
    @board.drawGrid()
    @evolve()

    setTimeout @tick, @tickLength

  evolve: ->
    if @row >= @board.getNumRows()
      return

    for col in [1..@board.getNumCols()-2]
      state = @rule.apply( @board.getCellState(@row-1,col-1),@board.getCellState(@row-1,col),@board.getCellState(@row-1,col+1))
      if state
        @board.setCellState(@row,col,1)
      else
        @board.setCellState(@row,col,0)
    @row++

window.Wolfram = Wolfram
