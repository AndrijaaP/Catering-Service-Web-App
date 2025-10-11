package servlet;

import database.DBUtil;
import model.Korisnik;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminPanelServlet", urlPatterns = {"/AdminPanelServlet"})
public class AdminPanelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Korisnik ulogovani = (Korisnik) (session != null ? session.getAttribute("ulogovaniKorisnik") : null);

        if (ulogovani == null || ulogovani.getRole().getRole_id() != 1) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            List<Korisnik> korisnici = DBUtil.getAllKorisnici();
            request.setAttribute("korisnici", korisnici);
            request.getRequestDispatcher("adminPanel.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("greska", "Greška prilikom učitavanja korisnika: " + e.getMessage());
            request.getRequestDispatcher("adminPanel.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Prikaz admin panela sa svim korisnicima";
    }
}