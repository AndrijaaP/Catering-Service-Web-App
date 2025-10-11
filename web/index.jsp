<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ include file="meni.jsp" %>
<!DOCTYPE html>
<html lang="sr-RS">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ketering | Uživajte u ukusu, mi brinemo o detaljima</title>
        <style>
            :root {
                --primary: #fff;
                --accent: #29B6F6;
                --overlay: rgba(0,0,0,0.6);
                --section-bg: #F0F4F8;
                --text-dark: #333333;
                --text-light: #fff;
                
            }


            * {
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: var(--section-bg);
                color: var(--text-dark);
                line-height: 1.6;
            }

            .hero {
                position: relative;
                background: url('images/naslovna.jpg') no-repeat center center/cover;
                color: var(--text-light);
                text-align: center;
                padding: 8rem 2rem;
                margin-top: -60px; 
                z-index: 0;
            }

            .hero::after {
                content:"";
                position: absolute;
                top:0;
                left:0;
                right:0;
                bottom:0;
                background-color: var(--overlay);
            }

            .hero-content {
                position: relative;
                z-index: 1;
            }

            .hero h1 {
                font-size: 3rem;
                margin-bottom: 1rem;
                color: var(--primary);
            }

            .hero p {
                font-size: 1.2rem;
                max-width: 700px;
                margin: 0 auto 2rem;
                color: var(--primary);
            }

            .cta-button {
                display: inline-block;
                background-color: var(--accent);
                color: var(--text-light);
                padding: 12px 30px;
                border-radius: 50px;
                text-decoration: none;
                font-weight: bold;
            }

            .about {
                background-color: var(--section-bg);
                padding: 6rem 2rem 4rem 2rem;
                text-align: center;
            }

            .about h2 {
                color: #1A237E;
                font-size: 2.8rem;
                margin-bottom: 1.5rem;
            }
            .about p {
                max-width: 900px;
                margin: 0 auto;
                font-size: 1.2rem;
            }

            .specialties {
                padding: 4rem 2rem 8rem 2rem;
                text-align: center;
            }

            .specialties h2 {
                color: #1A237E;
                font-size: 2.8rem;
                margin-bottom: 2rem;
            }

            .gallery {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 1.5rem;
            }

            .gallery a {
                display: block;
                position: relative;
                overflow: hidden;
                border-radius: 10px;
                height: 280px;
            }

            .gallery img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                cursor: pointer;
                display: block;
            }

            .gallery a::after {
                content: "Kliknite za više";
                position: absolute;
                top:0;
                left:0;
                right:0;
                bottom:0;
                background: rgba(0,0,0,0.5);
                color: #fff;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
            }

            .gallery a:hover::after {
                opacity: 1;
            }

            
            footer {
                background-color: #262B36;
                color: var(--text-light);
                text-align: center;
                padding: 1rem;
            }

            footer p {
                margin: 0.3rem 0;
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
        <div class="hero">
            <div class="hero-content">
                <h1>Uživajte u ukusu, mi brinemo o detaljima</h1>
                <p>Stvaramo gastronomska iskustva koja inspirišu sva čula. Od elegantnih poslovnih događaja do porodičnih proslava – mi kombinuјemo kreativnost, svežinu i vrhunsku prezentaciju da bi svaki trenutak bio poseban.</p>
                <a href="#about" class="cta-button">Saznajte više</a>
            </div>
        </div>

        <div class="about" id="about">
            <h2>O nama</h2>
            <p>Mi verujemo da je hrana više od obroka – to je iskustvo koje spaja ljude. Sa pažnjom biramo svaki sastojak, kreiramo menije po meri i pružamo kompletan servis kako bi vaši događaji bili nezaboravni. Naša misija je da svaka proslava postane posebna, a gosti oduševljeni. Od intimnih večera do velikih događaja, naš tim stručnjaka obezbeđuje besprekornu organizaciju i kreativna rešenja. Uvek se trudimo da hrana izgleda fantastično, a ukus ostavlja snažan utisak.</p>
        </div>

        <div class="specialties">
            <h2>Naši specijaliteti</h2>
            <div class="gallery">
                <a href="login.jsp"><img src="images/rostilj.jpg" alt="Specijalitet 1"></a>
                <a href="login.jsp"><img src="images/vocnimix.jpg" alt="Specijalitet 2"></a>
                <a href="login.jsp"><img src="images/dezert.jpg" alt="Specijalitet 3"></a>
                <a href="login.jsp"><img src="images/fithrana.jpg" alt="Specijalitet 4"></a>
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
