package BancaApulia;

import java.util.Scanner;

import Exception.PrelievoMinException;
import Exception.SaldoInsufException;

public class ContoCorrenteFido extends ContoCorrente {
    
	private double fido;
    
    public ContoCorrenteFido(String iban, double saldo, Correntista correntista, double fido) {
        super(iban, saldo, correntista);
        this.fido = fido;
    }
    
    public double getFido() {
        return fido;
    }
    
    public void setFido(double fido) {
        this.fido = fido;
    }
    
    @Override
    public double prelievo() throws SaldoInsufException, PrelievoMinException {
        Scanner scan = new Scanner(System.in);
        System.out.println("Inserisci l'importo da prelevare:");
        double importoPrelevato = scan.nextDouble();
        
        if (importoPrelevato <= 0) {
            throw new PrelievoMinException();
        }
        
        double importoMassimo = getSaldo() + getFido();
        if (importoPrelevato > importoMassimo) {
            throw new SaldoInsufException();
        }
         
        setSaldo(getSaldo() - importoPrelevato);   
        return getSaldo();
    }
    
    @Override
    public void bonifico(double importo, ContoCorrente destinatario) throws PrelievoMinException, SaldoInsufException  {
        if (importo <= 0) {
            throw new PrelievoMinException();
        }
        
        if ((this.getSaldo() + fido) < importo) {
            throw new SaldoInsufException();
        }
        
        setSaldo(getSaldo() - importo);
        destinatario.setSaldo(destinatario.getSaldo() + importo);
    }

	
	public String toString() {
		return  "FIDO DISPONIBILE = " + fido + "\nNUMERO IBAN = " + getIban() + getCorrentista().toString() + "\nSALDO = Euro " + getSaldo() + "\n";
	}
	
	
}
