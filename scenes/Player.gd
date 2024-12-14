extends StaticBody2D

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
	# Move the paddle up if the "ui_up" action is pressed
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta  # Move paddle upwards based on input and delta time
	# Move the paddle down if the "ui_down" action is pressed
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta  # Move paddle downwards based on input and delta time

	# Limit the paddle's vertical position to stay within the game window bounds
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
