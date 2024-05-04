extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8

var cell_walls = {
    Vector2(1, 0): E, Vector2(-1, 0): W,
    Vector2(0, 1): S, Vector2(0, -1): N
}

var tile_size = 64
var width = 25
var height = 15

onready var Map = $TileMap

func _ready():
    randomize()
    tile_size = Map.cell_size
    make_maze()

func make_maze():
    var unvisited = []
    var stack = []
    Map.clear()
    for x in range(width):
        for y in range(height):
            unvisited.append(Vector2(x, y))
            Map.set_cellv(Vector2(x, y), N | E | S | W)
    var current = Vector2(0, 0)
    unvisited.erase(current)

    while unvisited.size() > 0:
        var neighbors = check_neighbors(current, unvisited)
        if neighbors.size() > 0:
            var next = neighbors[randi() % neighbors.size()]
            stack.append(current)
            var dir = next - current
            var current_walls = Map.get_cellv(current) - cell_walls[dir]
            var next_walls = Map.get_cellv(next) - cell_walls[-dir]
            Map.set_cellv(current, current_walls)
            Map.set_cellv(next, next_walls)
            current = next
            unvisited.erase(current)
        elif stack.size() > 0:
            current = stack.pop_back()

