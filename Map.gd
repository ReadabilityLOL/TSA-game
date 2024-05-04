extends Node

# Reference to the TileMap node
onready var tile_map = $TileMap

# Preload the enemy and ally scenes
var EnemyScene = preload("res://path/to/Enemy.tscn")
var AllyScene = preload("res://path/to/Ally.tscn")

# Tile IDs for enemy and ally spawns
const ENEMY_TILE_ID = 1
const ALLY_TILE_ID = 2

func _ready():
    generate_entities()

func generate_entities():
    var used_cells = tile_map.get_used_cells()
    for cell in used_cells:
        var tile_id = tile_map.get_cellv(cell)
        var position = tile_map.map_to_world(cell) + tile_map.cell_size / 2
        
        if tile_id == ENEMY_TILE_ID:
            spawn_enemy(position)
        elif tile_id == ALLY_TILE_ID:
            spawn_ally(position)

func spawn_enemy(position):
    var enemy = EnemyScene.instance()
    enemy.global_transform.origin = position
    add_child(enemy)

func spawn_ally(position):
    var ally = AllyScene.instance()
    ally.global_transform.origin = position
    add_child(ally)
