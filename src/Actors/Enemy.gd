extends "res://src/Actors/Actor.gd"



export var score: = 100


func _ready() -> void:
	_velocity.x = -speed.x


func _physics_process(delta: float) -> void:
	_velocity.x *= -1 if is_on_wall() else 1
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y





func die() -> void:
	#PlayerData.score += score
	queue_free()


func _on_attack_body_entered(body):
	if body.name == "Player":
		get_node("/root/SaveSystem").health -= 50
		get_node("/root/SaveSystem").score -= 25
		$Actions.animation == "Attack"

func _on_Actions_animation_finished():
	if $Actions.animation == "Attack":
		$Actions.animation = "Idle"
