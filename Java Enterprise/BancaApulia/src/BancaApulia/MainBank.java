package BancaApulia;

import java.util.ArrayList;
import java.util.Scanner;

import Exception.DepositoMinException;
import Exception.PrelievoMaxException;
import Exception.PrelievoMinException;
import Exception.RicercaException;
import Exception.SaldoInsufException;

public class MainBank {
    public static void main(String[] args) {
        ArrayList<ContoCorrente> listaConti = new ArrayList<>();
        
        Correntista c1 = new Correntista("Giuseppe", "Bianconi", "17/08/1988", "BRRDNC88M17A662J");
        Correntista c2 = new Correntista("Antonio", "Campanale", "14/10/1995", "ANTCMP95M14A662J");
        
        ContoCorrente conto1 = new ContoCorrente("12345", 300, c1);
        ContoCorrente conto2 = new ContoCorrente("67890", 10000, c2);
        
        ContoCorrenteFido conto1Fido = new ContoCorrenteFido(conto1.getIban(), conto1.getSaldo(), conto1.getCorrentista(), 500);
        
        listaConti.add(conto1Fido);
        listaConti.add(conto2);
        
        Scanner scan = new Scanner(System.in);
        
        int scelta;
        
        do {
            System.out.println("MENU");
            System.out.println("1. Prelievo");
            System.out.println("2. Deposito");
            System.out.println("3. Bonifico");
            System.out.println("4. Stampa Conti");
            System.out.println("0. Esci");
            
            scelta = scan.nextInt();
            
            switch (scelta) {
                case 1:
                    try {
                        System.out.println("Effettua il prelievo");
                        System.out.println("Inserisci l'IBAN del conto:");
                        String ibanRicerca = scan.next();
                        ContoCorrente contoPrelievo = MainBank.trovaContoPerIBAN(ibanRicerca, listaConti);
                        System.out.println("COGNOME: " + contoPrelievo.getCorrentista().getCognome() + " SALDO DISPONIBILE: " + contoPrelievo.getSaldo());
                        double nuovoSaldo = contoPrelievo.prelievo();
                        contoPrelievo.setSaldo(nuovoSaldo);
                        System.out.println("Operazione Effettuata");
                        System.out.println("Nuovo saldo disponibile: " + nuovoSaldo);
                    } catch (PrelievoMaxException | RicercaException | SaldoInsufException | PrelievoMinException e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                    
                
                case 2:
                    try {
                        System.out.println("Effettua deposito:");
                        System.out.println("Inserisci l'IBAN del conto:");
                        String ibanRicerca = scan.next();
                        ContoCorrente contoDeposito = MainBank.trovaContoPerIBAN(ibanRicerca, listaConti);
                        System.out.println("COGNOME: " + contoDeposito.getCorrentista().getCognome() + " SALDO DISPONIBILE: " + contoDeposito.getSaldo());
                        double nuovoSaldo = contoDeposito.deposito();
                        contoDeposito.setSaldo(nuovoSaldo);
                        System.out.println("Nuovo saldo: " + nuovoSaldo);
                    } catch (RicercaException | DepositoMinException e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                
                
                case 3:
                    try {
                        System.out.println("Bonifico:");
                                        
                        System.out.println("Inserisci l'IBAN del conto mittente:");
                        String ibanMittente = scan.next();
                        ContoCorrente contoMittente = MainBank.trovaContoPerIBAN(ibanMittente, listaConti);
                                        
                        System.out.println("Inserisci l'IBAN del destinatario:");
                        String ibanDestinatario = scan.next();
                        ContoCorrente contoDestinatario = MainBank.trovaContoPerIBAN(ibanDestinatario, listaConti);
                                        
                        System.out.println("Inserisci l'importo del bonifico:");
                        double importoBonifico = scan.nextDouble();
                                        
                        contoMittente.bonifico(importoBonifico, contoDestinatario);
                        
                        System.out.println("Bonifico effettuato con successo.");
                        System.out.println(contoMittente.toString());
                        
                    } catch (RicercaException | PrelievoMinException | SaldoInsufException e) {
                        System.out.println(e.getMessage());
                    }
                    break;
                    
                    
                case 4:
                    try {
                        System.out.println("Stampa informazioni:");
                        System.out.println("Inserisci l'IBAN del conto:");
                        String ibanRicerca = scan.next();
                        ContoCorrente contoStampa = MainBank.trovaContoPerIBAN(ibanRicerca, listaConti);
                        System.out.println(contoStampa.toString() );
                    } catch (RicercaException e) {
                        System.out.println(e.getMessage());
                    }
                    break;


                
                case 0:
                    System.out.println("Uscita");
                    break;
                
                default:
                    System.out.println("Scelta non valida. Riprova.");
            }
        } while (scelta != 0);
        
        scan.close();
        
    }
    
    
    public static ContoCorrente trovaContoPerIBAN(String iban, ArrayList<ContoCorrente> listaConti) throws RicercaException {
        for (int i = 0; i < listaConti.size(); i++) {
            ContoCorrente conto = listaConti.get(i);
            if (conto.getIban().equals(iban)) {
                return conto;
            }
        }
        throw new RicercaException();
    }

}
