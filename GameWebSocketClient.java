import org.java_websocket.client.WebSocketClient;
import org.java_websocket.handshake.ServerHandshake;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

public class GameWebSocketClient extends WebSocketClient {

    private static final Logger LOGGER = Logger.getLogger(GameWebSocketClient.class.getName());
    private final Map<String, Player> players = new HashMap<>();
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    public GameWebSocketClient(URI serverUri) {
        super(serverUri);
    }

    @Override
    public void onOpen(ServerHandshake handshakedata) {
        LOGGER.info("Connected to game server");
        send("JOIN|Player1");
    }

    @Override
    public void onMessage(String message) {
        LOGGER.info("Received: " + message);
        String[] parts = message.split("\\|");
        if (parts.length > 1) {
            String command = parts[0];
            String data = parts[1];
            switch (command) {
                case "JOIN":
                    synchronized (players) {
                        players.put(data, new Player(data));
                    }
                    LOGGER.info("Player joined: " + data);
                    break;
                case "LEAVE":
                    synchronized (players) {
                        players.remove(data);
                    }
                    LOGGER.info("Player left: " + data);
                    break;
                case "GAME_STATE":
                    // game state update logic
                    break;
                default:
                    LOGGER.warning("Unknown command: " + command);
            }
        }
    }

    @Override
    public void onClose(int code, String reason, boolean remote) {
        LOGGER.info("Disconnected from game server");
        // reconnection logic here
        reconnect();
    }

    @Override
    public void onError(Exception ex) {
        LOGGER.severe("Error occurred: " + ex.getMessage());
        ex.printStackTrace();
        // error handling or reconnection logic here
        reconnect();
    }

    public void sendGameStateUpdate(String gameState) {
        send("GAME_STATE|" + gameState);
    }

    private void reconnect() {
        // reconnection logic here
        LOGGER.info("Attempting to reconnect...");
        try {
            this.reconnectBlocking();
        } catch (InterruptedException e) {
            LOGGER.severe("Reconnection attempt failed: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        try {
            URI serverUri = new URI("ws://your-game-server.com");
            GameWebSocketClient client = new GameWebSocketClient(serverUri);
            client.connect();

            ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
            scheduler.scheduleAtFixedRate(() -> {
                client.sendGameStateUpdate("Game State Update");
            }, 0, 5, TimeUnit.SECONDS);

        } catch (URISyntaxException e) {
            LOGGER.severe("Invalid URI: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
