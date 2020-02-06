var c = document.getElementById("canvas");
var ctx = c.getContext("2d");
var dim = 360; //KEEP THIS AT 320 OR 640 FOR NOW
var showingMoves = false;
var initial = true;
var col = 0;
var row = 0;
var turn = 2;
var hoppedPiece = 0;
c.width = dim;
c.height = dim;
ctx.strokeRect(0, 0, canvas.width, canvas.height);

// for reference:
// 1 = red
// 2 = green
// 3 = red king
// 4 = green king
// 5 = possible move
// 6 = possible jump space
var board = [
  [1, 0, 1, 0, 1, 0, 1, 0],
  [0, 1, 0, 1, 0, 1, 0, 1],
  [1, 0, 1, 0, 1, 0, 1, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 2, 0, 2, 0, 2, 0, 2],
  [2, 0, 2, 0, 2, 0, 2, 0],
  [0, 2, 0, 2, 0, 2, 0, 2],
]
drawBoard();
drawPieces();

c.addEventListener('click', function(e)
{
  // this thing is to account for the tiny space between the canvas and the window edge
  var locrect = c.getBoundingClientRect();
  var pos = {x: e.clientX - locrect.left, y: e.clientY - locrect.top};
  console.log(board);
  if (showingMoves)
  {
  	//this uses the coordinates of the mouse click to see the row and column associated with it. 
    var col1 = Math.floor(pos.x / (dim / 8));
    var row1 = Math.floor(pos.y / (dim / 8));
    //this checks if the click is on a possible move or jump space
    if (board[row1][col1] == 5 || board[row1][col1] == 6)
    {
    	//if the click is on a possible jump space
      if(board[row1][col1] == 6)
      {
      	//the average of the two coordinates are taken to find the space with the piece that was taken
        hoprow=(row1+row)/2;
        hopcol=(col1+col)/2;
        //it is set as empty because it was taken
        board[hoprow][hopcol]=0;

      }
      
      board[row1][col1] = board[row][col];
      board[row][col] = 0;
      //messages to user on whose turn it is
      if(turn == 1)
      {
      	document.getElementById("Turn").innerHTML = "Green Player's Turn";
        turn = 2;
      }
      else {
      	document.getElementById("Turn").innerHTML = "Red Player's Turn";
        turn = 1;
      }
    }
    //this iterates through the board and sets any spots that don't contain real pieces to 0.
    for (i = 0; i <= 7; i++)
    {
      for (j = 0; j <= 7; j++)
      {
        if (board[i][j] == 5 || board[i][j]==6)
        {
          board[i][j] = 0;
        }
        if(board[i][j] == 2 && i == 0)
    	{
    	  board[i][j] = 4;
    	}
    	if(board[i][j] == 1 && i == 7)
    	{
    	  board[i][j] = 3; 
    	}
        
      }
    }
    drawBoard();
    drawPieces();
    showingMoves = false;
  }
  else
  {
    checkMoves(pos);
  }
})


function drawBoard()
{
  if (initial)
  {
    ctx.shadowBlur = 20;
    initial = false;
  }
  else {
    ctx.shadowBlur = 0;
  }
  ctx.fillStyle = 'black';
  ctx.shadowColor = "black";
  for (i = 0; i <= 7; i++)
  {
    for (j = 0; j < 7; j+=2)
    {
      if (i % 2 == 0)
      {
        ctx.fillRect(j * (dim / 8), i * (dim / 8 ), dim / 8 , dim / 8);
      }
      else {
        ctx.fillRect((j + 1) * (dim / 8), i * (dim / 8), dim / 8, dim / 8);
      }
    }
  }
  ctx.shadowBlur = 0;
}

function drawPieces()
{
  ctx.shadowBlur = 0;
  //iterates through board
  for (i = 0; i < board.length; i++)
  {
    for (j = 0; j < board.length; j++)
    {
    	//if the spot isn't empty
      if (board[i][j] != 0)
      {
      	//if the piece is a red normal
        if (board[i][j] == 1)
        {
          ctx.fillStyle = 'yellow';
          ctx.strokeStyle = '#660000';
        }
        //if the piece is a red normal
        else if (board[i][j] == 2)
        {
          ctx.fillStyle = 'blue';
          ctx.strokeStyle = '#003300';
        }
         //if the piece is a red king
        else if (board[i][j] == 3)
        {
        	ctx.fillStyle = 'yellow';
          ctx.strokeStyle = '#003300';
        }
        //if the piece is a green king
        else if (board[i][j] == 4)
        {
        	ctx.fillStyle = 'yellow';
          ctx.strokeStyle = '#003300';
        }
        else
        {
          ctx.fillStyle = 'black';
          ctx.strokeStyle = "black";
        }
        
        ctx.beginPath();
        ctx.arc((dim / 16) + j * (dim / 8), (dim / 16) + i * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.fill();
        ctx.lineWidth = 4;
        ctx.stroke();
      }
    }
  }
}
function checkMovesDouble(newPos)
{
	ctx.strokeStyle = '#4ddbff';
	if(turn == 1)
	{
		if (newPos.y + 2 < 8 && newPos.x + 2 < 8 && board[newPos.y + 2][newPos.x + 2] == 0 && board[newPos.y + 1][newPos.x + 1] != 1)
      	{	
        	ctx.beginPath();
        	ctx.arc((dim / 16) + (newPos.x + 2) * (dim / 8), (dim / 16)+(newPos.y + 2) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        	ctx.stroke();
        	board[newPos.y + 2][newPos.x + 2] = 7;
        	
    
     	}
     	if (newPos.y + 2 < 8 && newPos.x - 2 < 8 && board[newPos.y + 2][newPos.x + 2] == 0 && board[newPos.y + 1][newPos.x - 1] != 1)
      	{	
        	ctx.beginPath();
        	ctx.arc((dim / 16) + (newPos.x - 2) * (dim / 8), (dim / 16)+(newPos.y + 2) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        	ctx.stroke();
        	board[newPos.y + 2][newPos.x - 2] = 7;
        	
    
     	}

	}
	else
	{
		if (newPos.y - 2 < 8 && newPos.x + 2 < 8 && board[newPos.y - 2][newPos.x + 2] == 0 && board[newPos.y - 1][newPos.x + 1] != 1)
      	{	
        	ctx.beginPath();
        	ctx.arc((dim / 16) + (newPos.x + 2) * (dim / 8), (dim / 16)+(newPos.y - 2) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        	ctx.stroke();
        	board[newPos.y + 2][newPos.x + 2] = 7;
        	
        
     	}
     	if (newPos.y - 2 < 8 && newPos.x - 2 < 8 && board[newPos.y - 2][newPos.x + 2] == 0 && board[newPos.y - 1][newPos.x - 1] != 1)
      	{	
        	ctx.beginPath();
        	ctx.arc((dim / 16) + (newPos.x - 2) * (dim / 8), (dim / 16)+(newPos.y - 2) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        	ctx.stroke();
        	board[newPos.y + 2][newPos.x - 2] = 7;
        	
        	
     	}
	}
}
function checkMoves(pos)
{
  col = Math.floor(pos.x / (dim / 8));
  row = Math.floor(pos.y / (dim / 8));
  if (board[row][col] != 0)
  {
    showingMoves = true;
    ctx.strokeStyle = '#4ddbff';
    ctx.beginPath();
    ctx.arc((dim / 16) + col * (dim / 8), (dim / 16) + row * (dim / 8), dim / 20, 0, 2 * Math.PI);
    ctx.stroke();
    if (board[row][col] == 1 && turn == 1)
    {
      if (row + 1 < 8 && col + 1 < 8 && board[row + 1][col + 1] == 0)
      {
        ctx.beginPath();
        ctx.arc((dim / 16) + (col + 1) * (dim / 8), (dim / 16)+(row + 1) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.stroke();
        board[row + 1][col + 1] = 5;
      }
      else if (row + 2 < 8 && col + 2 < 8 && board[row + 2][col + 2] == 0 && board[row + 1][col + 1] != 1)
      {
        ctx.beginPath();
        ctx.arc((dim / 16) + (col + 2) * (dim / 8), (dim / 16)+(row + 2) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.stroke();
        board[row + 2][col + 2] = 6;
        var newPos = {x:col+2 , y:row+2};
        checkMovesDouble(newPos);
      }
      if (row + 1 < 8 && col - 1 >= 0 && board[row + 1][col - 1] == 0)
      {
        ctx.beginPath();
        ctx.arc((dim / 16) + (col - 1) * (dim / 8), (dim / 16) + (row + 1) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.stroke();
        board[row + 1][col - 1] = 5;
      }
      else if (row + 2 < 8 && col - 2 >= 0 && board[row + 2][col - 2] == 0 && board[row + 1][col - 1] != 1)
      {
        ctx.beginPath();
        ctx.arc((dim / 16) + (col - 2) * (dim / 8), (dim / 16)+(row + 2) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.stroke();
        board[row + 2][col - 2] = 6;
        var newPos = {x:col-2 , y:row+2};
        checkMovesDouble(newPos);
      }
    }
    else if (board[row][col] == 2 && turn == 2)
    {
      if (row - 1 >= 0 && col + 1 < 8 && board[row - 1][col + 1] == 0)
      {
        ctx.beginPath();
        ctx.arc((dim / 16) + (col + 1) * (dim / 8), (dim / 16)+(row - 1) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.stroke();
        board[row - 1][col + 1] = 5;
      }
      else if (row - 2 >= 0 && col + 2 < 8 && board[row - 2][col + 2] == 0 && board[row - 1][col + 1] != 2)
      {
        ctx.beginPath();
        ctx.arc((dim / 16) + (col + 2) * (dim / 8), (dim / 16)+(row - 2) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.stroke();
        board[row - 2][col + 2] = 6;
        var newPos = {x:col+2 , y:row-2};
        checkMovesDouble(newPos);
      }
      if (row - 1 < 8 && col - 1 >= 0 && board[row - 1][col - 1] == 0)
      {
        ctx.beginPath();
        ctx.arc((dim / 16) + (col - 1) * (dim / 8), (dim / 16) + (row - 1) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.stroke();
        board[row - 1][col - 1] = 5;
      }
      else if (row - 2 >= 0 && col - 2 >= 0 && board[row - 2][col - 2] == 0 && board[row - 1][col - 1] != 2)
      {
        ctx.beginPath();
        ctx.arc((dim / 16) + (col - 2) * (dim / 8), (dim / 16)+(row - 2) * (dim / 8), dim / 20, 0, 2 * Math.PI);
        ctx.stroke();
        board[row - 2][col - 2] = 6;
        var newPos = {x:col-2 , y:row-2};
        checkMovesDouble(newPos);
      }
    }
    
  }
}
