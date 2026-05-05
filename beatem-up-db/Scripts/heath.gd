extends Area2D

const HEAL_AMOUNT = 30

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.has_method("heal"):
		body.heal(HEAL_AMOUNT)
		queue_free()
