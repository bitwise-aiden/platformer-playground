class_name PlayerInput extends Node


var __movement: Vector2 = Vector2.ZERO
var __movement_horizontal: Vector2 = Vector2.ZERO
var __movement_vertical: Vector2 = Vector2.ZERO

var __direction: float = 0.0

var __jump_buffer: InputBuffer = InputBuffer.new("jump")

var __input_buffers = [
	self.__jump_buffer,
]

# Lifecylce methods

func _physics_process(delta: float) -> void:
	self.__movement_horizontal = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		0.0
	)
	
	self.__movement_vertical = Vector2(
		0.0,
		Input.get_action_strength("up") - Input.get_action_strength("down")
	)
	
	self.__movement = (
		self.__movement_horizontal + self.__movement_vertical
	).normalized()
	
	if self.is_move():
		self.__direction = self.__movement_horizontal.x
	
	
	for buffer in self.__input_buffers:
		buffer.process(delta)


# Public methods


func is_jump() -> bool: 
	return self.__jump_buffer.triggered()


func is_move() -> bool: 
	return self.__movement_horizontal.x != 0.0


func direction() -> float: 
	return self.__direction


func movement() -> Vector2:
	return self.__movement


func movement_horizontal() -> Vector2:
	return self.__movement_horizontal 


func movement_vertical() -> Vector2:
	return self.__movement_vertical
