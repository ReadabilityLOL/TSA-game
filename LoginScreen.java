import java.util.Scanner;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import org.mindrot.jbcrypt.BCrypt;

public class LoginScreen {
    private DatabaseManager dbManager;
    private ExecutorService executorService;

    public LoginScreen(DatabaseManager dbManager) {
        this.dbManager = dbManager;
        this.executorService = Executors.newSingleThreadExecutor();
    }

    public void show() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter your email:");
        String email = scanner.nextLine();
        System.out.println("Enter your password:");
        String password = scanner.nextLine();

        // Validate user input
        if (!validateInput(email, password)) {
            System.out.println("Invalid email or password format.");
            return;
        }

        // Hash the password for security
        String hashedPassword = hashPassword(password);

        Future<Boolean> loginFuture = executorService.submit(() -> dbManager.signIn(email, hashedPassword));

        try {
            boolean success = loginFuture.get(5, TimeUnit.SECONDS); // Simulate async login with a timeout
            if (success) {
                proceedToGame();
            } else {
                System.out.println("Login failed. Please check your email and password.");
            }
        } catch (Exception e) {
            System.out.println("An error occurred during login. Please try again later.");
        } finally {
            executorService.shutdown();
        }
    }

    private String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    private boolean validateInput(String email, String password) {
        return email.contains("@") && password.length() >= 8;
    }

    private void proceedToGame() {
        System.out.println("Welcome to the fantasy adventure game! Your session has been created.");
        // add logic to connect to the game server and start the game
    }
}
