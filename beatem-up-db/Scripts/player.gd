extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
var is_attacking = false
const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = direction.normalized()
	velocity = direction * SPEED

	
	if direction.x != 0:
		anim.flip_h = direction.x < 0
		
	if Input.is_action_just_pressed("attack") && is_attacking == false:
		is_attacking = true 
		anim.play("Ataque")
		return
	
	if direction != Vector2.ZERO:
		anim.play("Run")
	else:
		anim.play("Idle")

	if !is_attacking:
		velocity = direction * SPEED ;
	move_and_slide()	
