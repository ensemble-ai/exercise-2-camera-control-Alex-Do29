class_name LerpFocusCamera
extends CameraControllerBase

@export var lead_speed: float = 20.0  
@export var catchup_delay_duration: float = 0.05 
@export var catchup_speed: float = 10.0 
@export var leash_distance: float = 5.0 

var frame_pos: Vector3
var timer: float = 0.0  
var pos: Vector3 

func _ready() -> void:
	super()
	var vessel = get_parent().get_node("Vessel")
	frame_pos = vessel.global_transform.origin  
	pos = vessel.global_transform.origin  
	
func _process(delta: float) -> void:
	if !current:
		return

	if draw_camera_logic:
		draw_logic()

	var vessel = get_parent().get_node("Vessel")
	follow_vessel(vessel, delta)

	global_transform.origin = frame_pos 
	super(delta)

func follow_vessel(vessel, delta) -> void:
	var vessel_pos = vessel.global_transform.origin
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).limit_length(1.0)

	# print("Vessel Velocity: ", vessel.velocity)

	if input_dir != Vector2.ZERO:
		var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
		var target_pos = vessel_pos + direction * leash_distance
		frame_pos = frame_pos.lerp(target_pos, lead_speed * delta)
		timer = 0.0  
	else:
		timer += delta
		if timer >= catchup_delay_duration:
			frame_pos = frame_pos.lerp(vessel_pos, catchup_speed * delta)

	pos = vessel_pos  

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
