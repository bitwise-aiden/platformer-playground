class_name InputBuffer


var __name: String = ""

var __buffer: float = .0
var __elapsed: float =.0


# Lifecycle methods

func _init(name: String, buffer: float = .25) -> void:
	self.__name = name

	self.__buffer = buffer


# Public methods

func triggered() -> bool:
	return self.__elapsed > 0.0


func process(delta: float) -> void:
	self.__elapsed = max(0.0, self.__elapsed - delta)

	if Input.is_action_just_pressed(self.__name):
		self.__elapsed = self.__buffer
