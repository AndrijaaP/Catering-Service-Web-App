<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Paket" %>
<%
    Paket paket = (Paket) request.getAttribute("paket");
    if (paket == null) {
        response.sendRedirect("PaketServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="sr-RS">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Izmeni paket | Ketering</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');

            :root {
                --primary: #1F3B73;
                --secondary: #FF6B6B;
                --accent: #FFD166;
                --light: #FDFCFB;
                --dark: #333;
            }

            body {
                margin: 0;
                font-family: 'Roboto', sans-serif;
                background: url('images/izmeni.jpg') center/cover no-repeat fixed;
                background-blend-mode: overlay;
                background-color: rgba(0,0,0,0.5);
                color: var(--dark);
            }

            .edit-container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 40px 1rem; 
            }



            .form-wrapper {
                width: 100%;
                max-width: 720px;
                background: var(--light);
                padding: 3rem 2.5rem;
                border-radius: 20px;
                box-shadow: 0 15px 40px rgba(0,0,0,0.3);
                backdrop-filter: blur(10px);
                border: 2px solid rgba(255,255,255,0.3);
                transition: transform 0.3s ease;
            }

            .form-wrapper:hover {
                transform: translateY(-5px);
            }

            .form-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .form-header h2 {
                font-size: 2.4rem;
                color: var(--primary);
                margin: 0 0 0.3rem 0;
                letter-spacing: 1px;
            }

            form {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 1.5rem 2rem;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-group.full-width {
                grid-column: 1 / -1;
            }

            .form-group label {
                font-weight: 600;
                margin-bottom: 0.5rem;
                color: var(--primary);
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                padding: 0.8rem 1rem;
                border-radius: 12px;
                border: 1.5px solid #ccc;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                border-color: var(--secondary);
                box-shadow: 0 0 10px rgba(255,107,107,0.2);
                outline: none;
            }

            .form-group textarea {
                resize: vertical;
                min-height: 140px;
            }

            .currency-input {
                position: relative;
            }

            .currency-input:before {
                content: "RSD";
                position: absolute;
                left: 12px;
                top: 50%;
                transform: translateY(-50%);
                background: var(--secondary);
                color: white;
                font-weight: bold;
                padding: 2px 8px;
                border-radius: 6px;
                font-size: 0.9rem;
            }

            .currency-input input {
                padding-left: 55px !important;
            }

            .error-msg {
                font-size: 0.85rem;
                color: var(--secondary);
                margin-top: 0.3rem;
            }

            .global-error {
                grid-column: 1 / -1;
                padding: 1rem;
                background: rgba(255, 107, 107, 0.1);
                color: var(--secondary);
                font-weight: 500;
                border-left: 4px solid var(--secondary);
                margin-bottom: 1rem;
                border-radius: 8px;
            }

            .submit-btn {
                grid-column: 1 / -1;
                padding: 1rem;
                background: var(--primary);
                color: white;
                border: none;
                font-size: 1.1rem;
                font-weight: 600;
                border-radius: 50px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .submit-btn:hover {
                background: var(--secondary);
                transform: translateY(-2px);
            }

            .back-link {
                grid-column: 1 / -1;
                text-align: center;
                margin-top: 1rem;
                color: var(--primary);
                text-decoration: none;
                font-weight: 600;
            }

            .back-link:hover {
                color: var(--secondary);
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                form {
                    grid-template-columns: 1fr;
                }
            }

        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body>
        <div class="edit-container">
            <div class="form-wrapper">
                <div class="form-header">
                    <h2>Izmeni paket</h2>
                </div>

                <% if (request.getAttribute("greska") != null) {%>
                <div class="global-error">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("greska")%>
                </div>
                <% }%>

                <form method="post" action="PaketServlet">
                    <input type="hidden" name="akcija" value="update" />
                    <input type="hidden" name="paket_id" value="<%= paket.getPaket_id()%>" />

                    <!-- PRVI RED -->
                    <div class="form-group">
                        <label for="ime_paketa">Naziv paketa</label>
                        <input type="text" id="ime_paketa" name="ime_paketa"
                               value="<%= request.getAttribute("ime_paketa") != null ? request.getAttribute("ime_paketa") : paket.getIme_paketa()%>"
                               placeholder="Unesite naziv paketa" required>
                        <span class="error-msg"><%= request.getAttribute("greskaNaziv") != null ? request.getAttribute("greskaNaziv") : ""%></span>
                    </div>

                    <div class="form-group">
                        <label for="kategorija_id">Kategorija</label>
                        <select id="kategorija_id" name="kategorija_id" required>
                            <%
                                String kategorijaVrednost = String.valueOf(paket.getKategorija().getKategorija_id());
                            %>
                            <option value="">-- Izaberite kategoriju --</option>
                            <option value="1" <%= "1".equals(kategorijaVrednost) ? "selected" : ""%>>Slana ponuda</option>
                            <option value="2" <%= "2".equals(kategorijaVrednost) ? "selected" : ""%>>Slatka ponuda</option>
                        </select>
                        <span class="error-msg"><%= request.getAttribute("greskaKategorija") != null ? request.getAttribute("greskaKategorija") : ""%></span>
                    </div>

                    <!-- DRUGI RED -->
                    <div class="form-group currency-input">
                        <label for="iznos">Cena po osobi</label>
                        <input type="text" id="iznos" name="iznos"
                               value="<%= request.getAttribute("iznos") != null ? request.getAttribute("iznos") : paket.getIznos()%>"
                               placeholder="Unesite cenu" required>
                        <span class="error-msg"><%= request.getAttribute("greskaIznos") != null ? request.getAttribute("greskaIznos") : ""%></span>
                    </div>

                    <div class="form-group">
                        <label for="broj_osoba">Minimalni broj osoba</label>
                        <input type="text" id="broj_osoba" name="broj_osoba"
                               value="<%= request.getAttribute("broj_osoba") != null ? request.getAttribute("broj_osoba") : paket.getBroj_osoba()%>"
                               placeholder="Unesite minimalni broj osoba" required>
                        <span class="error-msg"><%= request.getAttribute("greskaBroj") != null ? request.getAttribute("greskaBroj") : ""%></span>
                    </div>

                    <!-- TRECI RED -->
                    <div class="form-group full-width">
                        <label for="opis_paketa">Detaljan opis</label>
                        <textarea id="opis_paketa" name="opis_paketa" placeholder="Opisite šta sve uključuje paket..." required><%= request.getAttribute("opis_paketa") != null ? request.getAttribute("opis_paketa") : paket.getOpis_paketa()%></textarea>
                        <span class="error-msg"><%= request.getAttribute("greskaOpis") != null ? request.getAttribute("greskaOpis") : ""%></span>
                    </div>

                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save"></i> Sačuvaj izmene
                    </button>

                    <a href="PaketServlet" class="back-link">
                        <i class="fas fa-arrow-left"></i> Nazad na listu paketa
                    </a>
                </form>
            </div>
        </div>
    </body>
</html>
