<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.Porudzbina"%>
<%@ include file="meni.jsp" %>
<!DOCTYPE html>
<html lang="sr-RS">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sve porudžbine | Ketering</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn3TZfyaVOXkg==" crossorigin="anonymous">
        <style>
            :root {
                --primary: #0F172A;
                --secondary: #3B82F6;
                --accent: #F9FAFB;
                --highlight: #FFD93D;
                --danger: #FF4C4C;
                --card-bg: rgba(255,255,255,0.9);
                --shadow: rgba(0,0,0,0.1);
                --navbar-height: 60px;
            }


            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }


            body, html {
                margin: 0;
                padding: 0;
                min-height: 100vh;
                background:
                    linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)),
                    url('images/burger.jpg') no-repeat center center fixed;
                background-size: cover; 
                display: flex;
                flex-direction: column;
            }


            .panel {
                width: 95%;
                max-width: 1300px;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
                gap: 2rem;
                justify-content: center;
                align-items: start;
                margin: var(--navbar-height) auto 40px auto;
                flex: 1;
            }


            .order-card {
                background: var(--card-bg);
                border-radius: 20px;
                padding: 1.5rem 2rem;
                position: relative;
                box-shadow: 0 15px 35px var(--shadow);
                transition: transform 0.3s, box-shadow 0.3s;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .order-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 25px 50px var(--shadow);
            }


            .status {
                position: absolute;
                top: 1rem;
                right: 1rem;
                padding: 0.3rem 0.8rem;
                border-radius: 50px;
                font-size: 0.85rem;
                font-weight: bold;
                color: #fff;
                text-transform: uppercase;
            }

            .status-KREIRANA {
                background-color: #ffe0b2;
                color: #ff6d00;
            }
            .status-U_PRIPREMI {
                background-color: #bbdefb;
                color: #0d47a1;
            }
            .status-ISPORUCENA {
                background-color: #c8e6c9;
                color: #2e7d32;
            }
            .status-OTKAZANA {
                background-color: #ffcdd2;
                color: #c62828;
            }


            .order-info {
                margin-top: 2rem;
            }

            .order-info p {
                margin: 0.5rem 0;
                font-size: 1rem;
                color: #111827;
            }

            .order-info strong {
                color: var(--primary);
            }


            .admin-actions {
                margin-top: 1.5rem;
                display: flex;
                gap: 0.5rem;
            }

            .admin-actions form {
                display: flex;
                gap: 0.5rem;
            }

            select {
                padding: 0.4rem 0.6rem;
                border-radius: 8px;
                border: 1px solid #ccc;
                flex: 1;
                font-size: 0.95rem;
            }

            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 10px;
                font-size: 0.9rem;
                font-weight: 600;
                cursor: pointer;
                transition: 0.3s;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-izmeni {
                background-color: var(--highlight);
                color: #111827;
            }
            .btn-izmeni:hover {
                background-color: #e6c200;
            }

            .btn-obrisi {
                background-color: var(--danger);
                color: #fff;
            }
            .btn-obrisi:hover {
                background-color: #cc0000;
            }

            .no-orders {
                grid-column: 1/-1;
                text-align: center;
                padding: 2rem;
                background: var(--card-bg);
                border-radius: 15px;
                box-shadow: 0 15px 35px var(--shadow);
                font-size: 1.2rem;
                color: #333;
            }

            @media (max-width: 900px) {
                .panel {
                    margin: var(--navbar-height) auto 20px auto;
                    gap: 1.5rem;
                }
                .order-card {
                    padding: 1.2rem 1.5rem;
                }
            }

            footer {
                background-color: #262B36;
                color: #fff;
                text-align: center;
                padding: 1rem;
            }

            footer p {
                margin: 0.5rem 0;
            }

            .social-links a {
                color: var(--text-light);
                margin: 0 10px;
                font-size: 1.5rem;
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body>
        <%
            List<Porudzbina> lista = (List<Porudzbina>) request.getAttribute("porudzbine");
            if (lista == null) {
                lista = new ArrayList<>();
            }
        %>
        <div class="panel">
            <% if (lista.isEmpty()) { %>
            <div class="no-orders">Trenutno nema nijedne porudžbine.</div>
            <% } else { %>
            <% for (Porudzbina p : lista) {%>
            <div class="order-card">
                <span class="status status-<%= p.getStatus().name()%>"><%= p.getStatus()%></span>
                <div class="order-info">
                    <p><strong>Porudžbina ID:</strong> <%= p.getPorudzbina_id()%></p>
                    <p><strong>Korisnik:</strong> <%= p.getKorisnik() != null ? p.getKorisnik().getUsername() : "Neregistrovani"%></p>
                    <p><strong>Iznos:</strong> <%= String.format("%.2f", p.getUkupni_iznos())%> RSD</p>
                </div>
                <% if (jeAdmin) {%>
                <div class="admin-actions">
                    <form method="post" action="IzmenaPorudzbinaServlet">
                        <input type="hidden" name="porudzbinaId" value="<%= p.getPorudzbina_id()%>">
                        <select name="noviStatus">
                            <option value="kreirana" <%= p.getStatus().name().equalsIgnoreCase("KREIRANA") ? "selected" : ""%>>Kreirana</option>
                            <option value="u_pripremi" <%= p.getStatus().name().equalsIgnoreCase("U_PRIPREMI") ? "selected" : ""%>>U pripremi</option>
                            <option value="isporucena" <%= p.getStatus().name().equalsIgnoreCase("ISPORUCENA") ? "selected" : ""%>>Isporučena</option>
                            <option value="otkazana" <%= p.getStatus().name().equalsIgnoreCase("OTKAZANA") ? "selected" : ""%>>Otkazana</option>
                        </select>
                        <button class="btn btn-izmeni" type="submit" name="akcija" value="izmeniStatus">
                            <i class="fas fa-edit"></i> Izmeni status
                        </button>
                    </form>
                    <form method="post" action="IzmenaPorudzbinaServlet" onsubmit="return confirm('Da li ste sigurni da želite da obrišete porudžbinu?');">
                        <input type="hidden" name="porudzbinaId" value="<%= p.getPorudzbina_id()%>">
                        <button class="btn btn-obrisi" type="submit" name="akcija" value="obrisi">
                            <i class="fas fa-trash-alt"></i> Obriši
                        </button>
                    </form>
                </div>
                <% } %>
            </div>
            <% } %>
            <% }%>
        </div>
        <footer>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-tiktok"></i></a>
            </div>
            <p>Ketering © 2025</p>
        </footer>
    </body>
</html>