<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="sr">
<head>
    <meta charset="UTF-8">
    <title>Registracija | Ketering</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap');

        :root {
            --main-color: #1E3A8A;       
            --accent-color: #50E3C2;     
            --card-bg: #ffffff;
            --text-color: #111111;       
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
            background: url('images/salata.jpg') no-repeat center center;
            background-size: cover;
            padding: 60px 20px; 
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

        .register-card {
            background-color: var(--card-bg);
            width: 450px;
            padding: 3rem 3rem;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            position: relative;
            z-index: 1; 
        }

        .register-card h2 {
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
            color: var(--main-color);
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

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
        }

        .login-link a {
            color: var(--accent-color);
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
    <div class="register-card">
        <% if (request.getAttribute("greska") != null) {%>
        <div class="global-error"><%= request.getAttribute("greska")%></div>
        <% }%>

        <h2>Registrujte se</h2>
        <form method="post" action="RegistracijaServlet">
            <div class="form-group">
                <label for="username">Korisničko ime</label>
                <input id="username" name="username" type="text"
                       value="<%= request.getAttribute("usernameVrednost") != null ? request.getAttribute("usernameVrednost") : ""%>">
                <div class="error-msg"><%= request.getAttribute("greskaUser") != null ? request.getAttribute("greskaUser") : ""%></div>
            </div>

            <div class="form-group">
                <label for="ime">Ime</label>
                <input id="ime" name="ime" type="text"
                       value="<%= request.getAttribute("imeVrednost") != null ? request.getAttribute("imeVrednost") : ""%>">
                <div class="error-msg"><%= request.getAttribute("greskaIme") != null ? request.getAttribute("greskaIme") : ""%></div>
            </div>

            <div class="form-group">
                <label for="prezime">Prezime</label>
                <input id="prezime" name="prezime" type="text"
                       value="<%= request.getAttribute("prezimeVrednost") != null ? request.getAttribute("prezimeVrednost") : ""%>">
                <div class="error-msg"><%= request.getAttribute("greskaPrezime") != null ? request.getAttribute("greskaPrezime") : ""%></div>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input id="email" name="email" type="text"
                       value="<%= request.getAttribute("emailVrednost") != null ? request.getAttribute("emailVrednost") : ""%>">
                <div class="error-msg"><%= request.getAttribute("greskaEmail") != null ? request.getAttribute("greskaEmail") : ""%></div>
            </div>

            <div class="form-group">
                <label for="sifra">Lozinka</label>
                <input id="sifra" name="sifra" type="password">
                <div class="error-msg"><%= request.getAttribute("greskaSifra") != null ? request.getAttribute("greskaSifra") : ""%></div>
            </div>

            <button type="submit" class="submit-btn">Registruj se</button>
        </form>

        <div class="login-link">
            <p>Već imate nalog? <a href="login.jsp">Prijavite se</a></p>
        </div>
    </div>
</body>
</html>
