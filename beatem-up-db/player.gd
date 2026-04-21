extends CharacterBody2D
@onready var anim = $AnimatedSprite2D

var is_attacking = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	direction = direction.normalized()
	
	velocity = direction * SPEED
	move_and_slide()	
	
	# Flip horizontal
	if direction.x != 0:
		anim.flip_h = direction.x < 0
	
	# Animaciones
	if is_attacking:
		return
	
	if direction != Vector2.ZERO:
		anim.play("Run")
	else:
		anim.play("Idle")
	# Movimiento solo si no está atacando
	if !is_attacking:
		velocity = direction * SPEED
