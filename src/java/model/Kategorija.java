package model;

public class Kategorija {
    private int kategorija_id;
    private String ime_kategorije;

    public Kategorija() {}
    public Kategorija(int kategorija_id, String ime_kategorije) {
        this.kategorija_id = kategorija_id;
        this.ime_kategorije = ime_kategorije;
    }

    public int getKategorija_id() { return kategorija_id; }
    public void setKategorija_id(int kategorija_id) { this.kategorija_id = kategorija_id; }
    public String getIme_kategorije() { return ime_kategorije; }
    public void setIme_kategorije(String ime_kategorije) { this.ime_kategorije = ime_kategorije; }
}