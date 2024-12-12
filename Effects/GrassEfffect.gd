extends Node2D

@onready var animatedSprite = $AnimatedSprite2D

func _ready():
	animatedSprite.frame = 0
	animatedSprite.play("animate")

func _on_animated_sprite_2d_animation_looped():
	queue_free()
