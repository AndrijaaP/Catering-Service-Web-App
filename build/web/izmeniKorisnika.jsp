<%@page import="model.Korisnik"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Korisnik k = (Korisnik) request.getAttribute("korisnik");
    if (k == null) { response.sendRedirect("AdminPanelServlet"); return; }
%>
<!DOCTYPE html>
<html lang="sr-RS">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Izmena korisnika | Ketering</title>
<style>
    :root {
        --primary: #D97706; 
        --secondary: #F59E0B; 
        --accent: #EF4444; 
        --background-overlay: rgba(0,0,0,0.55);
        --card-bg: rgba(255,255,255,0.95);
        --dark-text: #111827;
        --danger: #DC2626;
    }

    body, html {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        background:
            linear-gradient(var(--background-overlay), var(--background-overlay)),
            url('images/izmenaKorisnika.jpg') no-repeat center center fixed;
        background-size: cover;
        color: var(--dark-text);
    }

    .form-container {
        max-width: 700px;
        min-width: 450px;
        background: var(--card-bg);
        border-radius: 25px;
        padding: 2rem 2.5rem;
        box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        margin: 100px auto 50px auto; 
        animation: fadeInDown 0.8s forwards;
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .form-header {
        text-align: center;
        margin-bottom: 2rem;
    }

    .form-header h2 {
        font-size: 2rem;
        color: var(--primary);
        margin: 0;
        position: relative;
    }

    .form-header h2::after {
        content: '';
        width: 60px;
        height: 4px;
        background: var(--secondary);
        display: block;
        margin: 8px auto 0;
        border-radius: 2px;
    }

    .form-group {
        width: 100%;
        margin-bottom: 1.25rem;
    }

    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 600;
        color: var(--dark-text);
    }

    .form-group input,
    .form-group select {
        width: 100%;
        padding: 0.85rem 1.2rem;
        border-radius: 12px;
        border: 1px solid #cbd5e1;
        font-size: 1rem;
        transition: all 0.3s;
    }

    .form-group input:focus,
    .form-group select:focus {
        border-color: var(--secondary);
        box-shadow: 0 0 0 3px rgba(245,158,11,0.2);
        outline: none;
    }

    .submit-btn {
        width: 100%;
        padding: 1rem;
        border: none;
        border-radius: 15px;
        font-size: 1.15rem;
        font-weight: 600;
        cursor: pointer;
        background: var(--primary);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        transition: all 0.3s;
    }

    .submit-btn:hover {
        background-color: var(--secondary);
        transform: translateY(-2px);
    }

    .back-link {
        margin-top: 1.5rem;
        text-align: center;
        text-decoration: none;
        color: var(--primary);
        font-weight: 600;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 0.4rem;
        transition: all 0.2s;
    }

    .back-link:hover {
        color: var(--secondary);
        text-decoration: underline;
    }

    .error-msg {
        color: var(--danger);
        font-size: 0.95rem;
        margin-bottom: 1rem;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 0.5rem;
        text-align: center;
    }

    .password-note {
        font-size: 0.85rem;
        color: #666;
        margin-top: 5px;
        font-style: italic;
    }

    
    @media (max-width: 768px) {
        .form-container {
            margin: 60px 20px 30px 20px;
            padding: 1.5rem 2rem;
        }
    }

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="form-container">
    <div class="form-header">
        <h2>Izmena korisnika</h2>
    </div>

    <% if (request.getAttribute("greska") != null) { %>
        <div class="error-msg">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("greska") %>
        </div>
    <% } %>

    <form method="post" action="IzmeniKorisnikaServlet">
        <input type="hidden" name="korisnik_id" value="<%= k.getKorisnik_id() %>">

        <div class="form-group">
            <label for="username">Korisničko ime</label>
            <input type="text" id="username" name="username" value="<%= k.getUsername() %>" required>
        </div>

        <div class="form-group">
            <label for="sifra">Šifra</label>
            <input type="password" id="sifra" name="sifra" value="<%= k.getSifra() %>" required>
        </div>

        <div class="form-group">
            <label for="ime">Ime</label>
            <input type="text" id="ime" name="ime" value="<%= k.getIme() %>" required>
        </div>

        <div class="form-group">
            <label for="prezime">Prezime</label>
            <input type="text" id="prezime" name="prezime" value="<%= k.getPrezime() %>" required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="<%= k.getEmail() %>" required>
        </div>

        <div class="form-group">
            <label for="role_id">Uloga</label>
            <select id="role_id" name="role_id" required>
                <option value="1" <%= k.getRole().getRole_id() == 1 ? "selected" : "" %>>Admin</option>
                <option value="2" <%= k.getRole().getRole_id() == 2 ? "selected" : "" %>>Menadžer</option>
                <option value="3" <%= k.getRole().getRole_id() == 3 ? "selected" : "" %>>Korisnik</option>
            </select>
        </div>

        <button type="submit" class="submit-btn">
            <i class="fas fa-save"></i> Sačuvaj izmene
        </button>

        <a href="AdminPanelServlet" class="back-link">
            <i class="fas fa-arrow-left"></i> Nazad na listu korisnika
        </a>
    </form>
</div>

</body>
</html>
