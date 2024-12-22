package ThreadNumeri;

public class CancellaNumeri implements Runnable{
	
	private SyncStack stack;
	
	public CancellaNumeri(SyncStack stack) {
		this.stack = stack;
	}

	@Override
	public void run() {
		while(true) {
			int numRandom = stack.pop();
			System.out.println("Numero cancellato " + numRandom);
			try {
				Thread.sleep(1000);
				
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}

}