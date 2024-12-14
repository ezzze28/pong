extends StaticBody2D

var ball_pos : Vector2  # Position of the ball
var dist : int  # Distance between the paddle and the ball
var move_by : int  # The amount to move the paddle
var win_height : int  # Height of the game window
var p_height : int  # Height of the paddle

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the height of the window (viewport)
	win_height = get_viewport_rect().size.y
	# Get the height of the paddle by accessing the size of the ColorRect node (the paddle's graphical representation)
	p_height = $ColorRect.get_size().y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the current position of the ball
	ball_pos = $"../Ball".position
	# Calculate the vertical distance between the paddle and the ball
	dist = position.y - ball_pos.y
	
	# Check if the paddle needs to move
	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		# Move the paddle towards the ball at a speed scaled by delta time (frame-rate independent)
		move_by = get_parent().PADDLE_SPEED * delta * (dist / abs(dist))  # Move in the direction of the ball
	else:
		# If the paddle is already close enough to the ball, just move it by the remaining distance
		move_by = dist

	# Update the paddle's position
	position.y -= move_by
	
	# Clamp the paddle's vertical position to ensure it stays within the game window
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
