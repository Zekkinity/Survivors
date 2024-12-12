extends Area2D

@export var speed: float = 200
@export var rotation_speed: float = 0
var velocity = Vector2()

func _ready():
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	rotation += rotation_speed * delta
	velocity = velocity.rotated(rotation_speed * delta)
	position += velocity * delta
	if !get_viewport_rect().has_point(global_position):
		queue_free()


func _on_area_entered(area):
	queue_free()
