extends RigidBody2D
var speed = 400
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func get_input():
	var input_direction = 0
	if game.aim:
		$"../barell".look_at(get_global_mouse_position())
		game.angleshoot = (Vector2(cos($"../barell".rotation),sin($"../barell".rotation)))
		
	if Input.is_action_pressed("left"):
		input_direction = -1
		$".".freeze = false
		$AnimationPlayer.play("motion")
		$AnimatedSprite2D.flip_h = false
		print("left",count)
		count+=1
		
	elif Input.is_action_pressed("right"):
		$".".freeze = false
		input_direction = 1
		$AnimationPlayer.play("motion")
		$AnimatedSprite2D.flip_h = true
		print("right",count)
		count+=1
		

	else:
		$AnimationPlayer.pause()
		if $RayCast2D.is_colliding()==true:
			if $".".freeze == false:
				await get_tree().create_timer(0.05).timeout
				$".".freeze = true
			else:
				$".".freeze = true
				
		else:
			$".".freeze = false
	#if input.action
	$fronttyre.angular_velocity = input_direction* 500
	$backtyre.angular_velocity = input_direction* 500
	$centretyre.angular_velocity = input_direction* 500
	$centretyre2.angular_velocity = input_direction* 500

	#$".".apply_central_force(Vector2(input_direction*2500000,0))
	#linear_velocity.x = input_direction * speed

func _physics_process(delta):
	get_input()
	$"../Camera2D".position = $".".position
	#move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
