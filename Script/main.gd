extends Node2D

@onready var items: Node2D = $Items
@onready var item_spawn_area: Area2D = $ItemSpawnArea
@onready var collision_shape: CollisionShape2D = $ItemSpawnArea/CollisionShape2D
