class_name AutoScrollCamera
extends CameraControllerBase

@export var top_left: Vector2 = Vector2(0, 0)
@export var bottom_right: Vector2 = Vector2(10, 10)
@export var autoscroll_speed: Vector3 = Vector3(5, 0, 5)

var frame_pos: Vector3
var box_width: float
var box_height: float

func _ready() -> void:
	super()
	box_width = bottom_right.x - top_left.x
	box_height = bottom_right.y - top_left.y
	frame_pos = Vector3(top_left.x, 0, top_left.y)

func _process(delta: float) -> void:
	if !current:
		return
		
	if draw_camera_logic:
		draw_logic()
		
	frame_pos.x += autoscroll_speed.x * delta
	frame_pos.z += autoscroll_speed.z * delta
	
	global_transform.origin = frame_pos
	
	var vessel = get_parent().get_node("Vessel") 
	boundary_checks(vessel)  
	
	super(delta)

func boundary_checks(vessel) -> void:
	var vessel_pos = vessel.global_transform.origin 
	var half_width = vessel.WIDTH / 2.0  
	var half_height = vessel.HEIGHT / 2.0  

	var frame_left_edge = frame_pos.x - box_width / 2.0
	var frame_right_edge = frame_pos.x + box_width / 2.0
	var frame_top_edge = frame_pos.z + box_height / 2.0
	var frame_bottom_edge = frame_pos.z - box_height / 2.0

	# left 
	var diff_left = (vessel_pos.x - half_width) - frame_left_edge
	if diff_left < 0:
		vessel.global_transform.origin.x += -diff_left  

	# 
	var diff_right = (vessel_pos.x + half_width) - frame_right_edge
	if diff_right > 0:
		vessel.global_transform.origin.x -= diff_right  

	# top
	var diff_top = (vessel_pos.z + half_height) - frame_top_edge
	if diff_top > 0:
		vessel.global_transform.origin.z -= diff_top  

	# bottom
	var diff_bottom = (vessel_pos.z - half_height) - frame_bottom_edge
	if diff_bottom < 0:
		vessel.global_transform.origin.z += -diff_bottom  

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	var left = frame_pos.x - box_width / 2.0 - 9  
	var right = frame_pos.x + box_width / 2.0 + 9  
	var top = frame_pos.z + box_height / 2.0 + 9    
	var bottom = frame_pos.z - box_height / 2.0 - 9  

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))

	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))

	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))

	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK 

	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(0, 2, 0) 

	await get_tree().process_frame
	mesh_instance.queue_free()
	
