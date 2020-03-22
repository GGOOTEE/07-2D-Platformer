extends Node2D

# Buttons
func _ready():
	get_node("/root/SaveSystem").update_health(0)
	get_node("/root/SaveSystem").update_score(0)
	get_node("/root/SaveSystem").level = 1
