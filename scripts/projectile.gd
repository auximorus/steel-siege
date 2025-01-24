extends RigidBody2D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	##$Area2D.
	#pass # Replace with function body.

func initialize(pos:Vector2,shootingangle:Vector2,pow:int) -> void:
	self.position = pos
	self.linear_velocity = pow*shootingangle
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.global_position.y >568:
		self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(type_string(typeof(body)))
	game.change +=1
	get_node("../terrain/Polygon2D").destroy(self)
	self.queue_free() # Replace with function body.
