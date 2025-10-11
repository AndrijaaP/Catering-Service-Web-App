<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="sr">
    <head>
        <meta charset="UTF-8">
        <title>Prijava | Ketering</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap');

            :root {
                --main-color: #FF6363;
                --accent-color: #FFE66D;
                --card-bg: #ffffff;
                --text-color: #333333;
                --error-color: #FF4D4D;
            }

            * {
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family: 'Montserrat', sans-serif;
            }

            body {
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
                background: url('images/biftek.jpg') no-repeat center center;
                background-size: cover;
            }

          
            body::before {
                content: "";
                position: absolute;
                top:0;
                left:0;
                right:0;
                bottom:0;
                background-color: rgba(0,0,0,0.4); 
                z-index: 0;
            }

            .login-card {
                background-color: var(--card-bg);
                width: 400px;
                padding: 3rem 2.5rem;
                border-radius: 20px;
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
                position: relative;
                z-index: 1; 
            }

            .login-card h2 {
                text-align: center;
                margin-bottom: 2rem;
                color: var(--main-color);
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-group label {
                display:block;
                margin-bottom:0.5rem;
                font-weight:500;
                color: var(--text-color);
            }

            .form-group input {
                width: 100%;
                padding: 0.9rem 1rem;
                border: 1px solid #ddd;
                border-radius: 50px;
                font-size: 1rem;
            }

            .submit-btn {
                width: 100%;
                padding: 0.9rem;
                background-color: var(--main-color);
                color: white;
                border: none;
                border-radius: 50px;
                font-weight: bold;
                cursor: pointer;
                margin-top: 1rem;
            }

            .login-footer {
                text-align: center;
                margin-top: 1.5rem;
            }

            .login-footer a {
                color: var(--main-color); 
                font-weight: bold;
                text-decoration: none;
            }


            .error-msg {
                color: var(--error-color);
                font-size: 0.85rem;
                margin-top: 0.3rem;
            }

            .global-error {
                position: absolute;
                top: -25px;
                left: 0;
                right: 0;
                text-align: center;
                padding: 0.5rem 0;
                background-color: #ffe6e6;
                border-radius: 10px;
                color: var(--error-color);
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <div class="login-card">
            <% if (request.getAttribute("greska") != null) {%>
            <div class="global-error"><%= request.getAttribute("greska")%></div>
            <% }%>

            <h2>Prijavite se</h2>
            <form method="post" action="LoginServlet">
                <div class="form-group">
                    <label for="username">Korisničko ime</label>
                    <input type="text" name="username" id="username"
                           value="<%= request.getAttribute("usernameVrednost") != null ? request.getAttribute("usernameVrednost") : ""%>">
                    <div class="error-msg"><%= request.getAttribute("greskaUsername") != null ? request.getAttribute("greskaUsername") : ""%></div>
                </div>

                <div class="form-group">
                    <label for="sifra">Lozinka</label>
                    <input type="password" name="sifra" id="sifra">
                    <div class="error-msg"><%= request.getAttribute("greskaSifra") != null ? request.getAttribute("greskaSifra") : ""%></div>
                </div>

                <button type="submit" class="submit-btn">Prijavi se</button>
            </form>

            <div class="login-footer">
                <p>Nemate nalog? <a href="registracija.jsp">Registrujte se</a></p>
            </div>
        </div>
    </body>
</html>
