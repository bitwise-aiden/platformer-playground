class_name PlayerCollision extends Node2D


@export var collision_mask: int # (int, LAYERS_2D_PHYSICS)
@export var extents: Vector2
@export var horizontal_collision_area: Shape2D
@export var vertical_collision_area: Shape2D

var player_position: Dependency = Dependency.new(Vector2.ZERO)

var __on_ceiling: bool = false
var __on_ground: bool = false
var __on_wall: bool = false
var __on_wall_left: bool = false
var __on_wall_right: bool = false

@onready var __direct_space_state = get_world_2d().direct_space_state


# Lifecycle methods

func _physics_process(_delta: float) -> void:
	__on_ceiling = __check_collision(
		Vector2(0.0, -extents.y),
		horizontal_collision_area
	)
	__on_ground = __check_collision(
		Vector2(0.0, extents.y),
		horizontal_collision_area
	)
	__on_wall_left = __check_collision(
		Vector2(-extents.x, 0.0),
		vertical_collision_area
	)
	__on_wall_right = __check_collision(
		Vector2(extents.x, 0.0),
		vertical_collision_area
	)
	__on_wall = __on_wall_left || __on_wall_right


# Public methods

func on_ceiling() -> bool:
	return __on_ceiling


func on_ground() -> bool:
	return __on_ground


func on_wall() -> bool:
	return __on_wall


func on_wall_left() -> bool:
	return __on_wall_left


func on_wall_right() -> bool:
	return __on_wall_right


# Private methods

func __check_collision(offset: Vector2, collision_area: Shape2D) -> bool:
	var params = PhysicsShapeQueryParameters2D.new()
	params.set_shape(collision_area)
	params.transform = Transform2D(
		0.0,
		player_position.value + offset
	)
	params.collision_mask = 1
	params.collide_with_bodies = true
	params.collide_with_areas = true

	var result = __direct_space_state.intersect_shape(params, 1)
	return result.size() > 0
