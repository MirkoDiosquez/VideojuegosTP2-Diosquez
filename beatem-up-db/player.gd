extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var cooldown_timer = $CooldownTimer

var is_attacking = false
var can_attack = true
const SPEED = 300.0

func _ready() -> void:
	anim.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = direction.normalized()

	velocity = direction * SPEED
	move_and_slide()

	if direction.x != 0:
		anim.flip_h = direction.x < 0

	if Input.is_action_just_pressed("attack") and can_attack and not is_attacking:
		_start_attack()
		return

	if not is_attacking:
		if direction != Vector2.ZERO:
			anim.play("Run")
		else:
			anim.play("Idle")

func _start_attack() -> void:
	is_attacking = true
	can_attack = false
	anim.play("Ataque")

func _on_animation_finished() -> void:
	if anim.animation == "Ataque":
		is_attacking = false
		cooldown_timer.start()

func _on_cooldown_timer_timeout() -> void:
	can_attack = true


func _on_cooldown_timeout() -> void:
	pass # Replace with function body.
