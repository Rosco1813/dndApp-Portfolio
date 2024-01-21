extends CharacterBody2D

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get('parameters/playback')

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var input_movement = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	$sword/CollisionShape2D.disabled = true

func _physics_process(delta):
	hide()
	move()
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
	
func move():
	input_movement = Input.get_vector('move_left', 'move_right', 'move_up','move_down' )
	
	if input_movement != Vector2.ZERO:
		anim_tree.set('parameters/idle/blend_position', input_movement)
		anim_tree.set('parameters/walk/blend_position', input_movement)
		anim_tree.set('parameters/sword/blend_position', input_movement)
		anim_tree.set('parameters/jump/blend_position',input_movement)
		anim_state.travel('walk')
		velocity = input_movement * SPEED
		
	if input_movement == Vector2.ZERO:
		anim_state.travel('idle')
		velocity = Vector2.ZERO
		
	move_and_slide()
