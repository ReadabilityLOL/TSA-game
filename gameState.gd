extends Node

var enemies = []

func add_enemy(enemy):
    enemies.append(enemy)

func remove_enemy(enemy):
    enemies.erase(enemy)
