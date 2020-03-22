extends Actor

func _ready():
	get_node("/root/SaveSystem").connect("die", self, "die")



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
	
	
	
	
	if Input.is_action_just_pressed("attack"):
		sprite.play("Attack")
		
func _on_Actions_animation_finished():
	if $Actions.animation == "Attack":
		$Actions.animation = "Idle"
		_velocity.x = -speed.x
		var bodies = $attack.get_overlapping_bodies()
		for b in bodies:
			if b.name == "Player":
				get_node("/root/SaveSystem").update_health(-50)
				get_node("/root/SaveSystem").update_score(-25)
	if Input.is_action_just_pressed("Run"):
		sprite.play("Run")


func die():
	print("You have died")
	pass

#func die() -> void:
	#PlayerData.deaths += 1
	#queue_free()


	
