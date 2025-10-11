<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Paket" %>
<%@ include file="meni.jsp" %>
<%
    boolean mozeUredjivati = jeAdmin || jeMenadzer;
%>
<!DOCTYPE html>
<html lang="sr-RS">
<head>
    <meta charset="UTF-8">
    <title>Specijalni Meniji | Ketering</title>
    <style>
        :root {
            --primary: #2C3E50;
            --secondary: #5AA1DD;
            --text-light: #FFFFFF;
            --layer-dark: rgba(0,0,0,0.55);
            --card-bg: linear-gradient(135deg, #fffaf3, #fff1d6);
            --navbar-height: 60px;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            background: var(--section-bg);
        }

        /* HERO */
        .hero {
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            padding: 5rem 1rem 4rem 1rem;

            background: url('images/paketi.jpg') center/cover no-repeat;
            margin-top: calc(-1 * var(--navbar-height)); 
            z-index: 0;
        }

        .hero::after {
            content: "";
            position: absolute;
            top:0;
            left:0;
            right:0;
            bottom:0;
            background-color: var(--layer-dark);
            z-index: 0;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            text-align: center;
            color: var(--text-light);
            margin-bottom: 3rem;
        }

        .hero-title-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .hero-content h1 {
            font-size: 3rem;
            margin: 0.5rem 0;
        }

        .hero-content p {
            font-size: 1.3rem;
            color: #ddd;
        }

        .add-package-btn {
            background: #e67e22;   
            color: white;
            font-weight: bold;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        .add-package-btn:hover {
            background: #d35400;   
        }

        .packages-floating {
            position: relative;
            z-index: 2;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            width: 100%;
            max-width: 1200px;
        }

        .package-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 8px 20px rgba(0,0,0,0.18);
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .package-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.25);
        }

        .package-card h2 {
            margin: 0 0 0.3rem 0;
            color: var(--primary);
            font-size: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .badge {
            background: var(--secondary);
            color: white;
            font-size: 0.75rem;
            padding: 0.2rem 0.6rem;
            border-radius: 10px;
            font-weight: 600;
        }

        .description {
            font-size: 0.9rem;
            color: #2C3E50;
            font-style: italic;
            margin-bottom: 0.8rem;
        }

        .info-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            font-weight: 600;
            font-size: 1.1rem;
            padding-top: 0.8rem;
            border-top: 1px solid #eee;
        }

        .info-bar .people {
            color: #2C3E50;
            font-size: 1.1rem;
        }

        .info-bar .price {
            color: var(--primary);
            font-size: 1.25rem;
        }

        .actions {
            margin-top: 1rem;
            display: flex;
            gap: 0.5rem;
        }

        .actions a {
            flex: 1;
            text-align: center;
            padding: 6px 0;
            border-radius: 8px;
            text-decoration: none;
            color: var(--text-light);
            background: var(--primary);
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .actions a:hover {
            background: var(--secondary);
        }

        .no-data {
            text-align: center;
            font-size: 1.2rem;
            color: #fff;
            margin-top: 2rem;
            background: rgba(0,0,0,0.4);
            padding: 1rem 2rem;
            border-radius: 12px;
        }

        @media(max-width: 768px){
            .hero-content h1 {
                font-size: 2.2rem;
            }
        }
        footer {
                background-color: #262B36;
                color: var(--text-light);
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

<div class="hero">
    <div class="hero-content">
        <div class="hero-title-row">
            <h1>Specijalni Meniji Dana</h1>
            <% if (mozeUredjivati) { %>
            <a href="dodajPaket.jsp" class="add-package-btn">+ Dodaj paket</a>
            <% } %>
        </div>
        <p>Odaberite savršen paket za vašu priliku</p>
    </div>

    <div class="packages-floating">
        <%
            List<Paket> paketi = (List<Paket>) request.getAttribute("paketi");
            if (paketi == null || paketi.isEmpty()) {
        %>
        <div class="no-data">Trenutno nema dostupnih paketa.</div>
        <%
            } else {
                for (Paket p : paketi) {
        %>
        <div class="package-card">
            <h2>
                <%= p.getIme_paketa()%>
                <span class="badge"><%= p.getKategorija().getIme_kategorije()%></span>
            </h2>
            <p class="description"><%= p.getOpis_paketa()%></p>

            <div class="info-bar">
                <span class="people">👥 <%= p.getBroj_osoba()%></span>
                <span class="price">💰 <%= String.format("%.2f", p.getIznos())%> RSD</span>
            </div>

            <% if (mozeUredjivati) {%>
            <div class="actions">
                <a href="PaketServlet?akcija=edit&id=<%= p.getPaket_id()%>">Izmeni</a>
                <a href="PaketServlet?akcija=delete&id=<%= p.getPaket_id()%>" 
                   onclick="return confirm('Da li ste sigurni da želite da obrišete ovaj paket?');">
                    Obriši
                </a>
            </div>
            <% } %>
        </div>
        <% }
            } %>
    </div>
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
