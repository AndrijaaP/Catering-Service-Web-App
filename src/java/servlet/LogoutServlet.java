package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesija = request.getSession(false); // false = ne kreiraj novu ako ne postoji
        if (sesija != null) {
            sesija.invalidate(); // uništi sesiju
        }
        response.sendRedirect("index.jsp"); // redirekcija na početnu
    }

    @Override
    public String getServletInfo() {
        return "Odjava korisnika (Logout)";
    }
}
