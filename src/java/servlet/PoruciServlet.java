package servlet;

import database.DBUtil;
import model.Korisnik;
import model.Paket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "PoruciServlet", urlPatterns = {"/PoruciServlet"})
public class PoruciServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Korisnik korisnik = (Korisnik) req.getSession().getAttribute("ulogovaniKorisnik");
        if (korisnik == null) {
            resp.sendRedirect("login.jsp?next=PoruciServlet");
            return;
        }
        try {
            req.setAttribute("listaPaketi", DBUtil.getAllPaketi());
        } catch (Exception ex) {
            req.setAttribute("greska", "Greška pri čitanju ponude: " + ex.getMessage());
        }
        req.getRequestDispatcher("porudzbina.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Korisnik korisnik = (Korisnik) req.getSession().getAttribute("ulogovaniKorisnik");
        if (korisnik == null) {
            resp.sendRedirect("login.jsp?next=PoruciServlet");
            return;
        }

        String adresa = req.getParameter("adresa_isporuke");
        String telefon = req.getParameter("kontakt_telefon");
        String napomena = req.getParameter("napomena");

        Map<Integer, Integer> paketKol = new HashMap<>();
        for (String p : req.getParameterMap().keySet()) {
            if (p.startsWith("paket_")) {
                int id = Integer.parseInt(p.substring(6));
                int qty = Integer.parseInt(req.getParameter(p));
                if (qty > 0) paketKol.put(id, qty);
            }
        }
        if (paketKol.isEmpty()) {
            req.setAttribute("greskaStavke", "Morate izabrati bar jedan paket.");
            doGet(req, resp);
            return;
        }

        try {
            Map<Integer, Paket> mapaPaketi = new HashMap<>();
            DBUtil.getAllPaketi().forEach(p -> mapaPaketi.put(p.getPaket_id(), p));

            BigDecimal ukupno = BigDecimal.ZERO;

            int porudzbinaId = DBUtil.insertPorudzbina(
                    adresa,
                    telefon,
                    napomena,
                    BigDecimal.ZERO,
                    korisnik.getKorisnik_id()
            );

            for (Map.Entry<Integer, Integer> e : paketKol.entrySet()) {
                Paket p = mapaPaketi.get(e.getKey());
                int k = e.getValue();
                BigDecimal iznos = p.getIznos().multiply(BigDecimal.valueOf(k));
                DBUtil.insertPorudzbinaStavka(porudzbinaId, p.getPaket_id(), k, iznos);
                ukupno = ukupno.add(iznos);
            }

            DBUtil.updatePorudzbinaUkupno(porudzbinaId, ukupno);

            req.setAttribute("porudzbinaId", porudzbinaId);
            req.setAttribute("ukupno", ukupno);
            req.getRequestDispatcher("uspesnoNaruceno.jsp").forward(req, resp);

        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("greska", "Greška pri obradi porudžbine: " + ex.getMessage());
            doGet(req, resp);
        }
    }
}