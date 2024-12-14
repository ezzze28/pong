extends CharacterBody2D

var win_size : Vector2
const START_SPEED : int = 500  # Starting speed of the ball
const ACCEL : int = 50  # Speed increase upon hitting a paddle
var speed : int  # Current speed of the ball
var dir : Vector2  # Direction vector of the ball
const MAX_Y_VECTOR : float = 0.6  # Maximum Y-direction factor for the ball's bounce

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the size of the viewport (the game window)
	win_size = get_viewport_rect().size

# Function to initialize the ball's position and direction
func new_ball():
	# Randomize start position and direction
	position.x = win_size.x / 2  # Place the ball at the center horizontally
	position.y = randi_range(200, win_size.y - 200)  # Randomize vertical position within limits
	speed = START_SPEED  # Set the starting speed
	dir = random_direction()  # Set a random direction for the ball

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Move the ball and check for collisions
	var collision = move_and_collide(dir * speed * delta)  # Move ball and check for collisions
	var collider
	if collision:
		# If a collision occurs, get the object it collided with
		collider = collision.get_collider()
		
		# If the ball hits the player's or CPU's paddle
		if collider == $"../Player" or collider == $"../CPU":
			speed += ACCEL  # Increase speed
			dir = new_direction(collider)  # Calculate new direction based on the paddle hit
		# If the ball hits a wall
		else:
			dir = dir.bounce(collision.get_normal())  # Bounce the ball off the wall

# Function to generate a random direction for the ball
func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()  # Randomly pick between moving left or right
	new_dir.y = randf_range(-1, 1)  # Randomly set vertical direction (up or down)
	return new_dir.normalized()  # Normalize the direction vector to ensure constant speed

# Function to calculate the new direction after the ball hits a paddle
func new_direction(collider):
	var ball_y = position.y  # Ball's current vertical position
	var pad_y = collider.position.y  # Paddle's vertical position
	var dist = ball_y - pad_y  # Distance between the ball and the paddle
	var new_dir := Vector2()
	
	# Flip the horizontal direction of the ball
	if dir.x > 0:
		new_dir.x = -1  # Ball should move left if it was moving right
	else:
		new_dir.x = 1  # Ball should move right if it was moving left
	
	# Calculate the vertical direction based on the distance between the ball and the paddle
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR  # Scale the Y direction

	return new_dir.normalized()  # Normalize the direction to maintain consistent ball speed
