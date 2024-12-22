package Exception;

public class SaldoInsufException extends Exception  {
	public SaldoInsufException() {
		super ("Saldo non sufficiente per effettuare il prelievo.");
	}
}
