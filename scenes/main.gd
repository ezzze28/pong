extends Sprite2D

var score := [0, 0]  # 0: Player's score, 1: CPU's score
const PADDLE_SPEED : int = 500  # Speed at which the paddle moves (though unused here)

# Called when the ball's timer timeout occurs (ball is out of bounds)
func _on_ball_timer_timeout():
	# Reset the ball's position and direction by calling the new_ball function
	$Ball.new_ball()

# Called when the ball enters the left scoring area (Player's side)
func _on_score_left_body_entered(body):
	# Increment the CPU's score (since Player missed the ball)
	score[1] += 1
	# Update the CPU's score on the HUD
	$Hud/CPUScore.text = str(score[1])
	# Start the ball timer to reset the ball position after a short delay
	$BallTimer.start()

# Called when the ball enters the right scoring area (CPU's side)
func _on_score_right_body_entered(body):
	# Increment the Player's score (since CPU missed the ball)
	score[0] += 1
	# Update the Player's score on the HUD
	$Hud/PlayerScore.text = str(score[0])
	# Start the ball timer to reset the ball position after a short delay
	$BallTimer.start()
