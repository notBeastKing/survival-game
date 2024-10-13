extends Area2D
signal hit
@export var speed = 400 #the export keyword lets you change the speed value in inspector
var screen_size

func _ready(): #this function is called when the node enters the scene tree ie the node is being used 
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	var velocity = Vector2.ZERO #velocity is a vector2 datatype and setting its value as(0,0) with .ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	velocity = velocity.normalized() * speed
	$AnimatedSprite2D.play()
	#idle animation
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.animation = "idle"
	#animation if its moving left and right
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	#animation if its moving up and down
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	position += velocity *delta
	position = position.clamp(Vector2.ZERO, screen_size)
	


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)
