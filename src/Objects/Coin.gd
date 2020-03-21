extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var score: = 100


func _on_body_entered(_body: PhysicsBody2D) -> void:
	picked()


func picked() -> void:
	score += 100
	anim_player.play("fade_out")
