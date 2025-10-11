<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="sr-RS">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dodaj paket | Ketering</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: url('images/dodajPaket.jpg') no-repeat center center fixed;
            background-size: cover;
            position: relative;
        }

        
        body::before {
            content: "";
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.55);
            z-index: 0;
        }

        
        .wrapper {
            position: relative;
            z-index: 1;
            max-width: 700px;
            width: 90%;
            margin: 40px auto;
            background: rgba(255,255,255,0.98);
            border-radius: 18px;
            padding: 60px 45px;
            box-shadow: 0 16px 36px rgba(0,0,0,0.35);
            animation: fadeIn 0.6s ease-in-out;
        }

        h1 {
            text-align: center;
            margin-bottom: 40px;
            font-size: 36px;
            font-weight: 700;
            color: #2c3e50;
            letter-spacing: 1px;
        }

        .form-row { margin-bottom: 22px; }

        .form-row label { 
            font-weight: 600; 
            margin-bottom: 10px; 
            display: block; 
            color: #34495e; 
            font-size: 16px;
        }

        .form-row input,
        .form-row textarea,
        .form-row select {
            width: 100%;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 12px;
            font-size: 15px;
            background: linear-gradient(145deg, #f9f9f9, #ffffff);
            transition: all 0.3s ease;
            box-shadow: inset 0 2px 6px rgba(0,0,0,0.05);
            font-family: inherit;
            box-sizing: border-box;
        }

        .form-row input:focus,
        .form-row textarea:focus,
        .form-row select:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 12px rgba(52,152,219,0.35);
        }

        .form-row textarea { min-height: 120px; resize: vertical; }

        .form-row select {
            appearance: none; 
            padding-right: 40px; 
        }

        .error-msg { color: #e74c3c; font-size: 13px; margin-top: 5px; }
        .global-error {
            padding: 14px;
            background: #fbeaea;
            color: #c0392b;
            border-left: 4px solid #e74c3c;
            margin-bottom: 20px;
            border-radius: 6px;
        }

        .form-footer { text-align: center; margin-top: 30px; }

        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: #fff;
            padding: 15px 42px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.35s ease;
            box-shadow: 0 8px 18px rgba(0,0,0,0.2);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9, #1f6391);
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 12px 24px rgba(0,0,0,0.3);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        
        .wrapper { overflow: visible; }
    </style>
</head>
<body>
<div class="wrapper">
    <h1>Dodavanje paketa</h1>

    <% if (request.getAttribute("greska") != null) { %>
        <div class="global-error"><%= request.getAttribute("greska") %></div>
    <% } %>

    <form method="post" action="PaketServlet">
        <input type="hidden" name="akcija" value="insert">

        <div class="form-row">
            <label for="ime_paketa">Naziv paketa</label>
            <input type="text" id="ime_paketa" name="ime_paketa"
                   value="<%= request.getAttribute("ime_paketa") != null ? request.getAttribute("ime_paketa") : "" %>">
            <div class="error-msg"><%= request.getAttribute("greskaNaziv") != null ? request.getAttribute("greskaNaziv") : "" %></div>
        </div>

        <div class="form-row">
            <label for="kategorija_id">Kategorija</label>
            <select id="kategorija_id" name="kategorija_id">
                <option value="">-- Izaberite --</option>
                <option value="1" <%= "1".equals(request.getAttribute("kategorija_id")) ? "selected" : "" %>>Slana ponuda</option>
                <option value="2" <%= "2".equals(request.getAttribute("kategorija_id")) ? "selected" : "" %>>Slatka ponuda</option>
            </select>
            <div class="error-msg"><%= request.getAttribute("greskaKategorija") != null ? request.getAttribute("greskaKategorija") : "" %></div>
        </div>

        <div class="form-row">
            <label for="opis_paketa">Opis</label>
            <textarea id="opis_paketa" name="opis_paketa"><%= request.getAttribute("opis_paketa") != null ? request.getAttribute("opis_paketa") : "" %></textarea>
            <div class="error-msg"><%= request.getAttribute("greskaOpis") != null ? request.getAttribute("greskaOpis") : "" %></div>
        </div>

        <div class="form-row">
            <label for="iznos">Cena (RSD)</label>
            <input type="text" id="iznos" name="iznos"
                   value="<%= request.getAttribute("iznos") != null ? request.getAttribute("iznos") : "" %>">
            <div class="error-msg"><%= request.getAttribute("greskaIznos") != null ? request.getAttribute("greskaIznos") : "" %></div>
        </div>

        <div class="form-row">
            <label for="broj_osoba">Broj osoba</label>
            <input type="number" id="broj_osoba" name="broj_osoba"
                   value="<%= request.getAttribute("broj_osoba") != null ? request.getAttribute("broj_osoba") : "" %>">
            <div class="error-msg"><%= request.getAttribute("greskaBroj") != null ? request.getAttribute("greskaBroj") : "" %></div>
        </div>

        <div class="form-footer">
            <button type="submit" class="btn-primary">Sačuvaj paket</button>
        </div>
    </form>
</div>
</body>
</html>
