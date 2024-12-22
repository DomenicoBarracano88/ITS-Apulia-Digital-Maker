package ThreadNumeri;

public class SyncStack {
	
	private static final int CAPACITA = 10;
	private int[] stackArray = new int[CAPACITA];
	private int index = 0;
	
	public synchronized void push (int numRandom) {
		while (index == CAPACITA) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		stackArray[index++] = numRandom;
		notifyAll();
	}
	
	
	public synchronized int pop() {
		while (index == 0) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		int numRandom = stackArray[--index];
		notifyAll();
		return numRandom;
	}

}
