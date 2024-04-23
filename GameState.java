public class GameState {
    private int score;
    private List<GameObject> gameObjects;

    public GameState() {
        this.score = 0;
        this.gameObjects = new ArrayList<>();
    }

    public void updateGameState() {
        for (GameObject obj : gameObjects) {
            obj.updatePosition(this);
        }
    }

    public void onEnemyDeath(Enemy enemy) {
        gameObjects.remove(enemy);
        score += 10;
        // Optionally, spawn a new enemy
        // renderer.spawnEnemy();
    }

    public int getScore() {
        return score;
    }

    public List<GameObject> getGameObjects() {
        return gameObjects;
    }
}
