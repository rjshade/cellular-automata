class Ant
  row: 5
  col: 5
  direction: [1,0]

  constructor: (row,col) ->
    @row = row
    @col = col

  turnLeft: ->
    prev = @direction
    if      @direction[0] ==  1 and @direction[1] ==  0
      @direction = [0,1]

    else if @direction[0] ==  0 and @direction[1] ==  1 
      @direction = [-1,0]

    else if @direction[0] == -1 and @direction[1] ==  0
      @direction = [0,-1]

    else if @direction[0] ==  0 and @direction[1] == -1
      @direction = [1,0]
    #alert('turned left, prev= ' + prev + '  now= ' + @direction)

  turnRight: ->
    prev = @direction
    if     @direction[0] ==  1 and @direction[1] ==  0
      @direction = [0,-1]

    else if @direction[0] ==  0 and @direction[1] == -1 
      @direction = [-1,0]

    else if @direction[0] == -1 and @direction[1] ==  0
      @direction = [0,1]

    else if @direction[0] ==  0 and @direction[1] ==  1
      @direction = [1,0]
    #alert('turned right, prev= ' + prev + '  now= ' + @direction)

  moveForwards: ->
    @row += @direction[0]
    @col += @direction[1]

class Langton
  board: null
  tickLength: 100
  ant: null
  constructor: ->
    @board = new GameBoard()
    @ant = new Ant(25,25)
    @tick()

  tick: =>
    @board.drawGrid()
    @evolve()

    setTimeout @tick, @tickLength

  drawAnt: ->
    @board.setCellState(@ant.row,@ant.col,0)

  evolve: ->
    row = @ant.row
    col = @ant.col
    state = @board.getCellState( row, col )
    if state == 1
      @board.setCellState( row, col, 0 )
      @ant.turnRight()
    else if state == 0
      @board.setCellState( row, col, 1 )
      @ant.turnLeft()
    @ant.moveForwards()

window.Langton = Langton
