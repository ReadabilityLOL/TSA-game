import java.awt.Graphics;
import java.awt.image.BufferedImage;
import javax.swing.JPanel;
import java.util.List;
import java.util.ArrayList;

public class Renderer extends JPanel {
    private GameEngine gameEngine;
    private BufferedImage backgroundImage;
    private List<GameObject> gameObjects;
    private int score;
    private PhysicsEngine physEngine;

    public Renderer(GameEngine gameEngine) {
        this.gameEngine = gameEngine;
        setDoubleBuffered(true); // Enable for smoother rendering
        loadBackgroundImage();
        gameObjects = new ArrayList<>();
        gameObjects.add(new Player("Player 1", 100, 100, 100));
        spawnEnemy();
        physEngine = new PhysicsEngine();
    }

    private void loadBackgroundImage() {
        // actual image loading logic
        backgroundImage = new BufferedImage(800, 600, BufferedImage.TYPE_INT_RGB);
    }

    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        drawBackground(g);
        drawGameObjects(g);
        drawScore(g);
    }

    private void drawBackground(Graphics g) {
        if (backgroundImage != null) {
            g.drawImage(backgroundImage, 0, 0, this);
        }
    }

    private void drawGameObjects(Graphics g) {
        for (GameObject obj : gameObjects) {
            obj.render(g);
        }
    }

    private void drawScore(Graphics g) {
        g.drawString("Score: " + score, 10, 20);
    }

    public void render() {
        repaint();
    }

    public void updateGameState(GameState gameState) {
        for (GameObject obj : gameObjects) {
            obj.updatePosition(gameState);
        }
        render();
    }

    public void spawnEnemy() {
        // add spawning logic
        int x = (int) (Math.random() * 800);
        int y = (int) (Math.random() * 600);
        gameObjects.add(new Enemy("Enemy", x, y, 100));
    }

    public void onEnemyDeath(Enemy enemy) {
        gameObjects.remove(enemy);
        score += 10;
        spawnEnemy();
    }

    public void usePlayerAbility() {
        Player player = getPlayer();
        if (player != null) {
            player.useAbility();
        }
    }

    public void updateGameState(GameState gameState) {
        for (GameObject obj : gameObjects) {
            obj.updatePosition(gameState);
        }
        PhysicsEngine.checkCollisions(gameObjects);
        render();
    }
}
