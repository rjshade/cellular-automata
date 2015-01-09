class Langton
  class Ant
    row: 5
    col: 5
    direction: [1,0]
  
    constructor: (row,col) ->
      @row = row
      @col = col
  
    turnLeft: ->
      prev = @direction
      if @direction[0] ==  1 and @direction[1] ==  0
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
      if @direction[0] ==  1 and @direction[1] ==  0
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

    wrapPosition: (rows,cols) ->
      if @row < 0
        @row = rows - 1
      if @row >= rows
        @row = 0
      if @col < 0
        @col = cols - 1
      if @col >= cols
        @col = 0


  board: null
  tickLength: 100
  ant: null
  constructor: (dims) ->
    @board = new GameBoard(dims, "langton")
    # create ant in center of board
    @ant = new Ant(Math.floor(dims.rows/2),Math.floor(dims.cols/2))
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

    @moveAntForwards()

  moveAntForwards: ->
    @ant.moveForwards()
    @ant.wrapPosition(@board.getNumRows(),@board.getNumCols())

window.Langton = Langton
