package servlet;

import database.DBUtil;
import model.Korisnik;
import model.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "IzmeniKorisnikaServlet", urlPatterns = {"/IzmeniKorisnikaServlet"})
public class IzmeniKorisnikaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Korisnik k = DBUtil.getKorisnikById(id);
            if (k == null) {
                resp.sendRedirect("AdminPanelServlet");
                return;
            }
            req.setAttribute("korisnik", k);
            req.getRequestDispatcher("izmeniKorisnika.jsp").forward(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.sendRedirect("AdminPanelServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(req.getParameter("korisnik_id"));
            String username = req.getParameter("username");
            String ime = req.getParameter("ime");
            String prezime = req.getParameter("prezime");
            String email = req.getParameter("email");
            String sifra = req.getParameter("sifra");
            int roleId = Integer.parseInt(req.getParameter("role_id"));

            Korisnik k = new Korisnik();
            k.setKorisnik_id(id);
            k.setUsername(username);
            k.setIme(ime);
            k.setPrezime(prezime);
            k.setEmail(email);
            k.setSifra(sifra);
            k.setRole(new Role(roleId, ""));

            DBUtil.updateKorisnik(k);

            resp.sendRedirect("AdminPanelServlet");
        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("greska", "Greška pri čuvanju: " + ex.getMessage());
            doGet(req, resp);
        }
    }
}