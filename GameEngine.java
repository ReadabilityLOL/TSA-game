import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.net.URI;
import java.util.ArrayList;

public class GameEngine implements KeyListener {
    private Game gameLoop;
    private InputHandler inputHandler;
    private PhysicsEngine physicsEngine;
    private Renderer renderer;
    private MapManager mapManager;
    private GameWebSocketClient networkManager;
    private Player playerManager;
    private boolean running;
    private MapGenerator mapper;

    public GameEngine() {
        initialize();
    }

    private void initialize() {
        gameLoop = new Game("localhost", 8080, false, "GameEngine");// the false is far the secure socket layer... tell
                                                                    // me if you want it to be true
        inputHandler = new InputHandler(new GameEngine());
        physicsEngine = new PhysicsEngine();
        renderer = new Renderer(new GameEngine());
        mapManager = new MapManager();
        networkManager = new GameWebSocketClient(new URI("www.WillNorthVDG.com"));// basically our url
        playerManager = new Player();
        running = false;

        Map map = mapper.generateMap();
        mapManager.loadMap("Map1", map);
        map = mapper.generateMap();
        mapManager.loadMap("Map2", map);
    }

    public void start() {
        running = true;
        gameLoop.start();
        networkManager.start();
    }

    public void update() {
        inputHandler.handleInput();
        physicsEngine.update();
        renderer.render();
        networkManager.update();
        playerManager.synchronizePlayers();
    }

    public void render() {
        renderer.render();
    }

    public void handleInput() {
        inputHandler.handleInput();
    }

    @Override
    public void keyPressed(KeyEvent e) {
        playerManager.getCurrentPlayer().move(e.getKeyCode());
    }

    @Override
    public void keyReleased(KeyEvent e) {
        // Handle key release events if needed
    }

    @Override
    public void keyTyped(KeyEvent e) {
        // Handle key typed events if needed
    }

    public static void main(String[] args) {
        GameEngine gameEngine = new GameEngine();
        gameEngine.start();
    }
}