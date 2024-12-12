extends CharacterBody2D

const MAX_SPEED = 8000
#const SLOWED_SPEED = 1500
const ROLL_SPEED = 16000
const ATTACK_SPEED = 4000

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var swordHitbox = $Marker2D/swordHitbox/CollisionShape2D

var current_speed = MAX_SPEED
var attackDirection = Vector2.ZERO

enum {
	MOVE,
	ROLL,
	ATTACK,
}

var state = MOVE

func _ready():
	animationTree.active = true
	swordHitbox.disabled = true

func _physics_process(delta):
	match state:
		MOVE:
			moveState(delta)
		ROLL:
			rollState(delta)
		ATTACK:
			attackState(delta)

	
	if Input.is_action_just_pressed("Space"):
		current_speed = ROLL_SPEED
		state = ROLL
	elif Input.is_action_just_released("Space"):
		current_speed = MAX_SPEED
		state = ROLL
	

func moveState(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	direction = direction.normalized()
	swordHitbox.disabled = true

	if direction != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", direction)
		animationTree.set("parameters/Run/blend_position", direction)
		animationTree.set("parameters/Attack/blend_position", direction)
		animationState.travel("Run")
		
		velocity = direction * current_speed * delta
		move_and_slide()
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO * delta
		
		
	
	if Input.is_action_just_pressed("attack"):
		var global_mouse_position = get_global_mouse_position()
		var parent_global_position = get_global_position()
		var relative_position = global_mouse_position - parent_global_position
		$Marker2D.position = relative_position.normalized() * 20.0
		$Marker2D.rotation = relative_position.angle()
	
		#var hurtbox = $Marker2D
		#hurtbox.position = (get_global_mouse_position() - hurtbox.global_position)
		
		attackDirection = (get_global_mouse_position() - position).normalized()
		state = ATTACK


func rollState(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	direction = direction.normalized()
	swordHitbox.disabled = true
	
	if direction != Vector2.ZERO:
		# Get LIF OUT animation
		animationTree.set("parameters/Idle/blend_position", direction)
		animationTree.set("parameters/Run/blend_position", direction)
		animationState.travel("Run")
		
		velocity = direction * current_speed * delta
		move_and_slide()
	else:
		#animationPlayer.play("idleRight")
		animationState.travel("Idle")
		velocity = Vector2.ZERO * delta


func attackState(delta):
	swordHitbox.disabled = false
	velocity = attackDirection * ATTACK_SPEED * delta
	move_and_slide()
	animationTree.set("parameters/Attack/blend_position", attackDirection)
	animationTree.set("parameters/Idle/blend_position", attackDirection)
	animationTree.set("parameters/Run/blend_position", attackDirection)
	animationState.travel("Attack")
	swordHitbox.disabled = false
	#if Input.is_action_just_pressed("attack"):
#		state = ATTACK2
	


func attackAnimationFinished():
	state = MOVE
