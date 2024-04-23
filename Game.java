
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Game {
    private DatabaseManager dbManager;
    private Map<String, Player> players;
    private boolean isRunning;
    private ExecutorService executorService;

    public Game(String host, int port, boolean useSSL, String nameSpace) {
        dbManager = new DatabaseManager(host, port, useSSL, nameSpace, dbManager.getName());
        players = new HashMap<>();
        isRunning = true;
        executorService = Executors.newFixedThreadPool(10); // Adjust the thread pool size as needed
    }

    public void start() {
        Scanner scanner = new Scanner(System.in);
        while (isRunning) {
            try {
                processInput(scanner);
                update();
                render();
            } catch (Exception e) {
                System.out.println("An error occurred: " + e.getMessage());
                stop();
            }
        }
        scanner.close();
    }

    private void processInput(Scanner scanner) {
        System.out.print("Enter command: ");
        String input = scanner.nextLine();
        String[] commandParts = input.split(" ");
        String command = commandParts[0];
        String playerName = commandParts.length > 1 ? commandParts[1] : null;

        switch (command) {
            case "join":
                if (playerName != null) {
                    joinGame(playerName);
                } else {
                    System.out.println("Please specify a player name.");
                }
                break;
            case "leave":
                if (playerName != null) {
                    leaveGame(playerName);
                } else {
                    System.out.println("Please specify a player name.");
                }
                break;
            case "list":
                listPlayers();
                break;
            case "start":
                startGame();
                break;
            case "stop":
                stopGame();
                break;
            default:
                System.out.println("Unknown command.");
                break;
        }
    }

    private void update() {
        this.update();
    }

    private void render() {
        this.render();
    }

    public synchronized void stop() {
        isRunning = false;
        executorService.shutdown();
    }

    private void joinGame(String playerName) {
        if (!players.containsKey(playerName)) {
            Player player = new Player();
            player.setName(playerName);
            players.put(playerName, player);
            System.out.println(playerName + " has joined the game.");
        } else {
            System.out.println(playerName + " is already in the game.");
        }
    }

    private void leaveGame(String playerName) {
        if (players.containsKey(playerName)) {
            players.remove(playerName);
            System.out.println(playerName + " has left the game.");
        } else {
            System.out.println(playerName + " is not in the game.");
        }
    }

    private void listPlayers() {
        System.out.println("Players in the game:");
        for (String playerName : players.keySet()) {
            System.out.println(playerName);
        }
    }

    private void startGame() {
        if (players.size() > 1) {
            isRunning = true;
            System.out.println("Game started.");
            // Start game logic
        } else {
            System.out.println("At least two players are required to start the game.");
        }
    }

    private void stopGame() {
        isRunning = false;
        System.out.println("Game stopped.");
        // Additional game stop logic
    }

    public static void main(String[] args) {
        Game game = new Game("localhost", 8000, false, "Game");
        game.start();
    }
}
