package model;

public class Korisnik {
    private int korisnik_id;
    private String username;
    private String sifra;
    private String ime;
    private String prezime;
    private String email;
    private int role_id;  
    private Role role;     

    public int getKorisnik_id() { return korisnik_id; }
    public void setKorisnik_id(int korisnik_id) { this.korisnik_id = korisnik_id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getSifra() { return sifra; }
    public void setSifra(String sifra) { this.sifra = sifra; }

    public String getIme() { return ime; }
    public void setIme(String ime) { this.ime = ime; }

    public String getPrezime() { return prezime; }
    public void setPrezime(String prezime) { this.prezime = prezime; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getRole_id() { return role_id; }
    public void setRole_id(int role_id) { this.role_id = role_id; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
}
