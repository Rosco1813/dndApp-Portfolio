extends RigidBody2D

signal hit

@export var enemyAttackSpeed = 2200

var direction = 1
var velocity = Vector2()
var xAxis = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_lazer_direction(dir, x):

	xAxis = x
	direction = dir
	if !xAxis:
		$Sprite2D.rotation_degrees = 90

	
func _physics_process(delta):

	if xAxis:
		if direction == -1:
			global_position.x += enemyAttackSpeed * delta * direction
#			velocity.x = enemyAttackSpeed * delta * direction
			
			
		else:
			global_position.x += enemyAttackSpeed  * delta * direction
			
#			velocity.x = enemyAttackSpeed * delta * direction
	else:
		
		global_position.y += enemyAttackSpeed * delta * direction 

	#global_position.x += enemyAttackSpeed * delta * direction

		
	

#add the visible on screen notifier node, put at end of projective then connect this node signal to delete 
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	



	


func _on_hit_box_body_entered(body):
	if "lightningBolt"  in body.name:
		
		pass
	if "lazer" in body.name:
		
		pass
	else:
		queue_free()
