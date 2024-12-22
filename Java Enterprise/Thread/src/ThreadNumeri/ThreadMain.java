package ThreadNumeri;

public class ThreadMain {
public static void main(String[] args) {
		
		SyncStack stack = new SyncStack();
		
		NumPari numPari = new NumPari(stack);
		NumDispari numDispari = new NumDispari(stack);
		CancellaNumeri cancNumeri = new CancellaNumeri(stack);
		
		Thread numPariThread = new Thread(numPari);
		Thread numDispariThread = new Thread(numDispari);
		Thread cancNumeriThread = new Thread(cancNumeri);
		
		numPariThread.start();
		numDispariThread.start();
		cancNumeriThread.start();

	}

}
