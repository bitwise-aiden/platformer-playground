class_name Dependency


var __default
var __dependency: FuncRef


# Lifecycle methods

func _init(default = null) -> void: 
	self.__default = default


# Accessor methods

var value = null setget , get_value

func get_value():
	if self.__dependency && self.__dependency.is_valid():
		return self.__dependency.call_func()
	
	return self.__default


# Public methods

func attach(instance, funcname: String) -> void: 
	self.__dependency = funcref(instance, funcname)
