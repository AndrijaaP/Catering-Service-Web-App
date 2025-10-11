<%@ page import="java.util.List" %>
<%@ page import="model.Paket" %>
<%@ include file="meni.jsp" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="sr-RS">
    <head>
        <meta charset="UTF-8">
        <title>Narudžbina | Ketering</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap');

            :root {
                --primary: #2E4057;
                --secondary: #FF4B2B;
                --highlight: #FFB347;
                --light-bg: rgba(255,255,255,0.95);
                --dark-text: #1C1C1C;
            }

            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                background: url('images/edit.jpg') no-repeat center center;
                background-size: cover;
                background-attachment: fixed;
                position: relative;
            }

            
            body::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.6);
                z-index: -1;
            }

            .form-overlay {
                width: 100%;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding: 6rem 1rem 3rem; 
            }

            .order-form {
                max-width: 960px;
                width: 100%;
                background: var(--light-bg);
                border-radius: 30px;
                padding: 3rem 3.5rem;
                box-shadow: 0 20px 50px rgba(0,0,0,0.4);
                display: flex;
                flex-direction: column;
                gap: 2.5rem;
            }

            .order-header {
                text-align: center;
            }

            .order-header h2 {
                font-size: 3rem;
                color: var(--secondary);
                margin-bottom: 0.5rem;
            }

            .order-header p {
                font-size: 1.2rem;
                color: #555555;
                font-weight: 500;
            }

            .package-list h3 {
                font-size: 1.8rem;
                color: var(--primary);
                border-bottom: 2px solid var(--secondary);
                padding-bottom: 0.5rem;
                margin-bottom: 1rem;
            }

            .package-item {
                display: grid;
                grid-template-columns: 2fr 1fr;
                background: #ffffffdd;
                padding: 1.5rem 1.8rem;
                border-radius: 20px;
                gap: 1rem;
                align-items: center;
                transition: all 0.3s ease;
                border: 1px solid #ddd;
            }

            .package-item:hover {
                transform: scale(1.02);
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            }

            .package-info h4 {
                margin: 0 0 0.5rem 0;
                color: var(--secondary);
                font-size: 1.4rem;
            }

            .package-info p {
                margin: 0.2rem 0;
                font-size: 0.95rem;
                color: var(--dark-text);
            }

            .package-info strong {
                color: var(--primary);
            }

            .package-price {
                font-weight: 700;
                color: #FF6F61;
                font-size: 1.1rem;
            }

            .quantity-input {
                display: flex;
                flex-direction: column;
                align-items: flex-end;
                gap: 0.3rem;
            }

            .quantity-input label {
                font-weight: 600;
                color: var(--primary);
            }

            .quantity-input input {
                width: 60px;
                padding: 0.6rem;
                border-radius: 10px;
                border: 2px solid #ccc;
                text-align: center;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .quantity-input input:focus {
                border-color: var(--highlight);
                outline: none;
                box-shadow: 0 0 8px rgba(26, 188, 156, 0.3);
            }

            .delivery-info {
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
            }

            .delivery-info h3 {
                font-size: 1.8rem;
                color: var(--secondary);
                border-bottom: 2px solid var(--highlight);
                padding-bottom: 0.5rem;
            }

            .form-group label {
                display: block;
                margin-bottom: 0.4rem;
                font-weight: 600;
                color: var(--primary);
            }

            .form-group input,
            .form-group textarea {
                width: 100%;
                padding: 0.9rem 1rem;
                border-radius: 15px;
                border: 1px solid #ccc;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-group input:focus,
            .form-group textarea:focus {
                border-color: var(--highlight);
                box-shadow: 0 0 10px rgba(26,188,156,0.3);
                outline: none;
            }

            .form-group textarea {
                min-height: 120px;
                resize: vertical;
            }

            .error {
                color: var(--secondary);
                font-size: 0.9rem;
                margin-top: 0.3rem;
            }

            .submit-btn {
                padding: 1.1rem 2rem;
                border-radius: 50px;
                border: none;
                background: var(--highlight);
                color: var(--dark-text);
                font-weight: 700;
                font-size: 1.2rem;
                cursor: pointer;
                transition: all 0.3s ease;
                align-self: center;
            }

            .submit-btn:hover {
                background: var(--secondary);
                color: white;
            }

            .no-packages {
                padding: 1.2rem;
                background: #f3f3f3;
                text-align: center;
                border-radius: 15px;
                color: #666;
            }

            @media (max-width: 900px) {
                .package-item {
                    grid-template-columns: 1fr;
                    gap: 0.8rem;
                }
                .quantity-input {
                    align-items: flex-start;
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
        <div class="form-overlay">
            <form class="order-form" action="PoruciServlet" method="post">
                <div class="order-header">
                    <h2>Nova porudžbina</h2>
                    <p>Dodajte omiljene pakete i unesite podatke za dostavu</p>
                </div>

                <div class="package-list">
                    <h3>Odaberite pakete</h3>
                    <%
                        List<Paket> paketi = (List<Paket>) request.getAttribute("listaPaketi");
                        if (paketi != null && !paketi.isEmpty()) {
                            for (Paket p : paketi) {
                    %>
                    <div class="package-item">
                        <div class="package-info">
                            <h4><%= p.getIme_paketa()%></h4>
                            <p><strong>Opis:</strong> <%= p.getOpis_paketa()%></p>
                            <p><strong>Cena:</strong> <span class="package-price"><%= String.format("%.2f", p.getIznos())%> RSD</span></p>
                        </div>
                        <div class="quantity-input">
                            <label for="paket_<%= p.getPaket_id()%>">Količina:</label>
                            <input type="number" id="paket_<%= p.getPaket_id()%>" name="paket_<%= p.getPaket_id()%>" min="0" value="0">
                        </div>
                    </div>
                    <% }
                    } else { %>
                    <div class="no-packages">
                        Trenutno nema dostupnih paketa.
                    </div>
                    <% } %>
                </div>

                <% if (request.getAttribute("greskaStavke") != null) {%>
                <div class="error">
                    <%= request.getAttribute("greskaStavke")%>
                </div>
                <% }%>

                <div class="delivery-info">
                    <h3>Podaci za dostavu</h3>
                    <div class="form-group">
                        <label for="adresa_isporuke">Adresa isporuke</label>
                        <input type="text" id="adresa_isporuke" name="adresa_isporuke" required>
                    </div>
                    <div class="form-group">
                        <label for="kontakt_telefon">Kontakt telefon</label>
                        <input type="text" id="kontakt_telefon" name="kontakt_telefon" required>
                    </div>
                    <div class="form-group">
                        <label for="napomena">Napomena</label>
                        <textarea id="napomena" name="napomena"></textarea>
                    </div>

                    <button type="submit" class="submit-btn">Pošalji porudžbinu</button>
                </div>
            </form>
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
