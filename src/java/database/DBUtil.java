package database;

import model.*;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DBUtil {

    public static Kategorija getKategorijaById(int id) throws Exception {
        String sql = "SELECT * FROM kategorija WHERE kategorija_id = ?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Kategorija(rs.getInt("kategorija_id"), rs.getString("ime_kategorije"));
                }
            }
        }
        return null;
    }

    public static Kategorija getKategorijaByImeKategorije(String imeKategorije) throws Exception {
        String sql = "SELECT * FROM kategorija WHERE ime_kategorije = ?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, imeKategorije);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Kategorija(rs.getInt("kategorija_id"), rs.getString("ime_kategorije"));
                }
            }
        }
        return null;
    }

    public static List<Kategorija> getAllKategorije() throws Exception {
        List<Kategorija> list = new ArrayList<>();
        String sql = "SELECT * FROM kategorija ORDER BY ime_kategorije";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Kategorija(rs.getInt("kategorija_id"), rs.getString("ime_kategorije")));
            }
        }
        return list;
    }

    public static void insertPaket(Paket p) throws Exception {
        String sql = "INSERT INTO paket (ime_paketa, kategorija_id, opis_paketa, iznos, broj_osoba) VALUES (?,?,?,?,?)";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getIme_paketa());
            ps.setInt(2, p.getKategorija().getKategorija_id());
            ps.setString(3, p.getOpis_paketa());
            ps.setBigDecimal(4, p.getIznos());
            ps.setInt(5, p.getBroj_osoba());
            ps.executeUpdate();
        }
    }

    public static void updatePaket(Paket p) throws Exception {
        String sql = "UPDATE paket SET ime_paketa=?, kategorija_id=?, opis_paketa=?, iznos=?, broj_osoba=? WHERE paket_id=?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getIme_paketa());
            ps.setInt(2, p.getKategorija().getKategorija_id());
            ps.setString(3, p.getOpis_paketa());
            ps.setBigDecimal(4, p.getIznos());
            ps.setInt(5, p.getBroj_osoba());
            ps.setInt(6, p.getPaket_id());
            ps.executeUpdate();
        }
    }

    public static void deletePaket(int id) throws Exception {
        String sql = "DELETE FROM paket WHERE paket_id=?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps  .setInt(1, id);
            ps.executeUpdate();
        }
    }

    public static Paket getPaketById(int id) throws Exception {
        String sql = "SELECT p.*, k.kategorija_id, k.ime_kategorije AS kat FROM paket p JOIN kategorija k ON p.kategorija_id = k.kategorija_id WHERE p.paket_id = ?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Kategorija kat = new Kategorija(rs.getInt("kategorija_id"), rs.getString("kat"));
                    Paket p = new Paket();
                    p.setPaket_id(rs.getInt("paket_id"));
                    p.setIme_paketa(rs.getString("ime_paketa"));
                    p.setKategorija(kat);
                    p.setOpis_paketa(rs.getString("opis_paketa"));
                    p.setIznos(rs.getBigDecimal("iznos"));
                    p.setBroj_osoba(rs.getInt("broj_osoba"));
                    return p;
                }
            }
        }
        return null;
    }

    public static List<Paket> getAllPaketi() throws Exception {
        List<Paket> list = new ArrayList<>();
        String sql = "SELECT p.*, k.kategorija_id, k.ime_kategorije AS kat FROM paket p JOIN kategorija k ON p.kategorija_id = k.kategorija_id ORDER BY p.ime_paketa";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Kategorija kat = new Kategorija(rs.getInt("kategorija_id"), rs.getString("kat"));
                Paket p = new Paket();
                p.setPaket_id(rs.getInt("paket_id"));
                p.setIme_paketa(rs.getString("ime_paketa"));
                p.setKategorija(kat);
                p.setOpis_paketa(rs.getString("opis_paketa"));
                p.setIznos(rs.getBigDecimal("iznos"));
                p.setBroj_osoba(rs.getInt("broj_osoba"));
                list.add(p);
            }
        }
        return list;
    }

    public static Paket getPaketByImePaketa(String imePaketa) throws Exception {
        String sql = "SELECT p.*, k.kategorija_id, k.ime_kategorije AS kat FROM paket p JOIN kategorija k ON p.kategorija_id = k.kategorija_id WHERE p.ime_paketa = ?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, imePaketa);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Kategorija kat = new Kategorija(rs.getInt("kategorija_id"), rs.getString("kat"));
                    Paket p = new Paket();
                    p.setPaket_id(rs.getInt("paket_id"));
                    p.setIme_paketa(rs.getString("ime_paketa"));
                    p.setKategorija(kat);
                    p.setOpis_paketa(rs.getString("opis_paketa"));
                    p.setIznos(rs.getBigDecimal("iznos"));
                    p.setBroj_osoba(rs.getInt("broj_osoba"));
                    return p;
                }
            }
        }
        return null;
    }

   public static List<Paket> getPaketiByKategorija(int kategorijaId) throws Exception {
    List<Paket> list = new ArrayList<>();
    String sql = "SELECT p.*, k.kategorija_id, k.ime_kategorije AS kat FROM paket p JOIN kategorija k ON p.kategorija_id = k.kategorija_id WHERE p.kategorija_id = ? ORDER BY p.ime_paketa";
    try (Connection conn = DBKonekcija.getKonekcija();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, kategorijaId);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Kategorija kat = new Kategorija(rs.getInt("kategorija_id"), rs.getString("kat"));
                Paket p = new Paket();
                p.setPaket_id(rs.getInt("paket_id"));
                p.setIme_paketa(rs.getString("ime_paketa"));
                p.setKategorija(kat);
                p.setOpis_paketa(rs.getString("opis_paketa"));
                p.setIznos(rs.getBigDecimal("iznos"));
                p.setBroj_osoba(rs.getInt("broj_osoba"));
                list.add(p);
            }
        }
    }
    return list;
    }

    public static Korisnik getKorisnikByUsername(String username) throws Exception {
        String sql = "SELECT u.*, r.role_id, r.naziv_role FROM korisnik u JOIN role r ON u.role_id = r.role_id WHERE u.username = ?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("role_id"), rs.getString("naziv_role"));
                    Korisnik k = new Korisnik();
                    k.setKorisnik_id(rs.getInt("korisnik_id"));
                    k.setUsername(rs.getString("username"));
                    k.setSifra(rs.getString("sifra"));
                    k.setIme(rs.getString("ime"));
                    k.setPrezime(rs.getString("prezime"));
                    k.setEmail(rs.getString("email"));
                    k.setRole(role);
                    return k;
                }
            }
        }
        return null;
    }

    public static Korisnik getKorisnikByEmail(String email) throws Exception {
        String sql = "SELECT u.*, r.role_id, r.naziv_role FROM korisnik u JOIN role r ON u.role_id = r.role_id WHERE u.email = ?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("role_id"), rs.getString("naziv_role"));
                    Korisnik k = new Korisnik();
                    k.setKorisnik_id(rs.getInt("korisnik_id"));
                    k.setUsername(rs.getString("username"));
                    k.setSifra(rs.getString("sifra"));
                    k.setIme(rs.getString("ime"));
                    k.setPrezime(rs.getString("prezime"));
                    k.setEmail(rs.getString("email"));
                    k.setRole(role);
                    return k;
                }
            }
        }
        return null;
    }

    public static void insertKorisnik(Korisnik k) throws Exception {
        String sql = "INSERT INTO korisnik (username, sifra, ime, prezime, email, role_id) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, k.getUsername());
            ps.setString(2, k.getSifra());
            ps.setString(3, k.getIme());
            ps.setString(4, k.getPrezime());
            ps.setString(5, k.getEmail());
            ps.setInt(6, k.getRole().getRole_id());
            ps.executeUpdate();
        }
    }

    public static List<Korisnik> getAllKorisnici() throws Exception {
        String sql = "SELECT u.*, r.role_id, r.naziv_role FROM korisnik u JOIN role r ON u.role_id = r.role_id";
        List<Korisnik> lista = new ArrayList<>();
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Role role = new Role(rs.getInt("role_id"), rs.getString("naziv_role"));
                Korisnik k = new Korisnik();
                k.setKorisnik_id(rs.getInt("korisnik_id"));
                k.setUsername(rs.getString("username"));
                k.setSifra(rs.getString("sifra"));
                k.setIme(rs.getString("ime"));
                k.setPrezime(rs.getString("prezime"));
                k.setEmail(rs.getString("email"));
                k.setRole(role);
                lista.add(k);
            }
        }
        return lista;
    }

    public static void updateKorisnik(Korisnik k) throws Exception {
        String sql = "UPDATE korisnik SET username=?, sifra=?, ime=?, prezime=?, email=?, role_id=? WHERE korisnik_id=?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, k.getUsername());
            ps.setString(2, k.getSifra());
            ps.setString(3, k.getIme());
            ps.setString(4, k.getPrezime());
            ps.setString(5, k.getEmail());
            ps.setInt(6, k.getRole().getRole_id());
            ps.setInt(7, k.getKorisnik_id());
            ps.executeUpdate();
        }
    }

    public static Korisnik getKorisnikById(int id) throws Exception {
        String sql = "SELECT u.*, r.role_id, r.naziv_role FROM korisnik u JOIN role r ON u.role_id = r.role_id WHERE u.korisnik_id = ?";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("role_id"), rs.getString("naziv_role"));
                    Korisnik k = new Korisnik();
                    k.setKorisnik_id(rs.getInt("korisnik_id"));
                    k.setUsername(rs.getString("username"));
                    k.setSifra(rs.getString("sifra"));
                    k.setIme(rs.getString("ime"));
                    k.setPrezime(rs.getString("prezime"));
                    k.setEmail(rs.getString("email"));
                    k.setRole(role);
                    return k;
                }
            }
        }
        return null;
    }

    public static int insertPorudzbina(String adresaIsporuke, String kontaktTelefon, String napomena, BigDecimal ukupniIznos, Integer korisnikId) throws Exception {
        String sql = "INSERT INTO porudzbina (korisnik_id, datum_vreme, adresa_isporuke, kontakt_telefon, napomena, status, ukupni_iznos) VALUES (?,?,?,?,?,'kreirana',?)";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            if (korisnikId == null) ps.setNull(1, Types.INTEGER);
            else ps.setInt(1, korisnikId);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(3, adresaIsporuke);
            ps.setString(4, kontaktTelefon);
            ps.setString(5, napomena);
            ps.setBigDecimal(6, ukupniIznos);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
                else throw new SQLException("Nije moguće dobiti ID porudžbine.");
            }
        }
    }

    public static void insertPorudzbinaStavka(int porudzbinaId, int paketId, int kolicina, BigDecimal cenaJedinicna) throws Exception {
        String sql = "INSERT INTO porudzbina_stavka (porudzbina_id, paket_id, kolicina, cena_jedinicna) VALUES (?,?,?,?)";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, porudzbinaId);
            ps.setInt(2, paketId);
            ps.setInt(3, kolicina);
            ps.setBigDecimal(4, cenaJedinicna);
            ps.executeUpdate();
        }
    }

    public static int kreirajPorudzbinu(Integer korisnikId, int paketId, BigDecimal ukupniIznos) throws Exception {
        Connection conn = null;
        PreparedStatement psPorudzbina = null;
        PreparedStatement psStavka = null;
        ResultSet rsKeys = null;
        try {
            conn = DBKonekcija.getKonekcija();
            conn.setAutoCommit(false);
            String sqlPor = "INSERT INTO porudzbina (korisnik_id, datum_vreme, status, ukupni_iznos) VALUES (?,NOW(),'kreirana',?)";
            psPorudzbina = conn.prepareStatement(sqlPor, Statement.RETURN_GENERATED_KEYS);
            if (korisnikId == null) psPorudzbina.setNull(1, Types.INTEGER);
            else psPorudzbina.setInt(1, korisnikId);
            psPorudzbina.setBigDecimal(2, ukupniIznos);
            psPorudzbina.executeUpdate();
            rsKeys = psPorudzbina.getGeneratedKeys();
            if (!rsKeys.next()) throw new SQLException("Nije dobijen ID porudžbine.");
            int porudzbinaId = rsKeys.getInt(1);
            String sqlSt = "INSERT INTO porudzbina_stavka (porudzbina_id, paket_id, kolicina, cena_jedinicna) VALUES (?,?,1,?)";
            psStavka = conn.prepareStatement(sqlSt);
            psStavka.setInt(1, porudzbinaId);
            psStavka.setInt(2, paketId);
            psStavka.setBigDecimal(3, ukupniIznos);
            psStavka.executeUpdate();
            conn.commit();
            return porudzbinaId;
        } catch (Exception ex) {
            if (conn != null) conn.rollback();
            throw ex;
        } finally {
            if (rsKeys != null) rsKeys.close();
            if (psStavka != null) psStavka.close();
            if (psPorudzbina != null) psPorudzbina.close();
            if (conn != null) conn.setAutoCommit(true);
        }
    }

    public static void updatePorudzbinaUkupno(int porudzbinaId, BigDecimal ukupniIznos) throws Exception {
        String sql = "UPDATE porudzbina SET ukupni_iznos = ? WHERE porudzbina_id = ?";
        try (Connection c = DBKonekcija.getKonekcija();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBigDecimal(1, ukupniIznos);
            ps.setInt(2, porudzbinaId);
            ps.executeUpdate();
        }
    }

    public static List<Porudzbina> getPorudzbineByUser(int korisnikId) throws Exception {
        List<Porudzbina> lista = new ArrayList<>();
        String sql = "SELECT * FROM porudzbina WHERE korisnik_id = ? ORDER BY datum_vreme DESC";
        try (Connection conn = DBKonekcija.getKonekcija();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, korisnikId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Porudzbina p = new Porudzbina();
                    p.setPorudzbina_id(rs.getInt("porudzbina_id"));
                    p.setKorisnik(getKorisnikById(rs.getInt("korisnik_id")));
                    p.setAdresa_isporuke(rs.getString("adresa_isporuke"));
                    p.setKontakt_telefon(rs.getString("kontakt_telefon"));
                    p.setNapomena(rs.getString("napomena"));
                    p.setStatus(Porudzbina.StatusPorudzbine.valueOf(rs.getString("status")));
                    p.setMenadzer((Integer) rs.getObject("menadzer_id") != null ? getKorisnikById(rs.getInt("menadzer_id")) : null);
                    p.setUkupni_iznos(rs.getBigDecimal("ukupni_iznos"));
                    lista.add(p);
                }
            }
        }
        return lista;
    }

    public static void updatePorudzbinaStatus(int id, String status, int menadzerId) throws Exception {
        String sql = "UPDATE porudzbina SET status = ?, menadzer_id = ? WHERE porudzbina_id = ?";
        try (Connection c = DBKonekcija.getKonekcija();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, menadzerId);
            ps.setInt(3, id);
            ps.executeUpdate();
        }
    }

    public static void deletePorudzbina(int id) throws Exception {
        String sql = "DELETE FROM porudzbina WHERE porudzbina_id = ?";
        try (Connection c = DBKonekcija.getKonekcija();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
    
    public static List<Porudzbina> getAllPorudzbine() throws Exception {
    List<Porudzbina> lista = new ArrayList<>();
    String sql = "SELECT " +
                 "p.porudzbina_id, " +
                 "p.adresa_isporuke, " +
                 "p.kontakt_telefon, " +
                 "p.napomena, " +
                 "p.ukupni_iznos, " +
                 "p.datum_vreme, " +
                 "p.status, " +
                 "p.korisnik_id, " +
                 "u.username, " +
                 "u.ime, " +
                 "u.prezime, " +
                 "u.email, " +
                 "u.sifra, " +
                 "u.role_id, " +
                 "r.naziv_role " +
                 "FROM porudzbina p " +
                 "LEFT JOIN korisnik u ON p.korisnik_id = u.korisnik_id " +
                 "LEFT JOIN role r ON u.role_id = r.role_id " +
                 "ORDER BY p.datum_vreme DESC";

    try (Connection conn = DBKonekcija.getKonekcija();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Korisnik korisnik = null;
            if (rs.getInt("korisnik_id") != 0) { // Provera za null korisnik_id
                Role role = new Role(rs.getInt("role_id"), rs.getString("naziv_role"));
                korisnik = new Korisnik();
                korisnik.setKorisnik_id(rs.getInt("korisnik_id"));
                korisnik.setUsername(rs.getString("username"));
                korisnik.setIme(rs.getString("ime"));
                korisnik.setPrezime(rs.getString("prezime"));
                korisnik.setEmail(rs.getString("email"));
                korisnik.setSifra(rs.getString("sifra"));
                korisnik.setRole(role);
            }
            
            Porudzbina p = new Porudzbina();
            p.setPorudzbina_id(rs.getInt("porudzbina_id"));
            p.setAdresa_isporuke(rs.getString("adresa_isporuke"));
            p.setKontakt_telefon(rs.getString("kontakt_telefon"));
            p.setNapomena(rs.getString("napomena"));
            p.setUkupni_iznos(rs.getBigDecimal("ukupni_iznos"));
            p.setStatus(Porudzbina.StatusPorudzbine.valueOf(rs.getString("status").toUpperCase()));
            p.setKorisnik(korisnik);

            lista.add(p);
        }
    }
    return lista;
    
 
}
       public static boolean obrisiKorisnika(int korisnikId) throws Exception {
    String sql = "DELETE FROM korisnik WHERE korisnik_id = ?";
    try (Connection conn = DBKonekcija.getKonekcija();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, korisnikId);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    }
}
       public static boolean daLiKorisnikImaPorudzbine(int korisnikId) throws Exception {
    String sql = "SELECT COUNT(*) FROM porudzbina WHERE korisnik_id = ?";
    try (Connection conn = DBKonekcija.getKonekcija();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, korisnikId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    }
    return false;
}
}