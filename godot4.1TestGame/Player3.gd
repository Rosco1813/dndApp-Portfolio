extends CharacterBody2D



signal hit
signal lazer_shot(lazer_scene, location)

@onready var anim_tree = $AnimationTree
@onready var anim_player = $AnimationPlayer
@onready var anim_state = anim_tree.get('parameters/playback')
@onready var muzzle = $Gun

var lazer_scene = preload("res://lightning_bolt.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ROLL_SPEED = 200
const MAX_SPEED = 100
const ACCELERATION = 500
const FRICTION = 500
var roll = false
var screen_size # Size of the game window.
var lazer_speed = 2000

var ammo = 1
#var shooting = false

var input_movement = Vector2.ZERO

enum {
	MOVE,
	ROLL,
	SHOOT,
}

var state = MOVE
var roll_vector = Vector2.LEFT



# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	screen_size = get_viewport_rect().size
	anim_tree.active = true
	pass

func _physics_process(delta):
#	hide()
	var velocity = Vector2.ZERO

	match state:
		MOVE:
			move(delta)
		ROLL:
			rolling(delta)
		SHOOT:
			shooting(delta)
#			pass
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

#	move_and_slide()
	
func move(delta):
	input_movement = Input.get_vector('move_left', 'move_right', 'move_up','move_down' )
	anim_tree.set('parameters/aim/blend_position', input_movement)
	anim_tree.set('parameters/shoot/blend_position', input_movement)
	input_movement = input_movement.normalized()
	
	if input_movement != Vector2.ZERO:
		roll_vector = input_movement
		anim_tree.set('parameters/roll/blend_position', input_movement)
		anim_tree.set('parameters/idle/blend_position', input_movement)
		anim_tree.set('parameters/walk/blend_position', input_movement)
		anim_state.travel('walk')
		velocity = velocity.move_toward(input_movement * MAX_SPEED, ACCELERATION * delta)
		velocity = input_movement * SPEED
		
		if Input.is_action_pressed("roll"):
			roll = true
			state = ROLL
			
		else:
			state = MOVE
			
	elif !roll:
		anim_state.travel('walk')
		

	if Input.is_action_pressed("aim"):
		velocity = Vector2.ZERO
		anim_state.travel('aim')
		
		if Input.is_action_pressed("light_attack"):
			state = SHOOT
			shoot()
			
	if input_movement == Vector2.ZERO:
		anim_state.travel('idle')
		velocity = Vector2.ZERO
		roll = false

	move_and_slide()
	

func rolling(delta):
	velocity = roll_vector * ROLL_SPEED * 2
	anim_state.travel('roll')
	moving()
	
func shooting(delta):
	var Lazer = lazer_scene.instantiate()
	get_parent().add_child(Lazer)
	
	print('instantiate lazer ======== ', Lazer)
	Lazer.set_lazer_direction(input_movement, true)
	anim_state.travel('shoot')
	moving()
	pass
	
func moving():
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity


func _on_animation_tree_animation_finished(anim_name):
#	print('ANIMATION FINISHED +++ ', anim_name)
	state = MOVE
	pass # Replace with function body.


func shoot():
	print('SHOOT')
	ammo = 0
#	shoot_cool_down = false
	
	lazer_shot.emit(lazer_scene)
