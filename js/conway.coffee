class Conway
  board: null
  tickLength: 500
  rows: null
  cols: null

  constructor: (dims) ->
    @board = new GameBoard(dims, "conway")

    # don't want to be calling every iteration
    @rows = @board.getNumRows()
    @cols = @board.getNumCols()

    @seed()
    @tick()

  seed: ->
    for row in [0...@rows]
      for col in [0...@cols]
        rnd = Math.random()
        if rnd > 0.7
          @board.setCellState( row,col,1 )

  tick: =>
    @board.drawGrid()
    @evolve()
    setTimeout @tick, @tickLength

  evolve: ->
    #alert('evolve')
    newCellStates = []
    for row in [0...@rows]
      newCellStates[row] = []
      for col in [0...@cols]
        curState = @board.getCellState(row,col)
        nei = @countNeighbours(row,col)

        if nei > 3 or nei < 2
          newCellStates[row][col] = 0
        else if nei == 3
          newCellStates[row][col] = 1
        else
          newCellStates[row][col] = curState

    @board.updateCellStates(newCellStates)

  cellAlive: (row,col) ->
    return (@board.getCellState(row,col) == 1)

  countNeighbours: (row,col) ->
    count = 0

    row_low = row - 1
    row_high = row + 1
    col_low = col - 1
    col_high = col + 1

    if row_low < 0 
      row_low = @rows - 1
    if row_high >= @rows
      row_high = 0
    if col_low < 0
      col_low = @cols - 1
    if col_high >= @cols
      col_high = 0

    if(@cellAlive(row_low, col_low))
      count++
    if(@cellAlive(row_low, col))
      count++
    if(@cellAlive(row_low, col_high))
      count++
    if(@cellAlive(row, col_low))
      count++
    if(@cellAlive(row, col_high))
      count++
    if(@cellAlive(row_high, col_low))
      count++
    if(@cellAlive(row_high, col))
      count++
    if(@cellAlive(row_high, col_high))
      count++

    #$('#debug').html('rl: ' + row_low + ' rh: ' + row_high + ' cl: ' + col_low + ' ch: ' + col_high + ' count = ' + count)
    count
 
window.Conway = Conway
