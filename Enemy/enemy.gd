extends CharacterBody2D

var speed = 1000 # Enemy movement speed
var player = null

@onready var stats = $stats
@onready var death = $AudioStreamPlayer
@onready var animationPlayer = $Sprite2D/AnimationPlayer
@onready var sprite = $Sprite2D

func _ready():
	player = get_node("/root/Main/Player")
	

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
	move_and_slide()

	if player != null:
		var direction = (player.position - position).normalized()
		velocity = direction * speed * delta
		animationPlayer.play("walk")
		move_and_slide()
	else:
		animationPlayer.play("Idle")
	
	if velocity.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

func _on_hurtbox_area_entered(area):
	# Damage enemy
	stats.health -= 1

	# Knockback
	var direction = ( position - area.owner.position ).normalized()
	velocity = direction * 1500



func _on_stats_no_health():
	# cant emit sound?
	#death.play()
	queue_free()
