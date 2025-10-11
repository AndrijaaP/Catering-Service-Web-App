package servlet;

import database.DBUtil;
import model.Korisnik;
import model.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RegistracijaServlet", urlPatterns = {"/RegistracijaServlet"})
public class RegistracijaServlet extends HttpServlet {

    private static final int DEFAULT_ROLE_ID = 3;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String ime = request.getParameter("ime");
        String prezime = request.getParameter("prezime");
        String email = request.getParameter("email");
        String sifra = request.getParameter("sifra");

        boolean err = false;

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("greskaUser", "Korisničko ime je obavezno.");
            err = true;
        }
        if (ime == null || ime.trim().isEmpty()) {
            request.setAttribute("greskaIme", "Ime je obavezno.");
            err = true;
        }
        if (prezime == null || prezime.trim().isEmpty()) {
            request.setAttribute("greskaPrezime", "Prezime je obavezno.");
            err = true;
        }
        if (email == null || !email.contains("@")) {
            request.setAttribute("greskaEmail", "Email nije validan.");
            err = true;
        }
        if (sifra == null || sifra.length() < 4) {
            request.setAttribute("greskaSifra", "Šifra mora imati ≥ 4 znaka.");
            err = true;
        }

        if (err) {
            request.setAttribute("usernameVrednost", username);
            request.setAttribute("imeVrednost", ime);
            request.setAttribute("prezimeVrednost", prezime);
            request.setAttribute("emailVrednost", email);
            request.getRequestDispatcher("registracija.jsp").forward(request, response);
            return;
        }

        try {
            Korisnik k = new Korisnik();
            k.setUsername(username);
            k.setIme(ime);
            k.setPrezime(prezime);
            k.setEmail(email);
            k.setSifra(sifra);
            k.setRole(new Role(DEFAULT_ROLE_ID, "KLIJENT"));

            DBUtil.insertKorisnik(k);

            HttpSession ses = request.getSession();
            ses.setAttribute("ulogovaniKorisnik", k);
            ses.setAttribute("korisnikId", k.getKorisnik_id());

            response.sendRedirect("index.jsp");

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("greska", "Greška prilikom registracije: " + ex.getMessage());
            request.getRequestDispatcher("registracija.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("registracija.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet za registraciju novog korisnika";
    }
}