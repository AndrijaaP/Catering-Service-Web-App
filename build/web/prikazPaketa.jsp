<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Paket" %>
<%@ include file="meni.jsp" %>
<%
    boolean mozeUredjivati = jeAdmin || jeMenadzer;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Paketi | Ketering</title>
    <style>
        :root {
            --primary: #FF6B6B;
            --secondary: #4ECDC4;
            --dark: #292F36;
            --light: #F7FFF7;
            --accent: #FFE66D;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light);
            color: var(--dark);
            margin: 0;
            line-height: 1.6;
        }

        .content {
            max-width: 1200px;
            margin: 4rem auto;
            padding: 0 2rem;
        }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .section-title h2 {
            color: var(--primary);
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .section-title p {
            color: #555;
            margin-top: 0;
        }

        .packages {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2.5rem;
        }

        .package-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
            display: flex;
            flex-direction: column;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .package-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 18px 40px rgba(0,0,0,0.2);
        }

        .package-image {
            position: relative;
            height: 200px;
            overflow: hidden;
        }

        .package-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .package-card:hover .package-image img {
            transform: scale(1.1);
        }

        .package-overlay {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 10px;
            background: rgba(0,0,0,0.5);
            color: white;
            display: flex;
            justify-content: space-between;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .package-content {
            padding: 1rem 1.5rem;
            flex: 1;
        }

        .package-content p {
            margin: 0.5rem 0;
            color: #555;
        }

        .package-actions {
            display: flex;
            gap: 0.8rem;
            padding: 1rem 1.5rem;
            justify-content: flex-end;
        }

        .package-actions a {
            text-decoration: none;
            font-weight: bold;
            padding: 6px 12px;
            border-radius: 5px;
            border: 1px solid var(--primary);
            color: var(--primary);
            transition: all 0.3s ease;
        }

        .package-actions a:hover {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .no-data {
            text-align: center;
            color: #777;
            font-size: 1.2rem;
            margin-top: 2rem;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        @media (max-width: 768px) {
            .packages {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="content">
    <div class="section-title">
        <h2>Naši paketi</h2>
        <p>Prilagodljivi meniji za sve prilike</p>
    </div>

    <%
        List<Paket> paketi = (List<Paket>) request.getAttribute("paketi");
        if (paketi == null || paketi.isEmpty()) {
    %>
        <div class="no-data">Trenutno nema unetih paketa.</div>
    <%
        } else {
    %>
        <div class="packages">
            <% for (Paket p : paketi) { %>
                <div class="package-card">
                    <div class="package-image">
                        <img src="images/rostilj.jpg" alt="<%= p.getIme_paketa() %>">
                        <div class="package-overlay">
                            <span><%= p.getIme_paketa() %></span>
                            <span><%= String.format("%.2f", p.getIznos()) %> RSD</span>
                        </div>
                    </div>
                    <div class="package-content">
                        <p><strong>Kategorija:</strong> <%= p.getKategorija().getIme_kategorije() %></p>
                        <p><strong>Opis:</strong> <%= p.getOpis_paketa() %></p>
                        <p><strong>Za:</strong> <%= p.getBroj_osoba() %> osoba</p>
                    </div>
                    <% if (mozeUredjivati) { %>
                        <div class="package-actions">
                            <a href="PaketServlet?akcija=edit&id=<%= p.getPaket_id() %>">Izmeni</a>
                            <a href="PaketServlet?akcija=delete&id=<%= p.getPaket_id() %>"
                               onclick="return confirm('Da li ste sigurni da želite da obrišete ovaj paket?');">
                                Obriši
                            </a>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    <% } %>
</div>
</body>
</html>
