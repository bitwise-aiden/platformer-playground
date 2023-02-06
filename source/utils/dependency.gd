class_name Dependency


var __default
var __dependency: Callable


# Lifecycle methods

func _init(default = null):
	__default = default


# Accessor methods

var value = null : get = get_value

func get_value():
	if __dependency != null && __dependency.is_valid():
		return __dependency.call()

	return __default


# Public methods

func attach(dependency: Callable) -> void:
	__dependency = dependency
