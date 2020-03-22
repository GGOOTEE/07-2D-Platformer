extends "res://src/Actors/Actor.gd"

export var score: = 100

func _ready() -> void:
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	if is_on_wall():
		_velocity.x *= -1
		if _velocity.x > 0:
			$Actions.scale.x = -1
			$attack.scale.x = -1
		else:
			$Actions.scale.x = 1
			$attack.scale.x = 1
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	get_node("/root/SaveSystem").update_score(100)
	$Actions.animation = "Death"
	_velocity.x = 0


func _on_attack_body_entered(body):
	if body.name == "Player" and $Actions.animation != "Death":
		$Actions.animation = "Attack"
		_velocity.x = 0

func _on_Actions_animation_finished():
	if $Actions.animation == "Attack":
		$Actions.animation = "Idle"
		_velocity.x = -speed.x
		var bodies = $attack.get_overlapping_bodies()
		for b in bodies:
			if b.name == "Player":
				get_node("/root/SaveSystem").update_health(-50)
				get_node("/root/SaveSystem").update_score(-25)
				b.damaged()
	if $Actions.animation == "Death":
		_velocity.x = 0
		queue_free()
