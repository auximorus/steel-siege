extends Polygon2D

var rng = RandomNumberGenerator.new()
var iterations = 50
var linepoints  = []
var r = 0.4
var order = []
var limitstart = 150
var xend = 3000 #1152
var ybegin = 480
var polygonpoints : PackedVector2Array
# Called when the node enters the scene tree for the first time
#func _init():
	 
	
func _ready() -> void:
	#clear_points()
	polygonpoints.append(Vector2(0,700))
	polygonpoints.append(Vector2(0,ybegin))
	#add_point(Vector2(0,700)) 
	#add_point(Vector2(0,480))
	order.append([Vector2(0,ybegin),Vector2(xend,ybegin),limitstart])
	for i in range(iterations):
		generate_point(order[0][0],order[0][1],order[0][2],iterations)
	linepoints.sort_custom(custom_array_sort)
	for x in linepoints:
		polygonpoints.append(x)
	polygonpoints.append(Vector2(xend,ybegin))
	polygonpoints.append(Vector2(xend,700))

	#add_point(Vector2(1152,480))
	#add_point(Vector2(1152,700))
	#print(type_string(typeof(linepoints)))
	#print(linepoints)
	self.polygon = polygonpoints
	$StaticBody2D/CollisionPolygon2D.polygon = polygonpoints
	#$RigidBody2D/CollisionPolygon2D.polygon = polygonpoints
func custom_array_sort(a: Vector2, b: Vector2) -> int:
	#print(a,b)
	if a.x > b.x:
		return false
	else:
		return true
		
func generate_point(a:Vector2,b:Vector2,limit:float,num:int):
	var heightlimitmax = ((a.y+b.y)/2)+limit
	if heightlimitmax > 576:
		heightlimitmax = 576
		
	var heightlimitlow = ((a.y+b.y)/2)-limit
	if heightlimitlow <386:
		heightlimitlow = 386
	var newpt = Vector2((a.x+b.x)/2,rng.randi_range(heightlimitlow,heightlimitmax))
	
	linepoints.append(newpt)
	order.pop_front()
	limit /= pow(2,r)
	if num%2==1:
		order.append([a,newpt,limit])
		order.append([newpt,b,limit])
	else:
		order.append([newpt,b,limit])
		order.append([a,newpt,limit])


	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
