import java.util.Random;

public class Enemy extends Entity {
    private static final Random random = new Random();
    private Player player;

    public Enemy(int id, String name, float x, float y, float mass, float friction,int health, Player player) {
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
  super.takeDamage(damage); // Call parent class damage handling (if applicable)

  // Track enemy health
  //int currentHealth = getHealth(); // Replace with your method to get enemy health
  health -= damage;
  //setHealth(currentHealth); // Replace with your method to set enemy health

  if (!isAlive()) {
    // Enemy death logic
    playDeathAnimation(); // Play death animation (falling and closing eyes)
    removeFromGame(); // Remove enemy from game world

    // Check for player death (assuming this is the player entity)
    if (this instanceof Player) {
      // Player death logic
      System.out.println("You have been defeated!");
      if (promptForRestart()) { // Ask player to restart
        restartGame(); // Create a new game object (or trigger game restart logic)
      } else {
        // Handle player choosing not to restart (e.g., quit game)
      }
    }
  }
}

// Helper methods (replace with your actual implementations)
private int getHealth() {
  // Implement logic to return enemy's current health
  return health; // Placeholder
}

//private void setHealth(int health) {
  // Implement logic to set enemy's health
  //return; // Placeholder
//}

private boolean isAlive() {
  // Implement logic to check if enemy health is above 0
  if (getHealth()<=0){
	  return false
  }
  return true; // Placeholder
}

private void removeFromGame() {
  // Implement logic to remove enemy from the game world (e.g., list, map)
}

// Death animation (replace with your game engine/library specific logic)
private void playDeathAnimation() {
  System.out.println(getName() + " falls down..."); // Placeholder animation text
  // Implement animation for falling (e.g., sprite change, sound effect)
  System.out.println(getName() + " closes their eyes..."); // Placeholder animation text
  // Implement animation for closing eyes (e.g., sprite change)
}

// Prompt for game restart (replace with your UI library specific logic)
private boolean promptForRestart() {
  System.out.println("Play again? (y/n)");
  String input = getUserInput(); // Replace with method to get user input
  return input.equalsIgnoreCase("y");
}

// Get user input (replace with your UI library specific logic)
private String getUserInput() {
  // Implement logic to get user input from console or UI
  return ""; // Placeholder
}

// Restart game (replace with your game initialization logic)
private void restartGame() {
  System.out.println("Starting a new game...");
  // Create a new game object or trigger game restart logic
}

}
