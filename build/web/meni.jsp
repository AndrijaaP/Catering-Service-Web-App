<%@ page import="model.Korisnik" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Korisnik ulogovani = (Korisnik) session.getAttribute("ulogovaniKorisnik");
    boolean jeAdmin    = ulogovani != null && ulogovani.getRole().getRole_id() == 1;
    boolean jeMenadzer = ulogovani != null && ulogovani.getRole().getRole_id() == 2;
    boolean jeKorisnik = ulogovani != null && ulogovani.getRole().getRole_id() == 3;
%>

<style>
:root {
    --text-color: #fff;
    --accent-color: #FF6B6B;
    --transition: 0.3s ease-in-out;
    --navbar-height: 60px;
}


* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}


.top-nav {
    position: relative; 
    top: 0;
    left: 0;
    width: 100%;
    height: var(--navbar-height);
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 0 2rem;
    z-index: 1000;
     background: transparent !important;
     box-shadow: none !important;
}

/* LINKOVI */
.nav-menu {
    display: flex;
    list-style: none;
    gap: 1.5rem;
}

.nav-menu li a {
    color: var(--text-color);
    text-decoration: none;
    font-weight: 600;
    font-size: 1.1rem;
    padding: 0.5rem 0;
    transition: color var(--transition), text-shadow var(--transition);
    text-shadow: 0 2px 4px rgba(0,0,0,0.6); 
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.nav-menu li a:hover {
    color: var(--accent-color);
    text-shadow: 0 0 8px rgba(255, 255, 255, 0.8);
}


.burger {
    display: none;
    font-size: 1.8rem;
    cursor: pointer;
    color: var(--text-color);
    transition: transform var(--transition);
}

.burger:hover {
    transform: scale(1.2);
}

#nav-toggle {
    display: none;
}


@media (max-width: 768px) {
    .burger { display: block; }
    .nav-menu {
        position: absolute;
        top: var(--navbar-height);
        right: 0;
        flex-direction: column;
        background: rgba(0,0,0,0.4); 
        display: none;
        padding: 1rem;
        gap: 1rem;
        width: 200px;
        text-align: center;
        transform: translateX(100%);
        transition: transform var(--transition);
    }
    #nav-toggle:checked ~ .nav-menu {
        display: flex;
        transform: translateX(0);
    }
    .nav-menu li a {
        font-size: 1.2rem;
        padding: 0.5rem 0;
        text-shadow: none; 
    }
}


body, html {
    margin: 0;
    padding: 0;
    min-height: 100vh;
}

main, .content {
    padding-top: var(--navbar-height);
}
</style>

<nav class="top-nav" role="navigation" aria-label="Main navigation">
    <input type="checkbox" id="nav-toggle" aria-hidden="true">
    <label for="nav-toggle" class="burger" aria-label="Toggle menu">☰</label>

    <ul class="nav-menu">
        <li><a href="index.jsp">Početna</a></li>
        <li><a href="PaketServlet?akcija=pregled&kategorijaId=1">Slano</a></li>
        <li><a href="PaketServlet?akcija=pregled&kategorijaId=2">Slatko</a></li>
        <li><a href="PaketServlet?akcija=pregled">Kompletna ponuda</a></li>
        <li><a href="PoruciServlet">Poruči</a></li>

        <% if (ulogovani != null) { %>
            <li><a href="profil.jsp">Profil</a></li>
            <% if (jeAdmin) { %>
                <li><a href="AdminPanelServlet">Admin panel</a></li>
            <% } %>
            <% if (jeAdmin || jeMenadzer) { %>
                <li><a href="PregledPorudzbinaServlet">Sve porudžbine</a></li>
            <% } %>
            <li><a href="logout">Odjava</a></li>
        <% } else { %>
            <li><a href="login.jsp">Prijava</a></li>
            <li><a href="registracija.jsp">Registracija</a></li>
        <% } %>
    </ul>
</nav>
