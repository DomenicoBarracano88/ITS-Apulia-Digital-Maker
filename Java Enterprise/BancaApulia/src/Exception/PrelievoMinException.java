package Exception;

public class PrelievoMinException extends Exception {
	public PrelievoMinException() {
        super("L'importo del prelievo deve essere maggiore di zero.");
    }
}
