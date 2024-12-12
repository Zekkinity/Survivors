extends CharacterBody2D

@export var BulletScene: PackedScene
@export var num_of_bullets: int = 8
@export var bullet_speed: float = 200
@export var shooting_interval: float = 1.0
@export var rotationAroundEnemy: float = 0
@export var enemyIsCenter: bool = true
@export var bullet_rotation_speed: float = 0
func _ready():
	$ShootTimer.wait_time = shooting_interval
	$ShootTimer.start()

func _process(delta):
	$Node2D.rotation += rotationAroundEnemy

func shoot_bullets():
	var angle_step = 2 * PI / num_of_bullets
	for i in range(num_of_bullets):
		var bullet = BulletScene.instantiate()
		
		if enemyIsCenter == true:
			bullet.position = global_position
		else:
			bullet.position = $Node2D/Marker2D.global_position
		bullet.rotation = angle_step * i
		bullet.speed = bullet_speed
		bullet.rotation_speed = bullet_rotation_speed
		get_parent().add_child(bullet)
		


func _on_shoot_timer_timeout():
	shoot_bullets()
