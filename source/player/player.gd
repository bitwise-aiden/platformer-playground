class_name Player extends CharacterBody2D


@export var speed: float = 7.5
@export var gravity: float = 10.0
@export var jump_force: float = 10.0

var __jump_velocity: Vector2 = Vector2.ZERO

@onready var __input: PlayerInput = $input
@onready var __collision: PlayerCollision = $collision


# Lifecycle methods

func _ready() -> void:
	__collision.player_position.attach(get_position)

	var animation = $animation
	animation.direction.attach(__input.direction)
	animation.is_move.attach(__input.is_move)
	animation.on_ground.attach(__collision.on_ground)


func _physics_process(_delta: float) -> void:
	__handle_jump()

	var calculated_velocity: Vector2 = __input.movement_horizontal() * speed

	if __collision.on_ceiling() && __jump_velocity.y < 0.0:
		__jump_velocity = Vector2.ZERO

	if !__collision.on_ground():
		__jump_velocity += Vector2.DOWN * gravity

	calculated_velocity += __jump_velocity

	var previous_position: Vector2 = position

	var collision: KinematicCollision2D = move_and_collide(calculated_velocity)
	if collision && collision.get_normal().x != 0.0:
		var position_delta: Vector2 = previous_position - position
		var remaining_y = velocity.y - position_delta.y

		move_and_collide(Vector2(0.0, remaining_y))


# Private methods

func __handle_jump() -> void:
	if !__collision.on_ground():
		return

	__jump_velocity = Vector2.ZERO

	if __input.is_jump():
		__jump_velocity = Vector2.UP * jump_force
