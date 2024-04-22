import com.surrealdb.connection.SurrealWebSocketConnection;
import com.surrealdb.driver.SyncSurrealDriver;
import java.util.List;
import java.util.Map;

public class DatabaseManager {
    private SurrealWebSocketConnection conn;
    private SyncSurrealDriver driver;
    private String namespace;
    private String databaseName;

    public DatabaseManager(String host, int port, boolean tls, String namespace, String databaseName) {
        this.namespace = namespace;
        this.databaseName = databaseName;
        conn = new SurrealWebSocketConnection(host, port, tls);
        conn.connect(5);
        driver = new SyncSurrealDriver(conn);
        driver.use(namespace, databaseName);
    }

    public void disconnect() {
        conn.disconnect();
    }

    public void saveEntity(String tableName, Object entity) {
        try {
            driver.create(tableName, entity);
        } catch (Exception e) {
            System.err.println("Error saving entity: " + e.getMessage());
        }
    }

    public List<Map<String, String>> updateEntity(String tableName, String id, Map<String, String> data) {
        try {
            return driver.update(id, data);
        } catch (Exception e) {
            System.err.println("Error updating entity: " + e.getMessage());
            return null;
        }
    }

    public List<Object> loadEntities(String tableName, Class<?> rowType) {
        try {
            return driver.select(tableName, rowType);
        } catch (Exception e) {
            System.err.println("Error loading entities: " + e.getMessage());
            return null;
        }
    }

    public void deleteEntity(String tableName, String id) {
        try {
            driver.delete(id);
        } catch (Exception e) {
            System.err.println("Error deleting entity: " + e.getMessage());
        }
    }

    public void saveGameState(String playerId, Object gameState) {
        saveEntity("game_state_" + playerId, gameState);
    }

    public Object loadGameState(String playerId, Class<?> rowType) {
        List<Object> gameStates = loadEntities("game_state_" + playerId, rowType);
        if (gameStates != null && !gameStates.isEmpty()) {
            return gameStates.get(0); // Assuming only one game state per player(we can add more)
        }
        return null;
    }

    public boolean signUp(String email, String password) {
        String command = String.format("SIGNUP %s %s", email, password);
        try {
            conn.send(command);
            // Placeholder for actual response handling
            return true; // Placeholder
        } catch (Exception e) {
            System.err.println("Error signing up: " + e.getMessage());
            return false;
        }
    }

    public boolean signIn(String email, String password) {
        String command = String.format("SIGNIN %s %s", email, password);
        try {
            conn.send(command);
            // Placeholder for actual response handling (remember to add later)
            return true;
          // Placeholder
        } catch (Exception e) {
            System.err.println("Error signing in: " + e.getMessage());
            return false;
        }
    }
}
