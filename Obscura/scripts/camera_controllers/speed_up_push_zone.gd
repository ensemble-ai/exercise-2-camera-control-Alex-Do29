class_name SpeedUpPushZone
extends CameraControllerBase

@export var push_ratio: float = 0.5
@export var pushbox_top_left: Vector2 = Vector2(-8, -6)  
@export var pushbox_bottom_right: Vector2 = Vector2(8, 6)  
@export var speedup_zone_top_left: Vector2 = Vector2(-5, -4)  
@export var speedup_zone_bottom_right: Vector2 = Vector2(5, 4)  

var target_pos: Vector2

func _ready() -> void:
	super()
	target_pos = Vector2(global_position.x, global_position.y)
	
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()

	var vessel_pos = Vector2(target.global_position.x, target.global_position.z)
	var cam_pos = Vector2(global_position.x, global_position.z)
	var pushbox_zone = Rect2(pushbox_top_left + cam_pos, pushbox_bottom_right - pushbox_top_left)
	var speedup_zone = Rect2(speedup_zone_top_left + cam_pos, speedup_zone_bottom_right - speedup_zone_top_left)

	if speedup_zone.has_point(vessel_pos):
		#print("Vessel in speedup zone")
		target_pos = cam_pos
		
	elif pushbox_zone.has_point(vessel_pos):
		#print("Vessel in outer pushbox")
		
		# moving left
		if vessel_pos.x < cam_pos.x: 
			target_pos.x = lerp(cam_pos.x, vessel_pos.x, push_ratio)
			
		# moving right
		elif vessel_pos.x > cam_pos.x: 
			target_pos.x = lerp(cam_pos.x, vessel_pos.x, push_ratio)
			
		# moving up
		if vessel_pos.y < cam_pos.y: 
			target_pos.y = lerp(cam_pos.y, vessel_pos.y, push_ratio) - 7
		# moving down
		elif vessel_pos.y > cam_pos.y:
			target_pos.y = lerp(cam_pos.y, vessel_pos.y, push_ratio) + 7
	else:
		#print("Vessel pushing on border")
		target_pos = vessel_pos

	global_position.x = lerp(global_position.x, target_pos.x, delta * 5)
	global_position.z = lerp(global_position.z, target_pos.y, delta * 5)

	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)

	# outer pushbox
	var left: float = pushbox_top_left.x - 1.6
	var right: float = pushbox_bottom_right.x + 1.6
	var top: float = pushbox_top_left.y 
	var bottom: float = pushbox_bottom_right.y 

	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))

	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))

	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))

	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))

	# inner speedup zone
	left = speedup_zone_top_left.x 
	right = speedup_zone_bottom_right.x 
	top = speedup_zone_top_left.y
	bottom = speedup_zone_bottom_right.y

	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))

	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))

	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))

	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))

	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK

	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
