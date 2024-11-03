class_name LerpCamera
extends CameraControllerBase

@export var follow_speed: float = 5.0  
@export var catchup_speed: float = 2.0  
@export var leash_distance: float = 10.0  

var frame_pos: Vector3

func _ready() -> void:
	super()
	var vessel = get_parent().get_node("Vessel")
	frame_pos = vessel.global_transform.origin
	frame_pos.y += 10

func _process(delta: float) -> void:
	if !current:
		return

	if draw_camera_logic:
		draw_logic()

	var vessel = get_parent().get_node("Vessel")
	_follow_vessel(vessel, delta) 


	global_transform.origin = frame_pos
	super(delta)

func _follow_vessel(vessel: Node, delta: float) -> void:
	var vessel_pos = vessel.global_transform.origin
	var distance = frame_pos.distance_to(vessel_pos)
	
	# print("Vessel Velocity: ", vessel.velocity)
	frame_pos.y = vessel_pos.y + 10

	if vessel.velocity.length() > 0:
		if distance > leash_distance:
			var direction = (frame_pos - vessel_pos).normalized()
			frame_pos = vessel_pos + direction * leash_distance
		else:
			frame_pos = frame_pos.lerp(vessel_pos, follow_speed * delta)
	else:
		frame_pos = frame_pos.lerp(vessel_pos, catchup_speed * delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	immediate_mesh.surface_add_vertex(Vector3(2.5, 0, 0))   
	immediate_mesh.surface_add_vertex(Vector3(-2.5, 0, 0)) 
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 2.5))   
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -2.5)) 	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
