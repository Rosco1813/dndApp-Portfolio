extends Node

@export var mob_scene: PackedScene

@onready var lazer_container = $LazerContainer

var score
var showCreeps = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#function hit fired in player script emits and fires game over fn
func game_over():
	
	$Music.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	#$DeathSound.play()

func new_game():
	score = 0
	#$Music.play()
	get_tree().call_group("mobs", "queue_free")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$Player.lazer_shot.connect(_on_player_lazer_shot)
	$StartTimer.start()
	
func _on_player_lazer_shot(lazer_scene, location, right, back, left, forward):
	var lazer = lazer_scene.instantiate()
	var x = true
	if right:
		lazer.set_lazer_direction(1, x)
	elif  left :
		lazer.set_lazer_direction(-1,x)
	elif back:
		x = false
		lazer.set_lazer_direction(-1, x)
	elif forward:
		x = false
		lazer.set_lazer_direction(1, x)
	
		
	lazer.global_position = location
	lazer_container.add_child(lazer)
														
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	if showCreeps:
	# Create a new instance of the Mob scene.
		var mob = mob_scene.instantiate()
	# Choose a random location on Path2D.
		var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
		mob_spawn_location.progress_ratio = randf()
	# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2
	# Set the mob's position to a random location.
		mob.position = mob_spawn_location.position
	# Add some randomness to the direction.
		direction += randf_range(-PI / 4, PI / 4)
		mob.rotation = direction
	# Choose the velocity for the mob.
		var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
		mob.linear_velocity = velocity.rotated(direction)
	# Spawn the mob by adding it to the Main scene.
		add_child(mob)
