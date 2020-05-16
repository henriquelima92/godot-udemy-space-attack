extends Area2D

export(PackedScene) var projectile

onready var timer = $Timer
onready var collision = $CollisionShape2D

export var speed = 50
export var health = 30

signal was_defeated

var dead = false
var can_shoot = true

func _process(delta):
	if can_shoot == true:
		_shoot()

func _shoot():
	if dead == true:
		return
		
	can_shoot = false
	var new_projectile = projectile.instance()
	new_projectile.position = global_position
	get_tree().get_root().add_child(new_projectile)
	timer.start()
	

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true	
		collision.queue_free()
		hide()
		emit_signal("was_defeated")


func _on_Timer_timeout():
	can_shoot = true
