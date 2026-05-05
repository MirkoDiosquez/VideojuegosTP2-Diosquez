extends Control

@onready var btn_restart = $Reiniciar
@onready var btn_quit = $Salir

func _ready() -> void:
	btn_restart.pressed.connect(_on_restart)
	btn_quit.pressed.connect(_on_quit)
	btn_restart.mouse_filter = Control.MOUSE_FILTER_STOP
	btn_quit.mouse_filter = Control.MOUSE_FILTER_STOP

func _on_restart() -> void:
	get_tree().change_scene_to_file("res://Escenas/node_2d.tscn")

func _on_quit() -> void:
	get_tree().quit()
