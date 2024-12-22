package Exception;

public class DepositoMinException extends Exception {
    public DepositoMinException() {
        super("L'importo del deposito deve essere maggiore di zero.");
    }
}