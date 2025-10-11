<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="sr-RS">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Uspešna porudžbina | Ketering</title>
    <style>
        :root {
            --primary: #047857; 
            --secondary: #10B981; 
            --accent: #FBBF24; 
            --danger: #DC2626;
            --dark-text: #111827;
            --overlay: rgba(0,0,0,0.55);
            --card-bg: rgba(255,255,255,0.95);
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
                linear-gradient(var(--overlay), var(--overlay)),
                url('images/uspesnoNaruceno.jpg') no-repeat center center fixed;
            background-size: cover;
            color: var(--dark-text);
        }

        .confirmation-container {
            width: 100%;
            max-width: 550px;
            background: var(--card-bg);
            border-radius: 25px;
            padding: 3rem 2rem;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
            text-align: center;
            animation: fadeIn 0.9s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .success-icon {
            font-size: 4rem;
            color: var(--secondary);
            margin-bottom: 1.5rem;
        }

        .confirmation-container h2 {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 1.2rem;
            position: relative;
        }

        .confirmation-container h2::after {
            content: '';
            width: 60px;
            height: 4px;
            background: var(--secondary);
            display: block;
            margin: 10px auto 0;
            border-radius: 2px;
        }

        .confirmation-container p {
            font-size: 1.1rem;
            margin-bottom: 0.8rem;
            line-height: 1.5;
        }

        .highlight {
            color: var(--primary);
            font-weight: 600;
        }

        .btn-home {
            display: inline-block;
            margin-top: 2rem;
            background-color: var(--primary);
            color: white;
            padding: 14px 36px;
            border-radius: 15px;
            font-size: 1.05rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-home:hover {
            background-color: var(--secondary);
            transform: translateY(-2px);
        }

        @media (max-width: 600px) {
            .confirmation-container {
                padding: 2rem 1.5rem;
            }
            .confirmation-container h2 {
                font-size: 1.6rem;
            }
        }
    </style>
    <link rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="confirmation-container">
    <div class="success-icon"><i class="fas fa-check-circle"></i></div>
    <h2>Porudžbina je uspešno kreirana!</h2>
    <p>Vaša porudžbina je primljena i trenutno se obrađuje.</p>
    <p>Broj porudžbine: <span class="highlight"><%= request.getAttribute("porudzbinaId") %></span></p>
    <p>Iznos za uplatu: 
       <span class="highlight">
         <%= String.format("%.2f", (java.math.BigDecimal) request.getAttribute("ukupno")) %> RSD
       </span>
    </p>
    <p>Naš tim će Vas kontaktirati uskoro radi potvrde i detalja o isporuci.</p>
    <a href="index.jsp" class="btn-home"><i class="fas fa-arrow-left"></i> Povratak na početnu</a>
</div>

</body>
</html>
