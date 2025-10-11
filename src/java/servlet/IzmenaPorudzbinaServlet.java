package servlet;

import database.DBUtil;
import model.Korisnik;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "IzmenaPorudzbinaServlet", urlPatterns = {"/IzmenaPorudzbinaServlet"})
public class IzmenaPorudzbinaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Korisnik admin = (Korisnik) req.getSession().getAttribute("ulogovaniKorisnik");
        if (admin == null || admin.getRole().getRole_id() != 1) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Samo admin može da menja porudžbine.");
            return;
        }

        String akcija = req.getParameter("akcija");
        String idStr = req.getParameter("porudzbinaId");

        if (akcija == null || idStr == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int porudzbinaId = Integer.parseInt(idStr);

        try {
            if ("izmeniStatus".equals(akcija)) {
                String noviStatus = req.getParameter("noviStatus");
                if (noviStatus == null ||
                        !(noviStatus.equals("kreirana") ||
                          noviStatus.equals("u_pripremi") ||
                          noviStatus.equals("isporucena") ||
                          noviStatus.equals("otkazana"))) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Nevažeći status.");
                    return;
                }
                DBUtil.updatePorudzbinaStatus(porudzbinaId, noviStatus, admin.getKorisnik_id());
            } else if ("obrisi".equals(akcija)) {
                DBUtil.deletePorudzbina(porudzbinaId);
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            resp.sendRedirect("PregledPorudzbinaServlet");
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Greška pri obradi: " + ex.getMessage());
        }
    }
}