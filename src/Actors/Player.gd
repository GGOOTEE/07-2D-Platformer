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
	#if health <= 0:
		#die()

func change_score(s):
	score += s
	emit_signal("score_changed")
#export var stomp_impulse: = 600.0


#func _on_StompDetector_area_entered(area: Area2D) -> void:
	#_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


#func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	#die()


#func _physics_process(delta: float) -> void:
	#var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	#var direction: = get_direction()
	#_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	#var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
	#_velocity = move_and_slide_with_snap(
		#_velocity, snap, FLOOR_NORMAL, true
	#)


#func get_direction() -> Vector2:
	#return Vector2(
		#Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		#-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	#)

#MOVEMENT
#func calculate_move_velocity(
		#linear_velocity: Vector2,
		#direction: Vector2,
		#speed: Vector2,
		#is_jump_interrupted: bool
	#) -> Vector2:
	#var velocity: = linear_velocity
	#velocity.x = speed.x * direction.x
	#if direction.y != 0.0:
		#velocity.y = speed.y * direction.y
	#if is_jump_interrupted:
		#velocity.y = 0.0
	#return velocity
# Player movement speed

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
		
	velocity.y += gravity * delta
	
	var snap_vector = Vector2(0, 32) if snap else Vector2()
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, slope_slide_threshold, 4, deg2rad(46))
		
	if is_on_floor() and (Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left")):
		velocity.y = 0
	
	var just_landed := is_on_floor() and not snap
	if just_landed:
		snap = true	

	if(direction == 0):
		sprite.play("Idle")
	else:
		sprite.play("Run")

#func calculate_stomp_velocity(linear_velocity: Vector2, stomp_impulse: float) -> Vector2:
	#var stomp_jump: = -speed.y if Input.is_action_pressed("jump") else -stomp_impulse
	#return Vector2(linear_velocity.x, stomp_jump)


#func die() -> void:
	#PlayerData.deaths += 1
	#queue_free()

