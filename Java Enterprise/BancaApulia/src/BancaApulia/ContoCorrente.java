package BancaApulia;

import java.util.ArrayList;
import java.util.Scanner;

import Exception.DepositoMinException;
import Exception.PrelievoMaxException;
import Exception.PrelievoMinException;
import Exception.RicercaException;
import Exception.SaldoInsufException;

public class ContoCorrente {
    private String iban;
    private double saldo;
    private Correntista correntista;
    
    //costruttore
    
    public ContoCorrente(String iban, double saldo, Correntista correntista) {
        this.iban = iban;
        this.saldo = saldo;
        this.correntista = correntista;
    }
    
    public String getIban() {
        return iban;
    }
    
    public double getSaldo() {
        return saldo;
    }
    
    
    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }
    
    public Correntista getCorrentista() {
        return correntista;
    }
   
    
    
    public double prelievo() throws SaldoInsufException, PrelievoMinException, PrelievoMaxException {
        Scanner scan = new Scanner(System.in);
        System.out.println("Inserisci l'importo da prelevare:");
        double importoPrelevato = scan.nextDouble();
        
        if (importoPrelevato <= 0) {
            throw new PrelievoMinException();
        }
        
        if (importoPrelevato > saldo) {
            throw new SaldoInsufException();
        }
        
        if (importoPrelevato > 1000) {
        	throw new PrelievoMaxException();
        }
        
        saldo -= importoPrelevato;
        return saldo;
    }
    
    
    
    public double deposito() throws DepositoMinException {
        Scanner scan = new Scanner(System.in);
        System.out.println("Inserisci l'importo da depositare:");
        double importoDepositato = scan.nextDouble();
        
        if (importoDepositato <= 0) {
            throw new DepositoMinException();
        }
        
        saldo += importoDepositato;
        return saldo;
    }
    
    
 
    
    public void bonifico(double importo, ContoCorrente destinatario) throws PrelievoMinException, SaldoInsufException  {
        if (importo <= 0) {
            throw new PrelievoMinException();
        }
        
        if (this.getSaldo() < importo) {
            throw new SaldoInsufException();
        }
        
        this.setSaldo(this.getSaldo() - importo);
        destinatario.setSaldo(destinatario.getSaldo() + importo);
    }

    
    @Override
    public String toString() {
        return "NUMERO IBAN = " + iban + correntista.toString() + "\nSALDO = Euro " + saldo + "\n" ;
    }
}
