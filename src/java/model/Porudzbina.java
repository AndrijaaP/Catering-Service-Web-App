package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Porudzbina {
    private int porudzbina_id;
    private Korisnik korisnik;
    private String adresa_isporuke;
    private String kontakt_telefon;
    private String napomena;
    private StatusPorudzbine status;
    private Korisnik menadzer;
    private BigDecimal ukupni_iznos;
    private List<PorudzbinaStavka> stavke;

    public enum StatusPorudzbine {
        KREIRANA, U_PRIPREMI, OTKAZANA, ISPORUCENA
    }

    public int getPorudzbina_id() { return porudzbina_id; }
    public void setPorudzbina_id(int porudzbina_id) { this.porudzbina_id = porudzbina_id; }
    public Korisnik getKorisnik() { return korisnik; }
    public void setKorisnik(Korisnik korisnik) { this.korisnik = korisnik; }
    public String getAdresa_isporuke() { return adresa_isporuke; }
    public void setAdresa_isporuke(String adresa_isporuke) { this.adresa_isporuke = adresa_isporuke; }
    public String getKontakt_telefon() { return kontakt_telefon; }
    public void setKontakt_telefon(String kontakt_telefon) { this.kontakt_telefon = kontakt_telefon; }
    public String getNapomena() { return napomena; }
    public void setNapomena(String napomena) { this.napomena = napomena; }
    public StatusPorudzbine getStatus() { return status; }
    public void setStatus(StatusPorudzbine status) { this.status = status; }
    public Korisnik getMenadzer() { return menadzer; }
    public void setMenadzer(Korisnik menadzer) { this.menadzer = menadzer; }
    public BigDecimal getUkupni_iznos() { return ukupni_iznos; }
    public void setUkupni_iznos(BigDecimal ukupni_iznos) { this.ukupni_iznos = ukupni_iznos; }
    public List<PorudzbinaStavka> getStavke() { return stavke; }
    public void setStavke(List<PorudzbinaStavka> stavke) { this.stavke = stavke; }
}