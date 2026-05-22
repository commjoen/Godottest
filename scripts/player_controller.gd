extends Node3D

@export var move_speed: float = 8.0
@export var vertical_speed: float = 4.5
@export var mouse_sensitivity: float = 0.08

var _pitch_degrees: float = 0.0
@onready var _camera: Camera3D = $Camera3D

func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
        _pitch_degrees = clamp(_pitch_degrees - event.relative.y * mouse_sensitivity, -70.0, 70.0)
        _camera.rotation_degrees.x = _pitch_degrees

    if event.is_action_pressed("ui_cancel"):
        if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
        else:
            Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
    var planar_input := Vector2(
        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    )

    var local_direction := Vector3(planar_input.x, 0.0, planar_input.y)
    var world_direction := (global_transform.basis * local_direction)
    world_direction.y = 0.0
    if world_direction.length_squared() > 0.0001:
        world_direction = world_direction.normalized()

    var vertical_input := int(Input.is_key_pressed(KEY_E)) - int(Input.is_key_pressed(KEY_Q))
    var velocity := world_direction * move_speed
    velocity.y = float(vertical_input) * vertical_speed

    global_position += velocity * delta
