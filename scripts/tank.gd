extends CharacterBody2D
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func get_input():
	var input_direction = 0
	if Input.is_action_pressed("left"):
		input_direction = -1
		$AnimatedSprite2D.flip_h = false
		$AnimationPlayer.play("motion")
	elif Input.is_action_pressed("right"):
		input_direction = 1
		$AnimatedSprite2D.flip_h = true
		$AnimationPlayer.play("motion")

	else:
		$AnimationPlayer.pause()
	velocity.x = input_direction * speed

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity()*delta
	#if is_on_floor():
		##print("Raycast 1 ",$RayCast2D.get_collision_normal().angle())
		##print("Raycast 2 ",$RayCast2D2.get_collision_normal().angle())
		##rotation = $RayCast2D2.get_collision_normal().angle() - $RayCast2D.get_collision_normal().angle()+PI/2
		#rotation = get_floor_normal().angle() + PI/2
		##rotation = ($RayCast2D.get_collision_normal().angle() +$RayCast2D2.get_collision_normal().angle())/2
		#rotation = ($RayCast2D.get_collision_point()-$RayCast2D2.get_collision_point()).angle()+PI/2
	get_input()
	apply_floor_snap()
	move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
