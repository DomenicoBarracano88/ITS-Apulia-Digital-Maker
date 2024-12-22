package ThreadNumeri;

import java.util.Random;

public class NumDispari implements Runnable {

	private SyncStack stack;

	public NumDispari(SyncStack stack) {
		this.stack = stack;
	}

	@Override
	public void run() {

		for (int i = 0; i < 10; i++) {

			int numRandom;
			Random ran = new Random();
			numRandom = ran.nextInt(50) * 2 + 1;
			System.out.println("Esecuzione in corso. Numero dispari : " + numRandom);
			stack.push(numRandom);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}

		}

	}
}
