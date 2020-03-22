extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var score: = 100


func _on_body_entered(_body: PhysicsBody2D) -> void:
	picked()

func change_score(s):
	score += 50
	emit_signal("score_changed")


func picked() -> void:
	anim_player.play("fade_out")
