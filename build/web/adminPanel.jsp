<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Korisnik"%>
<%@ include file="meni.jsp" %>
<!DOCTYPE html>
<html lang="sr-RS">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Panel | Ketering</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            :root {
                --primary: #0F172A;     
                --secondary: #3B82F6;   
                --accent: #F9FAFB;      
                --text-dark: #111827;
                --text-light: #ffffff;  
                --card-bg: rgba(255, 255, 255, 0.9);
                --shadow: rgba(0, 0, 0, 0.1);
                --navbar-height: 60px; 
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }
            
           .top-nav  {
                margin-top: 15px;
            }
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
                background:
                    linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)),
                    url('images/borovnice.jpg') no-repeat center center fixed;
                background-size: cover;
            }

            .admin-wrapper {
                width: 95%;
                max-width: 1400px;
                margin: var(--navbar-height) auto 40px auto; 
                background: var(--card-bg);
                backdrop-filter: blur(10px);
                border-radius: 25px;
                padding: 3rem 2rem;
                box-shadow: 0 20px 50px var(--shadow);
                display: flex;
                flex-direction: column;
                gap: 2rem;
                flex: 1; 
            }

            .admin-top {
                display: flex;
                justify-content: center;
                align-items: center;
                flex-wrap: wrap;
                gap: 1rem;
            }

            .admin-title {
                font-size: 3rem;
                font-weight: 700;
                color: var(--primary);
                text-align: center;
            }

            .add-user-btn {
                background: var(--secondary);
                color: #fff;
                border: none;
                border-radius: 50px;
                padding: 0.8rem 1.5rem;
                font-weight: 600;
                cursor: pointer;
                transition: 0.3s;
            }

            .add-user-btn:hover {
                background: #2563EB;
                transform: translateY(-2px);
            }

            .search-container {
                display: flex;
                justify-content: center;
            }

            .search-box {
                display: flex;
                align-items: center;
                background: #fff;
                border-radius: 50px;
                padding: 0.5rem 1rem;
                box-shadow: 0 8px 20px var(--shadow);
            }

            .search-box input {
                border: none;
                outline: none;
                padding: 0.6rem 1rem;
                border-radius: 50px;
                min-width: 250px;
                font-size: 1rem;
            }

            .search-box button {
                background: var(--primary);
                color: #fff;
                border: none;
                border-radius: 50px;
                padding: 0.6rem 1rem;
                margin-left: 0.5rem;
                cursor: pointer;
                transition: 0.3s;
            }

            .search-box button:hover {
                background: var(--secondary);
            }

            .admin-card {
                background: var(--accent);
                border-radius: 20px;
                padding: 2rem;
                overflow-x: auto;
                box-shadow: 0 10px 30px var(--shadow);
            }

            .user-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0 10px;
            }

            .user-table th, .user-table td {
                padding: 1rem 1.2rem;
                text-align: center;
            }

            .user-table th {
                background: var(--primary);
                color: #fff;
                font-weight: 600;
                border-radius: 0;
            }

            .user-table tr {
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 6px 15px var(--shadow);
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .user-table tr:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 25px var(--shadow);
            }

            .role-admin {
                background: var(--primary);
                color: #fff;
                padding: 0.4rem 0.9rem;
                border-radius: 25px;
                font-size: 0.85rem;
                font-weight: 600;
            }

            .role-user {
                background: var(--secondary);
                color: #fff;
                padding: 0.4rem 0.9rem;
                border-radius: 25px;
                font-size: 0.85rem;
                font-weight: 600;
            }

            .action-btns {
                display: flex;
                justify-content: center;
                gap: 0.5rem;
            }

            .edit-btn, .delete-btn {
                padding: 0.5rem 1rem;
                border-radius: 15px;
                font-weight: 500;
                transition: 0.3s;
                color: #fff;
                border: none;
                cursor: pointer;
            }

            .edit-btn {
                background: var(--secondary);
            }

            .edit-btn:hover {
                background: #2563EB;
                transform: scale(1.05);
            }

            .delete-btn {
                background: var(--primary);
            }

            .delete-btn:hover {
                background: #0F172A;
                transform: scale(1.05);
            }

            .message, .error {
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 12px;
                color: white;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .message {
                background: #3B82F6;
            }
            .error {
                background: #0F172A;
            }

            .no-data {
                text-align: center;
                padding: 2rem;
                color: #555;
            }

            @media (max-width: 900px) {
                .admin-wrapper {
                    padding: 2rem;
                    margin: var(--navbar-height) auto 20px auto;
                }
                .action-btns {
                    flex-direction: column;
                    gap: 0.5rem;
                }
                .search-box input {
                    min-width: 150px;
                }
                .admin-title {
                    font-size: 2rem;
                }
            }

            /* Footer */
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
    </head>
    <body>
        <div class="admin-wrapper">

            <%-- Poruke --%>
            <% if (session.getAttribute("poruka") != null) {%>
            <div class="message">
                <i class="fas fa-check-circle"></i> <%= session.getAttribute("poruka")%>
            </div>
            <% session.removeAttribute("poruka"); %>
            <% } %>
            <% if (session.getAttribute("greska") != null) {%>
            <div class="error">
                <i class="fas fa-exclamation-circle"></i> <%= session.getAttribute("greska")%>
            </div>
            <% session.removeAttribute("greska"); %>
            <% } %>

            <!-- Top header -->
            <div class="admin-top">
                <h1 class="admin-title">Admin Panel</h1>
                <button class="add-user-btn" onclick="window.location.href = 'dodaj-korisnika.jsp'">
                    <i class="fas fa-user-plus"></i> Dodaj korisnika
                </button>
            </div>

            <!-- Search -->
            <div class="search-container">
                <div class="search-box">
                    <input type="text" placeholder="Pretraži korisnike...">
                    <button type="submit"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <!-- Tabela korisnika -->
            <div class="admin-card">
                <table class="user-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Korisničko ime</th>
                            <th>Email</th>
                            <th>Ime i prezime</th>
                            <th>Status</th>
                            <th>Uloga</th>
                            <th>Akcije</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Korisnik> korisnici = (List<Korisnik>) request.getAttribute("korisnici");
                            if (korisnici != null && !korisnici.isEmpty()) {
                                for (Korisnik k : korisnici) {
                        %>
                        <tr>
                            <td><%= k.getKorisnik_id()%></td>
                            <td><strong><%= k.getUsername()%></strong></td>
                            <td><%= k.getEmail()%></td>
                            <td><%= k.getIme()%> <%= k.getPrezime()%></td>
                            <td>Aktivan</td>
                            <td>
                                <span class="<%= "admin".equalsIgnoreCase(k.getRole().getNaziv_role()) ? "role-admin" : "role-user"%>">
                                    <%= k.getRole().getNaziv_role()%>
                                </span>
                            </td>
                            <td>
                                <div class="action-btns">
                                    <a href="IzmeniKorisnikaServlet?id=<%= k.getKorisnik_id()%>" class="edit-btn">
                                        <i class="fas fa-edit"></i> Izmeni
                                    </a>
                                    <button class="delete-btn" onclick="confirmDelete(<%= k.getKorisnik_id()%>)">
                                        <i class="fas fa-trash-alt"></i> Obriši
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% }
                        } else { %>
                        <tr>
                            <td colspan="7" class="no-data">
                                <i class="fas fa-user-slash" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                                <p>Nema korisnika za prikaz</p>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            function confirmDelete(userId) {
                if (confirm('Da li ste sigurni da želite da obrišete ovog korisnika?')) {
                    window.location.href = 'ObrisiKorisnikaServlet?id=' + userId;
                }
            }
        </script>

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
