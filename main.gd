extends Node

@export var mob_scene: PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$Score_timer.stop()
	$mob_timer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	get_tree().call_group("mobs", "queue_free")
	$"Player node".start($start_pos.position)
	$start_timer.start()
	


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_loc = $mobpath/spawnlocation
	mob_spawn_loc.progress_ratio = randf()
	var direction = mob_spawn_loc.rotation + PI / 2
	mob.position = mob_spawn_loc.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$mob_timer.start()
	$Score_timer.start()
