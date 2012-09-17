class GameBoard
  size: null
  rows: null
  cols: null
  cellStates: null
  canvas: null
  ctx: null

  constructor: (rows = 50,cols = 50,size = 10) ->
    @rows = rows
    @cols = cols
    @size = size
    @buildCanvas()
    @createGrid()
    @drawGrid()

  buildCanvas: ->
    # create canvas container
    @canvas = document.createElement 'canvas'
    $(@canvas).addClass('gameboard')

    # add it to the DOM
    document.body.appendChild @canvas

    # set width and height according to cellsize
    @canvas.height = @size * @rows
    @canvas.width  = @size * @cols

    # this is what we draw on
    @ctx = @canvas.getContext '2d'

  createGrid: ->
    @cellStates = []

    # initialise all cells to 0
    for row in [0...@rows]
      @cellStates[row] = []
      for col in [0...@cols]
        @cellStates[row][col] = 0

    @cellStates

  drawGrid: ->
    for row in [0...@rows]
      for col in [0...@cols]
        @drawCell( row,col )

  drawCell: (row,col) ->
    x = col * @size
    y = row * @size

    @ctx.strokeStyle = 'rgba(100, 100, 100, 1.0)'
    @ctx.strokeRect x, y, @size, @size

    if @cellStates[row][col] == 0
      fillStyle = 'rgb(50, 50, 50)'
    else
      fillStyle = 'rgb(200, 100, 0)'
    
    @ctx.fillStyle = fillStyle
    @ctx.fillRect x, y, @size, @size

  setCellState: (row,col,val) ->
    @cellStates[row][col] = val
    @drawCell(row,col)

  getCellState: (row,col) ->
    return @cellStates[row][col]

  getNumRows: ->
    @rows
  getNumCols: ->
    @cols

  updateCellStates: (newCellStates) ->
    for row in [0...@rows]
      for col in [0...@cols]
        @setCellState(row,col,newCellStates[row][col])


# necessary for outside visibility 
window.GameBoard = GameBoard
