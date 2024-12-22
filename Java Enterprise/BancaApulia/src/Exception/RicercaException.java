package Exception;

public class RicercaException extends Exception  {
	public RicercaException() {
		super("ID non trovato. Inserisci un ID valido.");
	}
}
