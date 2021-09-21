class_name PlayerCollision extends Node2D


export(Vector2) var ground_offset: Vector2
export(Vector2) var wall_left_offest: Vector2
export(Vector2) var wall_right_offset: Vector2
export(Shape2D) var collision_area: Shape2D
export(int, LAYERS_2D_PHYSICS) var collision_layer: int

var player_position: Dependency = Dependency.new(Vector2.ZERO)

var __on_ground: bool = false
var __on_wall: bool = false
var __on_wall_left: bool = false
var __on_wall_right: bool = false

onready var __direct_space_state = self.get_world_2d().direct_space_state


# Lifecycle methods

func _physics_process(delta: float) -> void:
	self.__on_ground = self.__check_collision(self.ground_offset)
	self.__on_wall_left = self.__check_collision(self.wall_left_offest)
	self.__on_wall_right = self.__check_collision(self.wall_right_offset)
	self.__on_wall = self.__on_wall_left || self.__on_wall_right


# Public methods

func on_ground() -> bool:
	return self.__on_ground


func on_wall() -> bool:
	return self.__on_wall


func on_wall_left() -> bool:
	return self.__on_wall_left


func on_wall_right() -> bool:
	return self.__on_wall_right


# Private methods

func __check_collision(offset: Vector2) -> bool:
	var params = Physics2DShapeQueryParameters.new()
	params.set_shape(self.collision_area)
	params.transform = Transform2D(
		0.0,
		self.player_position.value + offset
	)
	params.collision_layer = self.collision_layer
	params.collide_with_bodies = true
	params.collide_with_areas = true

	var result = self.__direct_space_state.intersect_shape(params, 1)
	return result.size() > 0
