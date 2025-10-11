package servlet;

import database.DBUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Korisnik;
import model.Role;

@WebServlet(name = "DodajKorisnikaServlet", urlPatterns = {"/DodajKorisnikaServlet"})
public class DodajKorisnikaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Korisnik ulogovani = (Korisnik) (session != null ? session.getAttribute("ulogovaniKorisnik") : null);

        // Provera da li je korisnik admin
        if (ulogovani == null || ulogovani.getRole().getRole_id() != 1) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            // Prikupljanje podataka iz forme
            String username = request.getParameter("username");
            String sifra = request.getParameter("sifra");
            String ime = request.getParameter("ime");
            String prezime = request.getParameter("prezime");
            String email = request.getParameter("email");
            int roleId = Integer.parseInt(request.getParameter("role_id"));
            
            // Kreiranje Role objekta
            Role role = new Role();
            role.setRole_id(roleId);
            
            // Provera da li korisničko ime već postoji
            if (DBUtil.getKorisnikByUsername(username) != null) {
                request.setAttribute("greska", "Korisničko ime već postoji");
                request.getRequestDispatcher("dodaj-korisnika.jsp").forward(request, response);
                return;
            }
            
            // Provera da li email već postoji
            if (DBUtil.getKorisnikByEmail(email) != null) {
                request.setAttribute("greska", "Email adresa već postoji");
                request.getRequestDispatcher("dodaj-korisnika.jsp").forward(request, response);
                return;
            }
            
            // Kreiranje novog korisnika
            Korisnik noviKorisnik = new Korisnik();
            noviKorisnik.setUsername(username);
            noviKorisnik.setSifra(sifra);
            noviKorisnik.setIme(ime);
            noviKorisnik.setPrezime(prezime);
            noviKorisnik.setEmail(email);
            noviKorisnik.setRole(role);
            
            // Čuvanje korisnika u bazi
            DBUtil.insertKorisnik(noviKorisnik);
            
            session.setAttribute("poruka", "Korisnik uspešno dodat");
            response.sendRedirect("AdminPanelServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("greska", "Greška prilikom dodavanja korisnika: " + e.getMessage());
            request.getRequestDispatcher("dodaj-korisnika.jsp").forward(request, response);
        }
    }
}