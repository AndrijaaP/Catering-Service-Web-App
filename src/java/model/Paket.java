package model;

import java.math.BigDecimal;

public class Paket {
    private int paket_id;
    private String ime_paketa;
    private Kategorija kategorija;
    private String opis_paketa;
    private BigDecimal iznos;
    private int broj_osoba;

    public Paket() {}
    public Paket(int paket_id, String ime_paketa, Kategorija kategorija, String opis_paketa, BigDecimal iznos, int broj_osoba) {
        this.paket_id = paket_id;
        this.ime_paketa = ime_paketa;
        this.kategorija = kategorija;
        this.opis_paketa = opis_paketa;
        this.iznos = iznos;
        this.broj_osoba = broj_osoba;
    }

    public int getPaket_id() { return paket_id; }
    public void setPaket_id(int paket_id) { this.paket_id = paket_id; }
    public String getIme_paketa() { return ime_paketa; }
    public void setIme_paketa(String ime_paketa) { this.ime_paketa = ime_paketa; }
    public Kategorija getKategorija() { return kategorija; }
    public void setKategorija(Kategorija kategorija) { this.kategorija = kategorija; }
    public String getOpis_paketa() { return opis_paketa; }
    public void setOpis_paketa(String opis_paketa) { this.opis_paketa = opis_paketa; }
    public BigDecimal getIznos() { return iznos; }
    public void setIznos(BigDecimal iznos) { this.iznos = iznos; }
    public int getBroj_osoba() { return broj_osoba; }
    public void setBroj_osoba(int broj_osoba) { this.broj_osoba = broj_osoba; }
}