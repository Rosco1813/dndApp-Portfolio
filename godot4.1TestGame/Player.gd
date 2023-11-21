
# Called every frame. 'delta' is the elapsed time since the previous frame.
extends Area2D
#https://develop.games/
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
@export var diver = false

func _ready():
	screen_size = get_viewport_rect().size
	#this hides the character !!
	hide()


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"move_right"):
		velocity.x += 1
	
	if Input.is_action_pressed(&"move_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed(&"move_down"):
		velocity.y += 1
		
	if Input.is_action_pressed(&"move_up"):
		velocity.y -= 1
		

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		#get_node("AnimatedSprite2D").play()- note - $ replaces get_node()
		
	else:
		$AnimatedSprite2D.stop()
	#DELTA - amount of time that a previous frame took to complete 
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if !diver:
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
	
		elif velocity.y != 0:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.flip_v = velocity.y > 0
		
	#if velocity.x != 0
	if diver:
		speed = 175
		if velocity.x < 0:
			$AnimatedSprite2D.animation = "swim"
			#$AnimatedSprite2D.flip_h = false
			
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.x > 0:
			$AnimatedSprite2D.animation = "swim"
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "swim"
			$AnimatedSprite2D.flip_v = velocity.y > 0
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "swim"
			$AnimatedSprite2D.flip_v = velocity.y < 0
		
		#$AnimatedSprite2D.animation = "swim"
		#$AnimatedSprite2D.look_at(Vector2(300, 100))
		#$AnimatedSprite2D.flip_v = false
	# See the note below about boolean assignment.
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "swim"
		#$AnimatedSprite2D.flip_v = velocity.y < 0

	

		


#green icon indicates signal is connected to this fn 
func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
