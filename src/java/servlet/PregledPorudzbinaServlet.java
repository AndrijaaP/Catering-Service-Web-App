package servlet;

import database.DBUtil;
import model.Korisnik;
import model.Porudzbina;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PregledPorudzbinaServlet", urlPatterns = {"/PregledPorudzbinaServlet"})
public class PregledPorudzbinaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesija = request.getSession(false);
        Korisnik ulogovani = sesija != null ? (Korisnik) sesija.getAttribute("ulogovaniKorisnik") : null;

        if (ulogovani == null || (ulogovani.getRole().getRole_id() != 1 && ulogovani.getRole().getRole_id() != 2)) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            List<Porudzbina> lista = DBUtil.getAllPorudzbine();
            request.setAttribute("porudzbine", lista);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("greska", "Greška prilikom učitavanja porudžbina: " + ex.getMessage());
        }

        request.getRequestDispatcher("pregledPorudzbina.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Lista svih porudžbina (za admina i menadžera)";
    }
}