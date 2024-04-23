import java.util.Random;

public class Enemy extends Entity {
    private static final Random random = new Random();
    private Player player;

    public Enemy(int id, String name, float x, float y, float mass, float friction, Player player) {
        super(id, name, x, y, mass, friction);
        this.player = player;
    }

    public void move() {
        float playerX = player.getX();
        float playerY = player.getY();

        if (getX() < playerX) {
            setX(getX() + 1);
        } else if (getX() > playerX) {
            setX(getX() - 1);
        }

        if (getY() < playerY) {
            setY(getY() + 1);
        } else if (getY() > playerY) {
            setY(getY() - 1);
        }
    }

    public void attack() {
        float distanceToPlayer = Math.abs(getX() - player.getX()) + Math.abs(getY() - player.getY());
        if (distanceToPlayer <= 1) {
            player.takeDamage(10); // Example damage value
        }
    }

    public void takeDamage(int damage) {
        super.takeDamage(damage);
        if (!isAlive()) {
            // Implement enemy death logic here, e.g., remove from game, play death
            // animation
            System.out.println(getName() + " has been defeated.");
        }
    }
}
