extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initialize(pos:Vector2,shootingangle:Vector2,pow:int) -> void:
	self.position = pos
	self.linear_velocity = pow*shootingangle
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
