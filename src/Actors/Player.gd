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

# WHERE THE PLAYER IS LOOKING
	if is_on_floor() and (Input.is_action_just_released("move_left")):
		$Actions.scale.x = -1
		$attack.scale.x = -1
	if is_on_floor() and (Input.is_action_just_released("move_left")):
		$Actions.scale.x = 1
		$attack.scale.x = 1



	if velocity.y > 0 and sprite.animation != "Fall":
		sprite.play("Fall")
	elif velocity.y < 0 and sprite.animation != "jump":
		sprite.play("jump")
	elif velocity.x != 0 and sprite.animation != "Idle":
		sprite.play("Run")
	elif velocity.y == 0 and sprite.animation == "Fall":
		sprite.play("Idle")



	if Input.is_action_just_pressed("attack"):
		sprite.play("Attack")
		var bodies = $attack.get_overlapping_bodies()
		for b in bodies:
			if b.name.substr(0,5) == "Enemy":
				b.die()
	if Input.is_action_just_pressed("Run"):
		sprite.play("Run")


	velocity.y += gravity * delta


func _on_Actions_animation_finished():
	if $Actions.animation == "Attack":
		$Actions.animation = "Idle"
		_velocity.x = -speed.x
	if $Actions.animation == "Run":
		$Actions.animation = "Idle"
	if $Actions.animation == "Damaged":
		$Actions.animation = "Idle"
		_velocity.x = -speed.x


func damaged():
	sprite.play("Damaged")
	
func die():
	print("You have died")
	pass
