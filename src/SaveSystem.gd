extends Node2D

var health = 100
var score = 0

signal change_health
signal change_score

var save_path = "res://save-file.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)


func _ready():
	pass 

func saveValue(section, key):
	config.set_value(section, key, health, score)
	config.save(save_path)

func loadValue(section, key):
	health = config.get_value(section, key, health)
	score = config.get_value(section, key, score)

func update_health(h):
	health += h
	emit_signal("change_health")

func update_score(s):
	score += s
	emit_signal("change_score")
