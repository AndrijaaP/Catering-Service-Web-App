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

@WebServlet(name = "ObrisiKorisnikaServlet", urlPatterns = {"/ObrisiKorisnikaServlet"})
public class ObrisiKorisnikaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Korisnik ulogovani = (Korisnik) (session != null ? session.getAttribute("ulogovaniKorisnik") : null);

        // Provera da li je korisnik admin
        if (ulogovani == null || ulogovani.getRole().getRole_id() != 1) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            int korisnikId = Integer.parseInt(request.getParameter("id"));
            boolean uspesno = DBUtil.obrisiKorisnika(korisnikId);
            
            if (uspesno) {
                session.setAttribute("poruka", "Korisnik uspešno obrisan");
            } else {
                session.setAttribute("greska", "Greška prilikom brisanja korisnika");
            }
            
            response.sendRedirect("AdminPanelServlet");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("greska", "Greška: " + e.getMessage());
            response.sendRedirect("AdminPanelServlet");
        }
    }
}