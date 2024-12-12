extends Node2D

var dino = preload("res://Enemy/enemy.tscn")
var radius = 300
var numberOfEnemies = 16
var player = null

func _ready() -> void:
	player = get_node("/root/Main/Player")
	instantiateAroundPlayer()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Space"):
		instantiateAroundPlayer()
		

func inst(pos):
	var instance = dino.instantiate()
	instance.position = pos
	add_child(instance)

func instantiateAroundPlayer():
	var angle_step = 360 / numberOfEnemies
	for i in range(numberOfEnemies):
		var angle = deg_to_rad(i * angle_step)
		var position = Vector2(radius * cos(angle), radius * sin(angle))
		var instance = dino.instantiate()
		instance.position = player.position + position  # Position around the player
		add_child(instance)
