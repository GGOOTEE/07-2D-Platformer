extends Actor

export var health = 100
export var score = 0

signal health_changed
signal score_changed

func _ready():
	emit_signal("health_changed")
	emit_signal("score_changed")

func change_health(h):
	health += h
	emit_signal("health_changed")
	if health <= 0:
		sprite.play("Death")

func change_score(s):
	score += s
	emit_signal("score_changed")



export var snap := false
export var move_speed := 250
export var jump_force := 500
export var slope_slide_threshold := 50.0

var direction = 0
var velocity := Vector2()
onready var player = get_node(".")
onready var sprite = get_node("Actions")

func _physics_process(delta):
	var direction_x := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction_x * move_speed
	
	if Input.is_action_just_pressed("jump") and snap:
		velocity.y = -jump_force
		snap = false
		
	var snap_vector = Vector2(0, 32) if snap else Vector2()
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, slope_slide_threshold, 4, deg2rad(46))
		
	if is_on_floor() and (Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left")):
		velocity.y = 0
	
	var just_landed := is_on_floor() and not snap
	if just_landed:
		snap = true	

	#if(direction == 0):
		#sprite.play("Idle")
		#sprite.play("Run")
		
		
		
		
		
		
	velocity.y += gravity * delta
	
	
	
	
	if Input.is_action_just_pressed("Attack"):
		sprite.play("Attack")
	
	if Input.is_action_just_pressed("Run"):
		sprite.play("Run")

func _on_Actions_animation_finished():
	if $Actions.animation == "Attack":
		$Actions.animation = "Idle"
	if $Actions.animation == "Run":
		$Actions.animation = "Idle"



#func die() -> void:
	#PlayerData.deaths += 1
	#queue_free()


	
