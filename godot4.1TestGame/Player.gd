
# Called every frame. 'delta' is the elapsed time since the previous frame.
extends Area2D
#https://develop.games/
signal hit
signal lazer_shot(lazer_scene, location)

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var testAnimation = true
@export var right = false
@export var rate_of_fire = 0.25
@onready var muzzle = $Muzzle

var screen_size # Size of the game window.
var lazer_scene = preload("res://lightning_bolt.tscn")
var shoot_cool_down := false


func _ready():
	screen_size = get_viewport_rect().size
	#this hides the character !!
	hide()


func _process(delta):

	var velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed(&"move_right"):
		right = true
		velocity.x += 1
		
	if Input.is_action_pressed(&"move_left"):
		right = false
		velocity.x -= 1
	
	if Input.is_action_pressed(&"move_down"):
		velocity.y += 1
	if Input.is_action_pressed(&"move_up"):
		velocity.y -= 1
	if Input.is_action_pressed('light_attack'):
		if !shoot_cool_down:
			shoot_cool_down = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cool_down = false
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		#get_node("AnimatedSprite2D").play()- note - $ replaces get_node()
		
	else:
		$AnimatedSprite2D.stop()
	#DELTA - amount of time that a previous frame took to complete 
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if !testAnimation:
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = velocity.x < 0
	
		elif velocity.y != 0:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.flip_v = velocity.y > 0
		
	#if velocity.x != 0
	if testAnimation:
		speed = 175
		var characterTest = ['goodRat', 'swim', 'rat2BigMamu']
		var i = 2;
		
		if velocity.x < 0:
			$AnimatedSprite2D.animation = characterTest[i]
			#$AnimatedSprite2D.flip_h = false
			if characterTest[i] != 'swim':
				$AnimatedSprite2D.flip_h = velocity.x > 0
				muzzle.position = Vector2(-50, 0)
				
				
			else:
				$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.x > 0:
			$AnimatedSprite2D.animation = characterTest[i]
			if characterTest[i] != 'swim':
				$AnimatedSprite2D.flip_h = velocity.x > 0
				muzzle.position = Vector2(80, 0)
			else:
				$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = characterTest[i]
			$AnimatedSprite2D.flip_v = velocity.y > 0
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = characterTest[i]
			$AnimatedSprite2D.flip_v = velocity.y < 0
		

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
	
func shoot():
	print('lazer ', lazer_scene)
	lazer_shot.emit(lazer_scene, muzzle.global_position)
	
	
