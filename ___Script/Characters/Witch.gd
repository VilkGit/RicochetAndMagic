extends Node2D


var nodeLookRight
var nodeLookLeft
var nodeHandLeft
var nodeHandRight
var stickPointSpawn
var BoxPoint
var prefShell:Resource
var BoxShell
var cancellationFire = false

var lineAim


func _ready():
	nodeLookLeft = get_node("LookLeft")
	nodeLookRight = get_node("LookRight")
	nodeHandLeft = get_node("LookLeft/Hand")
	nodeHandRight = get_node("LookRight/Hand")
	stickPointSpawn = get_node("BoxPoint/Point")
	BoxPoint = get_node("BoxPoint")
	BoxShell = get_node("BoxPoint/Point/BoxShell")
	lineAim = get_node("LineAim")


func EventControlCharacter(event):

	if (event is InputEventScreenDrag and event.get_index() == 0 and
		 not cancellationFire): 
		HandSeeOnMouse(event.position)
		CharacterSeeOnMouse(event.position)
		linePointsPosition(event.position)
	
	if (event is InputEventScreenTouch and event.get_index() == 0 and
		 not cancellationFire):
		if event.pressed: 
			lineAim.show()
			linePointsPosition(event.position)
			
		else:
			lineAim.hide()
			if prefShell == null: return
			var obj = prefShell.instance()
			obj.directionVelocity = (event.position - 
				stickPointSpawn.global_position)
			BoxShell.add_child(obj)
			$Audio/Shot.play()
			ShowShotWitch()
			S.emit_signal("characterShot")
	
	if (event is InputEventScreenTouch and event.index == 1):
		if event.pressed:
			cancellationFire = true
			lineAim.hide()
	elif (cancellationFire and event is InputEventScreenTouch):
		if !event.pressed:
			cancellationFire = false

func ShowShotWitch():
	var par = get_node("BoxPoint/Point/Shot")
	par.emitting = true
	par.restart()

func linePointsPosition(points):
	lineAim.position = stickPointSpawn.global_position - position

	if DropRay(points) == Vector2.ZERO:
		lineAim.points[1] = (points - lineAim.global_position) * 20
	else:
		lineAim.points[1] = (DropRay(points) - lineAim.global_position)


func DropRay(eventMouse):
	var rayLine = lineAim.get_node("RayLine")

	rayLine.set_cast_to((eventMouse  -
		 rayLine.global_position ) * 6)
	rayLine.force_raycast_update()
	if  rayLine.get_collider() != null:
		return rayLine.get_collision_point()
	else:
		return Vector2.ZERO

func AngleBetweenWitchAndVector(vec:Vector2):
	vec = vec - global_position
	return vec.angle_to(Vector2(1,0))

func VectorOnAngle(v:Vector2, angle:float):
	var direction = Vector2.ZERO

	var sinAngle
	var cosAngle
	
	if not (angle < 0):
		sinAngle = sin(deg2rad(angle))
		cosAngle = cos(deg2rad(angle))
	
	else:
		sinAngle = sin(deg2rad(360 - angle))
		cosAngle = cos(deg2rad(360 - angle))
	
	direction.x = v.x * cosAngle - v.y * sinAngle
	direction.y = v.x * sinAngle + v.y * cosAngle
	return direction

	
func HandSeeOnMouse(posMouse:Vector2):
	nodeHandRight.look_at(posMouse) 
	nodeHandRight.rotation_degrees -= 80
	
	nodeHandLeft.look_at(posMouse) 
	nodeHandLeft.rotation_degrees -= 120
	
	BoxPoint.look_at(posMouse)
	if(nodeLookRight.visible):
		BoxPoint.rotation_degrees -= 90

func CharacterSeeOnMouse(posMouse:Vector2):
	if ((posMouse - global_position).x < 0):
		nodeLookLeft.show()
		nodeLookRight.hide()
	else:
		nodeLookLeft.hide()
		nodeLookRight.show()