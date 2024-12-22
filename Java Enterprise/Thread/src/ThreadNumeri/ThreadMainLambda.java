package ThreadNumeri;

import java.util.Random;

public class ThreadMainLambda {

	public static void main(String[] args) {

		Runnable runPari = () -> {

			
			for (int i = 0; i < 10; i++) {

				int numRandom;
				Random ran = new Random();
				numRandom = ran.nextInt(50) * 2;
				System.out.println("Esecuzione in corso. Numero pari : " + numRandom);
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}

			}

		};

		Runnable runDispari = () -> {

			for (int i = 0; i < 10; i++) {

				int numRandom;
				Random ran = new Random();
				numRandom = ran.nextInt(50) * 2 + 1;
				System.out.println("Esecuzione in corso. Numero dispari : " + numRandom);
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}

			}

		};

		Thread threadPari = new Thread(runPari);
		Thread threadDispari = new Thread(runDispari);

		threadPari.start();
		threadDispari.start();

	}

}
