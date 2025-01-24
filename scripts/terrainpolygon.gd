extends Polygon2D

var rng = RandomNumberGenerator.new()
var iterations = 40
var linepoints  = []
var r = 0.6
var order = []
var limitstart = 250
var xend = 2000 #1152
var ybegin = 480
#var polygonpoints : PackedVector2Array
# Called when the node enters the scene tree for the first time
#func _init():
	 
	
func _ready() -> void:
	#clear_points()
	game.polygonpoints.append(Vector2(0,700))
	game.polygonpoints.append(Vector2(0,ybegin))
	#add_point(Vector2(0,700)) 
	#add_point(Vector2(0,480))
	order.append([Vector2(0,ybegin),Vector2(xend,ybegin),limitstart])
	for i in range(iterations):
		generate_point(order[0][0],order[0][1],order[0][2],iterations)
	linepoints.sort_custom(custom_array_sort)
	for x in linepoints:
		game.polygonpoints.append(x)
	game.polygonpoints.append(Vector2(xend,ybegin))
	game.polygonpoints.append(Vector2(xend,700))

	#add_point(Vector2(1152,480))
	#add_point(Vector2(1152,700))
	#print(type_string(typeof(linepoints)))
	#print(linepoints)
	game.polygonpoints.reverse()
	self.polygon = game.polygonpoints
	$StaticBody2D/CollisionPolygon2D.polygon = game.polygonpoints
	
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

func destroy(poly):
	var polydelete = poly.get_node("Destroy/destructionarea").polygon
	
	polydelete = Transform2D(0,poly.global_position)*polydelete
	#print(polydelete)
	#print(type_string(typeof(polydelete)))
	#print(type_string(typeof(game.polygonpoints)))
	#print("Polypoints",game.polygonpoints)
	#print("polypoints",Geometry2D.is_polygon_clockwise(game.polygonpoints))
	#print("polydelete",Geometry2D.is_polygon_clockwise(polydelete))
	#draw_polygon_debug(polydelete,Color(0, 1, 1, 1) )
	#draw_polygon_debug(game.polygonpoints,Color(0.862745, 0.0784314, 0.235294, 1))
	var polyn = Polygon2D.new()
	polyn.global_position = Vector2.ZERO
	polyn.polygon = polydelete
	game.polygonpoints= Geometry2D.clip_polygons(game.polygonpoints,polyn.polygon)[0]
	
	#draw_polygon_debug(result,Color(0.741176, 0.717647, 0.419608, 1))
	#print("after collision",game.polygonpoints)
	#gamColor(0.498039, 1, 0.831373, 1)e.polygonpoints = PackedVector2Array([Vector2(0,572),Vector2(0,540),Vector2(1150,540),Vector2(1150,572)])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game.change>0:
		self.polygon = game.polygonpoints
		$StaticBody2D/CollisionPolygon2D.polygon = game.polygonpoints
		game.change -=1
	pass

func draw_polygon_debug(polygon: PackedVector2Array, color: Color):
	var poly_node = Polygon2D.new()
	poly_node.polygon = polygon
	poly_node.color = color
	add_child(poly_node)
