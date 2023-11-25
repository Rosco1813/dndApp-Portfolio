extends RigidBody2D

@export var enemyAttackSpeed = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	#global_position.x += enemyAttackSpeed * delta
	global_position.x -= enemyAttackSpeed * delta

#add the visible on screen notifier node, put at end of projective then connect this node signal to delete 
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
