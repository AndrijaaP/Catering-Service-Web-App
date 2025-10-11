package servlet;

import database.DBUtil;
import model.Korisnik;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private static final String LOGIN_JSP = "login.jsp";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String sifra = req.getParameter("sifra");

        boolean errors = false;

        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("greskaUsername", "Korisničko ime je obavezno.");
            errors = true;
        } else {
            req.setAttribute("usernameVrednost", username);
        }

        if (sifra == null || sifra.trim().isEmpty()) {
            req.setAttribute("greskaSifra", "Šifra je obavezna.");
            errors = true;
        }

        if (errors) {
            req.getRequestDispatcher(LOGIN_JSP).forward(req, resp);
            return;
        }

        try {
            Korisnik k = DBUtil.getKorisnikByUsername(username);
            if (k != null && sifra.equals(k.getSifra())) {
                HttpSession session = req.getSession();
                session.setAttribute("ulogovaniKorisnik", k);
                session.setAttribute("korisnikId", k.getKorisnik_id());
                resp.sendRedirect("index.jsp");
            } else {
                req.setAttribute("greska", "Neispravno korisničko ime ili šifra.");
                req.getRequestDispatcher(LOGIN_JSP).forward(req, resp);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("greska", "Greška baze: " + ex.getMessage());
            req.getRequestDispatcher(LOGIN_JSP).forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(LOGIN_JSP).forward(req, resp);
    }

    @Override
    public String getServletInfo() {
        return "Login servlet (plain-text šifra)";
    }
}