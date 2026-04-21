extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@onready var Cooldown = $Cooldown
@onready var attack_zone = $AttackZone
var is_attacking = false
var can_attack = true
var aim = Vector2.RIGHT
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
	position.x = clamp(position.x, 15, 10000000)
	position.y = clamp(position.y, 110, 670)
	
	
	if not is_attacking and direction.x != 0:
		aim = Vector2.RIGHT * sign(direction.x)
		anim.flip_h = direction.x < 0

	attack_zone.position.x = abs(attack_zone.position.x) * aim.x

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
		Cooldown.start()

func _on_cooldown_timeout() -> void:
	can_attack = true
	
	attack_zone.position.x = abs(attack_zone.position.x) * aim.x
	print("aim: ", aim, " | attack_zone.x: ", attack_zone.position.x)
