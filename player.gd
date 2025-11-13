extends Area2D

@export var speed = 400 # Pelaajan liikkumisnopeus (pikseliä/s)
var screen_size # Peliruudun koko

# Tämä kutsutaan, kun solmu luodaan ensimmäistä kertaa
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Kutsutaan kerran per frame. 'delta' viittaa aikaan, joka on kulunut.
func _process(delta):
	var velocity = Vector2.ZERO # Pelaajan liikkumisvektori
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

signal hit

func _on_body_shape_entered(body):
	hide() # Piilottaa pelaajan hahmon osumistilanteessa
	hit.emit()
	# Hahmo poistetaan käytöstä, jotta osumasignaali toimii vain kerran
	$CollisionShape2D.set_deferred("disabled", true)
