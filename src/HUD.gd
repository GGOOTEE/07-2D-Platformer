extends Node2D

func _ready():
	get_node("/root/SaveSystem").connect("change_health", self, "_on_health_changed")
	get_node("/root/SaveSystem").connect("change_score", self, "_on_score_changed")

func _on_health_changed():
	var h = get_node("/root/SaveSystem").health
	$HEALTH.text = "Health: " + str(h)


func _on_score_changed():
	var s = get_node("/root/SaveSystem").score
	$SCORE.text = "Score: " + str(s)


func _on_Save_button_up():
	get_node("/root/SaveSystem").saveValue()


func _on_Load_button_up():
	get_node("/root/SaveSystem").loadValue()
