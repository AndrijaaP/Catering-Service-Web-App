package model;

import java.math.BigDecimal;

public class PorudzbinaStavka {
    private int stavka_id;
    private Porudzbina porudzbina;
    private Paket paket;
    private int kolicina;
    private BigDecimal cena_jedinicna;

    public PorudzbinaStavka() {}

    public int getStavka_id() { return stavka_id; }
    public void setStavka_id(int stavka_id) { this.stavka_id = stavka_id; }
    public Porudzbina getPorudzbina() { return porudzbina; }
    public void setPorudzbina(Porudzbina porudzbina) { this.porudzbina = porudzbina; }
    public Paket getPaket() { return paket; }
    public void setPaket(Paket paket) { this.paket = paket; }
    public int getKolicina() { return kolicina; }
    public void setKolicina(int kolicina) { this.kolicina = kolicina; }
    public BigDecimal getCena_jedinicna() { return cena_jedinicna; }
    public void setCena_jedinicna(BigDecimal cena_jedinicna) { this.cena_jedinicna = cena_jedinicna; }
}