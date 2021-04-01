
# all winning combinations of Tic Tac Toe
WIN_COMBINATIONS = [
  [0, 1, 2], # top row win
  [3, 4, 5], # middle row win
  [6, 7, 8], # bottom row win
  [0, 3, 6], # left vertical win
  [1, 4, 7], # middle vertical win
  [2, 5, 8], # right vertical win
  [6, 4, 2], # diagonal win 1
  [0, 4, 8] # diagonal win 2
  ]

# displays board at current state
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# transforms user input to array index format
def input_to_index(user_input)
  user_input.to_i - 1
end

# makes a move on the board
def move(board, index, player_token)
  board[index] = player_token
end

# returns T/F for position taken on board
def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

# returns T/F for a move on the board as long as the index is in range and position is not taken
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# returns the sum of occupied positions on board
def turn_count(board)
  taken_positions = 0
  board.each do |index|
    if index == "X" || index == "O"
      taken_positions += 1
    end
  end
  taken_positions
end

# returns player X for 3rd move
def current_player(board)
  if turn_count(board).even?
    "X"
  else 
    "O"
  end
end

# initializes a new turn by prompting user to enter 1-9, loops if invalid move
def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

# def won? procedure
# 1. for all winning options
#   2. create a variable, win_index, representing each winning index
#   3. create a variable, position, so that an object passed in can compare the object[win_index] to either 3 Xs or 3 Os

# returns the winning array or false
def won?(board)
  WIN_COMBINATIONS.each do |winning_combo|
    win_index1 = winning_combo[0]
    win_index2 = winning_combo[1]
    win_index3 = winning_combo[2]
    position1 = board[win_index1]
    position2 = board[win_index2]
    position3 = board[win_index3]
  
    if position1 == "X" && position2 == "X" && position3 == "X"
      return winning_combo # use explicit return to disrupt execution flowcontrol flow
    elsif position1 == "O" && position2 == "O" && position3 == "O"
      return winning_combo
    end
  end
  false
end

# returns T/F: true if the board is full, else false
def full?(board)
  for i in board
    if i == nil || i == "" || i == " "
      return false
    else i == "X" || i == "O"
      true
    end
  end
end

# returns T/F: true for a draw, else false
def draw?(board)
  if !won?(board) && full?(board)
    true
  else
    false
  end
end

# returns T/F: true for a draw, true for a won game AND full board, true for a won game and incomplete board
# returns false for all else, or an incomplete board and game not yet won
def over?(board)
  if draw?(board) || won?(board)
    true
  else
    false
  end
end

# returns the token of the winning player, else nil
def winner(board)
  if won?(board)
    WIN_COMBINATIONS.each do |winning_combo|
      win_index1 = winning_combo[0]
      win_index2 = winning_combo[1]
      win_index3 = winning_combo[2]
      position1 = board[win_index1]
      position2 = board[win_index2]
      position3 = board[win_index3]
    
      if position1 == "X" && position2 == "X" && position3 == "X"
        return board[win_index1] # use explicit return to disrupt execution flowcontrol flow
      elsif position1 == "O" && position2 == "O" && position3 == "O"
        return board[win_index1]
      end
    end
  else
    nil
  end
end

# is called in bin/tictactoe to initialize game
def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end