package Exception;

public class PrelievoMaxException extends Exception {
	public PrelievoMaxException() {
        super("Puoi prelevare massimo 1000 Euro per transazione");
    }
}
