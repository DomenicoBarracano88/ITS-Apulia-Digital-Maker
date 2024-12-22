package BancaApulia;

public class Correntista {
    private String nome, cognome, dataDiNascita, codiceFiscale;
    
    public Correntista(String nome, String cognome, String dataDiNascita, String codiceFiscale) {
        this.nome = nome;
        this.cognome = cognome;
        this.dataDiNascita = dataDiNascita;
        this.codiceFiscale = codiceFiscale;
    }
    
    public String getNome() {
        return nome;
    }
    
    public String getCognome() {
        return cognome;
    }
    
    public String getDataDiNascita() {
        return dataDiNascita;
    }
    
    public String getCodiceFiscale() {
        return codiceFiscale;
    }
    
    @Override
    public String toString() {
        return "\nNOME = " + nome + "\nCOGNOME = " + cognome + "\nDATA DI NASCITA = " + dataDiNascita
                + "\nCODICE FISCALE = " + codiceFiscale + " ";
    }
}
