extends Node2D

var health = 100
var score = 0
var level

signal change_health
signal change_score
signal die

var save_path = "res://save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)


func _ready():
	pass 

func saveValue():
	config.set_value("Save", "score", score)
	config.set_value("Save", "health", health)
	config.set_value("Save", "level", level)
	config.save(save_path)


func loadValue():
	score = config.get_value("Save", "score")
	health = config.get_value("Save", "health")
	level = config.get_value("Save", "level")
	if level == 1:
		get_tree().change_scene("res://src/levels/Level Template.tscn")
	if level == 2:
		get_tree().change_scene("res://src/levels/Level02.tscn")
	
func update_health(h):
	health += h
	emit_signal("change_health")
	if health <= 0:
		emit_signal("die")

func update_score(s):
	score += s
	emit_signal("change_score")
