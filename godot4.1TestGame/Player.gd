
# Called every frame. 'delta' is the elapsed time since the previous frame.
#get_node("AnimatedSprite2D").play()- note - $ replaces get_node()
extends Area2D
#https://develop.games/
signal hit
signal lazer_shot(lazer_scene, location)
@onready var sprite = $AnimatedSprite2D
@export var speed = 400 # How fast the player will move (pixels/sec).
@export var testAnimation = false
var right = false
var left = false
var back = false
var forward = false

#@export var rate_of_fire = 0.75
#var animation_time_out = 2
@onready var muzzle = $Muzzle

var screen_size # Size of the game window.
var lazer_scene = preload("res://lightning_bolt.tscn")
var lazer_speed = 2000
#var shoot_cool_down := false
var ammo = 1
var shooting = false

var anim_name = 'test'

var animation = 1
var characterMovement = [
#0
'forward',
#1
'idle',
#2
'forward_aim',
#2 -> 3
'forward_shoot', 
#3 ->4
'forward_roll',
#4  -> 5
'back',
# 6
'back_aim',
#5 -> 7
'back_shoot',
#6 -> 8
'back_roll',
#7 -> 9
'left',
#10
'left_aim',
#8 -> 11
'left_shoot', 
#9 -> 12
'left_roll',
#10 -> 13
'right', 
#14
'right_aim',
#11 -> 15
'right_shoot', 
#12 ->16
'right_roll'
]
func _ready():
	screen_size = get_viewport_rect().size
	sprite.connect("animation_finished", _on_animated_sprite_2d_animation_finished)
	#this hides the character !!
	hide()


func _process(delta):
	hide()
	var Lazer = lazer_scene.instantiate()
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed(&"move_right"):
		right = true
		left = false
		back = false
		forward = false
		velocity.x += 1

		
	if Input.is_action_pressed(&"move_left"):
		right = false
		left = true
		back = false
		forward = false
		velocity.x -= 1
	
	if Input.is_action_pressed(&"move_down"):
		right = false
		left = false
		back = false
		forward = true
		velocity.y += 1
		
	if Input.is_action_pressed(&"move_up"):
		right = false
		left = false
		back = true
		forward = false
		velocity.y -= 1
	
	if Input.is_action_just_released("aim"):
		ammo = 1
		#print('amo gained = ', ammo)

	if Input.is_action_pressed('aim'):
		if ammo == 1:
			if forward:
				animation = 2
				if Input.is_action_pressed("light_attack"):
					animation = 3
					shooting = true
#					shoot()

			elif back:
				animation = 6
				if Input.is_action_pressed("light_attack"):
					animation = 7
					shooting = true
#					shoot()

			elif left:
				animation = 10
				var current_frame = sprite.get_frame()
				var current_progress = sprite.get_frame_progress()
				#sprite.play("walk_another_skin")
				if sprite.animation_finished:
					
					#sprite.set_frame_and_progress(current_frame, current_progress)
					sprite.set_frame_and_progress(current_frame, 11)
					sprite.stop()
#					print('frame and progress === ', current_frame, current_progress)
				if Input.is_action_pressed("light_attack"):
					animation = 11
					shooting = true
#					shoot()

			elif right:
				animation = 14
			
#				var current_frame = sprite.get_frame()
#				var current_progress = sprite.get_frame_progress()
#				sprite.play("walk_another_skin")
				sprite.stop()
#				if sprite.animation_finished:
					
					#sprite.set_frame_and_progress(current_frame, current_progress)
#					sprite.set_frame_and_progress(current_frame, 11)
#					print('frame and progress === ', current_frame, current_progress)
				if Input.is_action_pressed("light_attack"):
#				if Input.is_action_just_released("light_attack"):
					animation = 15
					shooting = true
					shoot()
				


	if velocity.length() > 0.0:
		velocity = velocity.normalized() * speed

	else:
		if Input.is_action_pressed("aim"):
	
			
			pass
		else:
			#animation = 1
			#print('else animation ', animation)
			sprite.stop()
			pass
				
	#DELTA - amount of time that a previous frame took to complete 
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if !testAnimation:
		speed = 175
	
		if velocity.x < 0:
			#left
			muzzle.position = Vector2(-180, -118.462)
			if Input.is_action_pressed(&"roll"):
				speed = 350
				animation = 12
			else: 
				animation = 9			
			
		elif velocity.x > 0:
			#right
			muzzle.position = Vector2(240, -120)
			if Input.is_action_pressed(&"roll"):
				speed = 350
				animation = 16
			else:
				animation = 13
				
		elif velocity.y < 0:
			#back
			muzzle.position = Vector2(16.923, -215.385)
			if Input.is_action_pressed(&"roll"):
				speed = 350
				animation = 8
				
			else:
				animation = 5
		
		elif velocity.y > 0:
			#forward
			muzzle.position = Vector2(27.825, -8.875)
			if Input.is_action_pressed(&"roll"):
				speed = 350
				animation = 4
			else:	
				animation = 0
		#print('== SPRITE == ', characterMovement[animation])
		sprite.play(characterMovement[animation])
		
	
	

#green icon indicates signal is connected to this fn 
func _on_body_entered(body):
	if "lazer" in body.name:
		pass
	elif animation == 3:
		pass
	elif animation == 6:
		pass
	elif animation == 9:
		pass
	elif animation == 12:
		pass
	else:
		hide() # Player disappears after being hit.
		hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func shoot():
	ammo = 0
#	shoot_cool_down = false
	
	lazer_shot.emit(lazer_scene, muzzle.global_position, right, back, left, forward)
		
		



func _on_animated_sprite_2d_animation_finished(anim_name):
	print('Animation finished = = ', anim_name)
	if anim_name == "light_attack":
		shoot()
		shooting = false
	
