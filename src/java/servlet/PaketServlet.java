package servlet;

import database.DBUtil;
import model.Kategorija;
import model.Paket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "PaketServlet", urlPatterns = {"/PaketServlet"})
public class PaketServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String akcija = req.getParameter("akcija");

        try {
            if (akcija == null || "pregled".equals(akcija)) {
                String kategorijaId = req.getParameter("kategorijaId");
                int katId = (kategorijaId == null || kategorijaId.trim().isEmpty()) ? -1 : Integer.parseInt(kategorijaId);
                List<Paket> paketi = katId == -1 ? DBUtil.getAllPaketi() : DBUtil.getPaketiByKategorija(katId);
                req.setAttribute("paketi", paketi);
                req.setAttribute("izabraniKategorijaId", kategorijaId);
                req.getRequestDispatcher("paketi.jsp").forward(req, resp);
            } else if ("add".equals(akcija) || "unos".equals(akcija)) {
                req.getRequestDispatcher("dodajPaket.jsp").forward(req, resp);
            } else if ("edit".equals(akcija)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Paket p = DBUtil.getPaketById(id);
                
                req.setAttribute("paket", p);
                req.getRequestDispatcher("izmeniPaket.jsp").forward(req, resp);
            } else if ("delete".equals(akcija)) {
                int id = Integer.parseInt(req.getParameter("id"));
                DBUtil.deletePaket(id);
                resp.sendRedirect("PaketServlet?akcija=pregled");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("greska", "Greška: " + ex.getMessage());
            req.getRequestDispatcher("paketi.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String akcija = req.getParameter("akcija");

        switch (akcija) {
            case "insert": handleInsert(req, resp); break;
            case "update": handleUpdate(req, resp); break;
            default: resp.sendRedirect("PaketServlet?akcija=pregled");
        }
    }

    private void handleInsert(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!validate(req)) {
            req.getRequestDispatcher("dodajPaket.jsp").forward(req, resp);
            return;
        }
        try {
            Paket p = buildFromReq(req, 0);
            DBUtil.insertPaket(p);
            resp.sendRedirect("PaketServlet?akcija=pregled");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("greska", "Greška pri unosu: " + e.getMessage());
            req.getRequestDispatcher("dodajPaket.jsp").forward(req, resp);
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("paket_id"));
        if (!validate(req)) {
            try { req.setAttribute("paket", DBUtil.getPaketById(id)); } catch (Exception ignore) {}
            req.getRequestDispatcher("izmeniPaket.jsp").forward(req, resp);
            return;
        }
        try {
            Paket p = buildFromReq(req, id);
            DBUtil.updatePaket(p);
            resp.sendRedirect("PaketServlet?akcija=pregled");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("greska", "Greška pri izmeni: " + e.getMessage());
            try { req.setAttribute("paket", DBUtil.getPaketById(id)); } catch (Exception ignore) {}
            req.getRequestDispatcher("izmeniPaket.jsp").forward(req, resp);
        }
    }

    private Paket buildFromReq(HttpServletRequest r, int id) {
        Paket p = new Paket();
        p.setPaket_id(id);
        p.setIme_paketa(r.getParameter("ime_paketa"));
        p.setKategorija(new Kategorija(Integer.parseInt(r.getParameter("kategorija_id")), ""));
        p.setOpis_paketa(r.getParameter("opis_paketa"));
        p.setIznos(new BigDecimal(r.getParameter("iznos")));
        p.setBroj_osoba(Integer.parseInt(r.getParameter("broj_osoba")));
        return p;
    }

    private boolean validate(HttpServletRequest r) {
        String imePaketa = r.getParameter("ime_paketa");
        String kategorijaId = r.getParameter("kategorija_id");
        String opisPaketa = r.getParameter("opis_paketa");
        String iznos = r.getParameter("iznos");
        String brojOsoba = r.getParameter("broj_osoba");
        boolean ok = true;

        if (imePaketa == null || imePaketa.trim().isEmpty()) {
            r.setAttribute("greskaImePaketa", "Naziv paketa je obavezan");
            ok = false;
        }

        try {
            int katId = Integer.parseInt(kategorijaId);
            if (DBUtil.getKategorijaById(katId) == null) {
                r.setAttribute("greskaKategorija", "Nevalidna kategorija");
                ok = false;
            }
        } catch (Exception e) {
            r.setAttribute("greskaKategorija", "Kategorija je obavezna");
            ok = false;
        }

        if (opisPaketa == null || opisPaketa.trim().isEmpty()) {
            r.setAttribute("greskaOpis", "Opis je obavezan");
            ok = false;
        }

        try {
            if (new BigDecimal(iznos).compareTo(BigDecimal.ZERO) <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            r.setAttribute("greskaIznos", "Iznos mora biti veći od 0");
            ok = false;
        }

        try {
            if (Integer.parseInt(brojOsoba) <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            r.setAttribute("greskaBrojOsoba", "Broj osoba mora biti veći od 0");
            ok = false;
        }

        r.setAttribute("ime_paketa", imePaketa);
        r.setAttribute("kategorija_id", kategorijaId);
        r.setAttribute("opis_paketa", opisPaketa);
        r.setAttribute("iznos", iznos);
        r.setAttribute("broj_osoba", brojOsoba);
        return ok;
    }
}