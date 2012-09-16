class GameBoard
  cellSize: 10
  numRows: 50
  numColumns: 50
  cellStates: null
  canvas: null
  ctx: null

  constructor: ->
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
    @canvas.height = @cellSize * @numRows
    @canvas.width  = @cellSize * @numColumns

    # this is what we draw on
    @ctx = @canvas.getContext '2d'

  createGrid: ->
    @cellStates = []

    # initialise all cells to 0
    for row in [0...@numRows]
      @cellStates[row] = []
      for column in [0...@numColumns]
        @cellStates[row][column] = 0

  drawGrid: ->
    for row in [0...@numRows]
      for col in [0...@numColumns]
        @drawCell( row,col )

  drawCell: (row,col) ->
    x = col * @cellSize
    y = row * @cellSize

    @ctx.strokeStyle = 'rgba(100, 100, 100, 1.0)'
    @ctx.strokeRect x, y, @cellSize, @cellSize

    if @cellStates[row][col] == 0
      fillStyle = 'rgb(50, 50, 50)'
    else
      fillStyle = 'rgb(200, 100, 0)'
    
    @ctx.fillStyle = fillStyle
    @ctx.fillRect x, y, @cellSize, @cellSize

  setCellState: (row,col,val) ->
    @cellStates[row][col] = val
    @drawCell(row,col)

  getCellState: (row,col) ->
    return @cellStates[row][col]

# necessary for outside visibility 
window.GameBoard = GameBoard
