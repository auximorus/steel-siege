extends RigidBody2D
var speed = 200
var count = 0
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass

func get_input():
	var input_direction = 0
	if game.aim:
		$"../barell".look_at(get_global_mouse_position())
		game.angleshoot = (Vector2(cos($"../barell".rotation),sin($"../barell".rotation)))
		
	if Input.is_action_pressed("left"):
		input_direction = -1
		$".".freeze = false
		$fronttyre.freeze = false
		$backtyre.freeze = false
		$centretyre.freeze = false
		$centretyre2.freeze = false
		$AnimationPlayer.play("motion")
		$AnimatedSprite2D.flip_h = false
		count+=1
		
	elif Input.is_action_pressed("right"):
		$".".freeze = false
		$fronttyre.freeze = false
		$backtyre.freeze = false
		$centretyre.freeze = false
		$centretyre2.freeze = false
		input_direction = 1
		$AnimationPlayer.play("motion")
		$AnimatedSprite2D.flip_h = true
		count+=1
		

	else:
		$AnimationPlayer.pause()
		if $RayCast2D.is_colliding()==true:
			
			if $".".freeze == false:
				await get_tree().create_timer(0.1).timeout
				$".".freeze = true
				$fronttyre.freeze = true
				$backtyre.freeze = true
				$centretyre.freeze = true
				$centretyre2.freeze = true
			else:
				$".".freeze = true
				$fronttyre.freeze = true
				$backtyre.freeze = true
				$centretyre.freeze = true
				$centretyre2.freeze = true
				
		else:
			$".".freeze = false
			$fronttyre.freeze = false
			$backtyre.freeze = false
			$centretyre.freeze = false
			$centretyre2.freeze = false
	#if input.action
	$fronttyre.angular_velocity = input_direction* 500
	$backtyre.angular_velocity = input_direction* 500
	$centretyre.angular_velocity = input_direction* 500
	$centretyre2.angular_velocity = input_direction* 500

	#$".".apply_central_force(Vector2(input_direction*2500000,0))
	#linear_velocity.x = input_direction * speed

func _physics_process(delta):
	$RayCast2D.add_exception($fronttyre)
	$RayCast2D.add_exception($backtyre)
	$RayCast2D.add_exception($centretyre)
	$RayCast2D.add_exception($centretyre2)

	get_input()
	$"../Camera2D".position = $".".position
	#move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
