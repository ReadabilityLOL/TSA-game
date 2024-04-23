import java.util.ArrayList;
import java.util.List;

public class PhysicsEngine {
    private List<GameObject> gameObjects;
    private List<Player> players;

    public PhysicsEngine() {
        gameObjects = new ArrayList<>();
        players = new ArrayList<>();
    }

    public void addGameObject(GameObject gameObject) {
        gameObjects.add(gameObject);
    }

    public void addPlayer(Player player) {
        players.add(player);
    }

    public void removeGameObject(GameObject gameObject) {
        gameObjects.remove(gameObject);
    }

    public void update() {
        for (GameObject gameObject : gameObjects) {
            gameObject.updatePhysics();
            checkCollisions(gameObject);
        }
        synchronizeGameState();
    }

    private void checkCollisions(GameObject gameObject) {
        for (GameObject other : gameObjects) {
            if (gameObject != other && gameObject.collidesWith(other)) {
                handleCollision(gameObject, other);
            }
        }
    }

    private void handleCollision(GameObject obj1, GameObject obj2) {
        // add stuff like, calculating the collision response based on mass and velocity
        float mass1 = obj1.getMass();
        float mass2 = obj2.getMass();
        float totalMass = mass1 + mass2;

        float newVx1 = ((mass1 - mass2) / totalMass) * obj1.getVx() + ((2 * mass2) / totalMass) * obj2.getVx();
        float newVy1 = ((mass1 - mass2) / totalMass) * obj1.getVy() + ((2 * mass2) / totalMass) * obj2.getVy();

        float newVx2 = ((2 * mass1) / totalMass) * obj1.getVx() + ((mass2 - mass1) / totalMass) * obj2.getVx();
        float newVy2 = ((2 * mass1) / totalMass) * obj1.getVy() + ((mass2 - mass1) / totalMass) * obj2.getVy();

        obj1.setVx(newVx1);
        obj1.setVy(newVy1);
        obj2.setVx(newVx2);
        obj2.setVy(newVy2);
    }

    public void synchronizeGameState() {
        for (Player player : players) {
            // Send game state updates to the player
            System.out.println("Sending game state update to " + player.getName());
        }
    }
}
