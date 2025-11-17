extends Node

@export var projectile_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_hit() -> void:
	pass # Replace with function body.

func game_over():
	$ScoreTimer.stop()
	$ProjectileTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_projectile_timer_timeout() -> void:
	# Luo uuden ammuksen skeneen
	var projectile = projectile_scene.instantiate()

	# Valitsee satunnaisen sijainnin ammukselle
	var projectile_spawn_location = $ProjectilePath/ProjectileSpawnLocation
	projectile_spawn_location.progress_ratio = randf()
	projectile.position = projectile_spawn_location.position

	# Asettaa ammuksen suunnan pelikentän keskustaa kohti pienellä satunnaisuudella
	var direction = projectile_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	projectile.rotation = direction

	# Asettaa ammuksen nopeuden
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	projectile.linear_velocity = velocity.rotated(direction)

	# Luo ammuksen näkymään
	add_child(projectile)


func _on_score_timer_timeout() -> void:
	score += 1


func _on_start_timer_timeout() -> void:
	$ProjectileTimer.start()
	$ScoreTimer.start()
	
	
