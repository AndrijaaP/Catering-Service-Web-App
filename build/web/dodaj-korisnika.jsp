<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="sr-RS">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dodaj korisnika | Ketering</title>
<style>
    :root {
        --primary: #047857; 
        --secondary: #10B981; 
        --accent: #FBBF24; 
        --background-overlay: rgba(0,0,0,0.55);
        --card-bg: rgba(255,255,255,0.95);
        --dark-text: #111827;
        --danger: #DC2626;
    }

    body, html {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background:
            linear-gradient(var(--background-overlay), var(--background-overlay)),
            url('images/dodajkorisnika.jpg') no-repeat center center fixed;
        background-size: cover;
        color: var(--dark-text);
        overflow-y: auto;
    }

    .form-container {
        width: 90%;
        max-width: 500px;
        background: var(--card-bg);
        border-radius: 25px;
        padding: 3rem 2rem;
        box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        display: flex;
        flex-direction: column;
        align-items: center;
        animation: fadeIn 0.8s ease-in-out;
        margin: 40px 0; 
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .form-header {
        text-align: center;
        margin-bottom: 2.5rem;
    }

    .form-header h2 {
        font-size: 2rem;
        color: var(--primary);
        margin: 0;
        position: relative;
    }

    .form-header h2::after {
        content: '';
        width: 50px;
        height: 4px;
        background: var(--secondary);
        display: block;
        margin: 8px auto 0;
        border-radius: 2px;
    }

    .form-group {
        width: 100%;
        margin-bottom: 1.5rem;
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
        padding: 0.75rem 1rem;
        border-radius: 12px;
        border: 1px solid #cbd5e1;
        font-size: 1rem;
        transition: all 0.3s;
    }

    .form-group input:focus,
    .form-group select:focus {
        border-color: var(--secondary);
        box-shadow: 0 0 0 3px rgba(16,185,129,0.2);
        outline: none;
    }

    .submit-btn {
        width: 100%;
        padding: 0.9rem;
        border: none;
        border-radius: 15px;
        font-size: 1.1rem;
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

    @media (max-height: 700px) {
        .form-container {
            margin: 20px 0;
            padding: 2rem 1.5rem;
        }
    }

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="form-container">
    <div class="form-header">
        <h2>Dodaj novog korisnika</h2>
    </div>

    <% if (request.getAttribute("greska") != null) { %>
        <div class="error-msg">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("greska") %>
        </div>
    <% } %>

    <form method="post" action="DodajKorisnikaServlet">
        <div class="form-group">
            <label for="username">Korisničko ime</label>
            <input type="text" id="username" name="username" required>
        </div>

        <div class="form-group">
            <label for="sifra">Šifra</label>
            <input type="password" id="sifra" name="sifra" required>
        </div>

        <div class="form-group">
            <label for="ime">Ime</label>
            <input type="text" id="ime" name="ime" required>
        </div>

        <div class="form-group">
            <label for="prezime">Prezime</label>
            <input type="text" id="prezime" name="prezime" required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="role_id">Uloga</label>
            <select id="role_id" name="role_id" required>
                <option value="">-- Izaberite ulogu --</option>
                <option value="1">Admin</option>
                <option value="2">Menadžer</option>
                <option value="3">Korisnik</option>
            </select>
        </div>

        <button type="submit" class="submit-btn">
            <i class="fas fa-user-plus"></i> Dodaj korisnika
        </button>

        <a href="AdminPanelServlet" class="back-link">
            <i class="fas fa-arrow-left"></i> Nazad na listu korisnika
        </a>
    </form>
</div>

</body>
</html>
