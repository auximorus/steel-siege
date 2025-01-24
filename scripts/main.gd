extends Node2D
var proj = load("res://projectile.tscn")
var asteroid = load("res://projectiles/asteroid.tscn")
var direction :Vector2
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	#if aim:
		#var tank_object = $tanker
		#var barell = tank_object.get_node("barell")
		#barell.look_at(get_global_mouse_position())



func _on_lock_aim_toggled(toggled_on: bool) -> void:
	game.aim = toggled_on


func _on_shoot_pressed() -> void:
	#var bullet = proj.new()
	var pos = $tanker.get_node("barell").get_node("Marker2D").global_position
	print(pos)
	var bullet = asteroid.instantiate()
	bullet.initialize(pos,game.angleshoot,game.power)
	add_child(bullet)
