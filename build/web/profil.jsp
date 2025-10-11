<%@page import="model.Korisnik" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="meni.jsp" %>
<%
    Korisnik korisnik = (Korisnik) session.getAttribute("ulogovaniKorisnik");
    if (korisnik == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="sr-RS">
    <head>
        <meta charset="UTF-8">
        <title>Moj profil | Ketering</title>
        <style>
            :root {
                --primary: #2E4057;
                --secondary: #FF4B2B;
                --text: #333;
                --text-light: #fff;
                --navbar-height: 60px;
            }

            
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', sans-serif;
            }

            
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)),
                    url("images/mojprofil.jpg") no-repeat center center/cover;
                color: var(--text);
                align-items: center;
            }

            .main-content {
                flex: 1;
                display: flex;
                align-items: flex-start; 
                justify-content: center;
                width: 100%;
                padding: calc(var(--navbar-height) + 1rem) 0 2rem 0; 
            }


           
            .profile-wrapper {
                max-width: 1000px;
                width: 90%;
                padding: 2rem;
                margin-top: -1rem;
            }

            
            .profile-card {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 15px 50px rgba(0,0,0,0.3);
                display: grid;
                grid-template-columns: 300px 1fr;
            }

            
            .profile-sidebar {
                background: var(--primary);
                color: #fff;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 3rem 2rem;
            }

            .profile-sidebar img {
                width: 140px;
                height: 140px;
                border-radius: 50%;
                border: 4px solid #fff;
                object-fit: cover;
                margin-bottom: 1.5rem;
            }

            .profile-sidebar h3 {
                margin: 0;
                font-size: 1.6rem;
            }

            .profile-sidebar p {
                margin: 0.3rem 0;
                font-size: 1rem;
                opacity: 0.9;
            }

           
            .profile-content {
                padding: 2.5rem 3rem;
            }

            .profile-content h2 {
                color: var(--secondary);
                margin-bottom: 2rem;
                font-size: 2rem;
                border-bottom: 2px solid #eee;
                padding-bottom: 0.5rem;
            }

            .info-list {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
            }

            .info-item {
                background: #f7f7f7;
                border-radius: 12px;
                padding: 1rem 1.2rem;
                box-shadow: inset 0 2px 6px rgba(0,0,0,0.05);
            }

            .info-item label {
                font-weight: 600;
                font-size: 0.85rem;
                color: var(--primary);
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .info-item span {
                display: block;
                margin-top: 0.4rem;
                font-size: 1.1rem;
                color: var(--text);
            }

            
            @media(max-width: 850px) {
                .profile-card {
                    grid-template-columns: 1fr;
                }
                .profile-sidebar {
                    padding: 2rem 1rem;
                }
            }

            
            footer {
                background-color: #262B36;
                color: var(--text-light);
                text-align: center;
                padding: 1rem;
                width: 100%;
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

        <div class="main-content">
            <div class="profile-wrapper">
                <div class="profile-card">
                    <div class="profile-sidebar">
                        <img src="images/login.png" alt="Korisnik">
                        <h3><%= korisnik.getIme()%> <%= korisnik.getPrezime()%></h3>
                        <p><%= korisnik.getRole().getNaziv_role()%></p>
                    </div>
                    <div class="profile-content">
                        <h2>Podaci o korisniku</h2>
                        <div class="info-list">
                            <div class="info-item">
                                <label>Ime</label>
                                <span><%= korisnik.getIme()%></span>
                            </div>
                            <div class="info-item">
                                <label>Prezime</label>
                                <span><%= korisnik.getPrezime()%></span>
                            </div>
                            <div class="info-item">
                                <label>Email</label>
                                <span><%= korisnik.getEmail()%></span>
                            </div>
                            <div class="info-item">
                                <label>Korisničko ime</label>
                                <span><%= korisnik.getUsername()%></span>
                            </div>
                        </div>
                    </div>
                </div>
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
