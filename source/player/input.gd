class_name PlayerInput extends Node


var __movement: Vector2 = Vector2.ZERO
var __movement_horizontal: Vector2 = Vector2.ZERO
var __movement_vertical: Vector2 = Vector2.ZERO

var __direction: float = 0.0

var __jump_buffer: InputBuffer = InputBuffer.new("jump")

var __input_buffers = [
	__jump_buffer,
]

# Lifecylce methods

func _physics_process(delta: float) -> void:
	__movement_horizontal = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		0.0
	)

	__movement_vertical = Vector2(
		0.0,
		Input.get_action_strength("up") - Input.get_action_strength("down")
	)

	__movement = (
		__movement_horizontal + __movement_vertical
	).normalized()

	if is_move():
		__direction = __movement_horizontal.x


	for buffer in __input_buffers:
		buffer.process(delta)


# Public methods

func is_jump() -> bool:
	return __jump_buffer.triggered()


func is_move() -> bool:
	return __movement_horizontal.x != 0.0


func direction() -> float:
	return __direction


func movement() -> Vector2:
	return __movement


func movement_horizontal() -> Vector2:
	return __movement_horizontal


func movement_vertical() -> Vector2:
	return __movement_vertical
