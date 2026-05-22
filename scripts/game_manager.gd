extends Node

@export var player_path: NodePath = NodePath("../Player")
@export var goal_paths: Array[NodePath] = [NodePath("../RuinsMarker"), NodePath("../CaveMarker")]
@export var goal_radius: float = 4.0

@onready var _status_label: Label = $CanvasLayer/StatusLabel

var _player: Node3D
var _goals_reached: Dictionary = {}


func _ready() -> void:
	_player = get_node_or_null(player_path) as Node3D
	for goal_path in goal_paths:
		_goals_reached[goal_path] = false
	_update_status_text()


func _process(_delta: float) -> void:
	if _player == null:
		_player = get_node_or_null(player_path) as Node3D
		if _player == null:
			_status_label.text = "Waiting for player..."
			return

	var reached_this_frame := false
	for goal_path in goal_paths:
		if _goals_reached.get(goal_path, false):
			continue

		var goal := get_node_or_null(goal_path) as Node3D
		if goal == null:
			continue

		if _player.global_position.distance_to(goal.global_position) <= goal_radius:
			_goals_reached[goal_path] = true
			reached_this_frame = true

	if reached_this_frame:
		_update_status_text()


func _update_status_text() -> void:
	var reached_count := 0
	for reached in _goals_reached.values():
		if reached:
			reached_count += 1

	var total_goals := goal_paths.size()
	if reached_count >= total_goals and total_goals > 0:
		_status_label.text = "Mission complete! You found every landmark.\nRestart to play again."
		return

	var remaining := total_goals - reached_count
	_status_label.text = "Find underwater landmarks: %d remaining\nMove: WASD/Arrows  Up: E  Down: Q  Look: Mouse" % remaining
