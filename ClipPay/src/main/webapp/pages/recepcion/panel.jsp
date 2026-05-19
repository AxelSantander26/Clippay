<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
<title>ClipPay | ${sessionScope.rol != null ? sessionScope.rol : "Sistema"}</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
* {
margin: 0;
padding: 0;
box-sizing: border-box;
}

body {
font-family: 'Inter', sans-serif;
height: 100vh;
overflow: hidden;
background: #f5f5f5;
}

.app-container {
display: flex;
height: 100vh;
width: 100%;
}

/* ========== SIDEBAR ========== */
.sidebar {
width: 220px;
background: white;
border-right: 1px solid #e2e8f0;
display: flex;
flex-direction: column;
transition: width 0.3s ease;
overflow-y: auto;
flex-shrink: 0;
}

.sidebar.collapsed {
width: 60px;
}

.sidebar-header {
padding: 1.5rem 0.5rem;
text-align: center;
border-bottom: 1px solid #e2e8f0;
margin-bottom: 1.5rem;
}

.sidebar.collapsed .sidebar-header {
padding: 1rem 0;
}

.sidebar-header img {
width: 102px;
height: auto;
margin-bottom: 0.5rem;
}

.sidebar.collapsed .sidebar-header img {
width: 40px;
}

.sidebar-header h1 {
font-size: 1.1rem;
font-weight: 600;
color: #1a1a2e;
letter-spacing: 1px;
}

.sidebar.collapsed .sidebar-header h1 {
display: none;
}

.sidebar-header p {
font-size: 0.55rem;
color: #94a3b8;
letter-spacing: 1px;
text-transform: uppercase;
}

.sidebar.collapsed .sidebar-header p {
display: none;
}

.sidebar-nav {
flex: 1;
display: flex;
flex-direction: column;
gap: 2px;
padding: 0 0.5rem;
}

.nav-item {
display: flex;
align-items: center;
gap: 12px;
padding: 0.6rem 0.6rem;
color: #64748b;
text-decoration: none;
transition: all 0.2s;
cursor: pointer;
font-size: 0.8rem;
font-weight: 500;
white-space: nowrap;
}

.sidebar.collapsed .nav-item {
justify-content: center;
padding: 0.6rem 0;
}

.nav-item:hover {
background: #f1f5f9;
color: #1a1a2e;
}

.nav-item.active {
background: #f1f5f9;
color: #1a1a2e;
border-left: 3px solid #1a1a2e;
}

.nav-item .icon {
width: 20px;
height: 20px;
display: flex;
align-items: center;
justify-content: center;
flex-shrink: 0;
}

.nav-item .icon img {
width: 18px;
height: 18px;
}

.nav-item .text {
overflow: hidden;
transition: opacity 0.2s;
}

.sidebar.collapsed .nav-item .text {
display: none;
}

.sidebar-footer {
padding: 1rem 0.5rem;
border-top: 1px solid #e2e8f0;
}

/* ========== MAIN CONTENT ========== */
.main-content {
flex: 1;
display: flex;
flex-direction: column;
overflow-y: auto;
}

/* ========== TOP BAR ========== */
.top-bar {
background: white;
padding: 0.45rem 0.45rem;
display: flex;
align-items: center;
justify-content: space-between;
border-bottom: 1px solid #e2e8f0;
position: sticky;
top: 0;
z-index: 100;
}

.menu-toggle {
background: none;
border: none;
font-size: 1.2rem;
cursor: pointer;
color: #1a1a2e;
padding: 0.4rem;
transition: background 0.2s;
}

.menu-toggle:hover {
background: #f1f5f9;
}

.page-title {
font-size: 1.2rem;
font-weight: 600;
color: #1a1a2e;
}

.user-area {
position: relative;
cursor: pointer;
display: flex;
align-items: center;
height: 100%;
}

.user-info {
display: flex;
align-items: center;
gap: 0.8rem;
padding: 0.4rem 0.8rem;
transition: background 0.2s;
border-radius: 40px;
position: relative;
}

.user-info:hover {
background: #f1f5f9;
}

.user-text {
text-align: right;
}

.user-name-top {
font-size: 0.8rem;
font-weight: 600;
color: #1a1a2e;
}

.user-role-top {
font-size: 0.65rem;
color: #94a3b8;
}

.user-avatar-small {
width: 36px;
height: 36px;
background: #1a1a2e;
border-radius: 50%;
display: flex;
align-items: center;
justify-content: center;
font-size: 0.9rem;
font-weight: 600;
color: white;
text-transform: uppercase;
position: relative;
}

/* Indicador de flecha */
.avatar-indicator {
position: absolute;
bottom: -4px;
right: -4px;
width: 16px;
height: 16px;
background: white;
border-radius: 50%;
display: flex;
align-items: center;
justify-content: center;
box-shadow: 0 1px 2px rgba(0,0,0,0.1);
border: 1px solid #e2e8f0;
}

.avatar-indicator img {
width: 10px;
height: 10px;
}

/* Dropdown menu */
.dropdown-menu {
position: absolute;
top: 100%;
right: 0;
margin-top: 12px;
background: white;
border: 1px solid #e2e8f0;
box-shadow: 0 4px 12px rgba(0,0,0,0.08);
min-width: 140px;
display: none;
z-index: 200;
overflow: hidden;
}

.dropdown-menu.show {
display: block;
}

.dropdown-item {
display: flex;
align-items: center;
gap: 10px;
padding: 0.7rem 1rem;
color: #64748b;
text-decoration: none;
font-size: 0.75rem;
transition: background 0.2s;
cursor: pointer;
border-bottom: 1px solid #f1f5f9;
}

.dropdown-item:last-child {
border-bottom: none;
}

.dropdown-item:hover {
background: #f8fafc;
color: #1a1a2e;
}

.dropdown-item.logout {
color: #d83752;
}

.dropdown-item.logout:hover {
background: #fee9ed;
}

.dropdown-item .icon-img {
width: 16px;
height: 16px;
}

.dropdown-item .icon-img img {
width: 16px;
height: 16px;
}

/* ========== CONTENT AREA ========== */
.content {
padding: 1.5rem;
overflow-y: auto;
}

/* ========== SCROLLBAR ========== */
::-webkit-scrollbar {
width: 6px;
}

::-webkit-scrollbar-track {
background: #f1f5f9;
}

::-webkit-scrollbar-thumb {
background: #cbd5e1;
}

/* ========== RESPONSIVE ========== */
@media (max-width: 768px) {
.sidebar {
position: fixed;
left: -220px;
z-index: 200;
height: 100vh;
background: white;
}
.sidebar.mobile-open {
left: 0;
}
.sidebar.collapsed {
width: 220px;
}
.mobile-overlay {
position: fixed;
top: 0;
left: 0;
right: 0;
bottom: 0;
background: rgba(0,0,0,0.3);
z-index: 150;
display: none;
}
.mobile-overlay.active {
display: block;
}
.user-text {
display: none;
}
}

@media (min-width: 769px) {
.mobile-overlay {
display: none;
}
}
</style>
</head>
<body>
<div class="app-container">
<aside class="sidebar" id="sidebar">
<div class="sidebar-header">
<img src="${pageContext.request.contextPath}/assets/resources/images/tijerasLogo.png" alt="ClipPay">
<h1>MADDOG</h1>
<p>barbería</p>
</div>

<nav class="sidebar-nav">
<a class="nav-item active" data-page="dashboard">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/chart-bar.svg" alt="dashboard"></span>
<span class="text">Dashboard</span>
</a>
<a class="nav-item" data-page="cortes">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/scissors.svg" alt="cortes"></span>
<span class="text">Cortes</span>
</a>
<a class="nav-item" data-page="empleados">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/user-group.svg" alt="empleados"></span>
<span class="text">Empleados</span>
</a>
<a class="nav-item" data-page="clientes">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/users.svg" alt="clientes"></span>
<span class="text">Clientes</span>
</a>
<a class="nav-item" data-page="recibos">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/document-text.svg" alt="recibos"></span>
<span class="text">Recibos</span>
</a>
<a class="nav-item" data-page="caja">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/currency-dollar.svg" alt="caja"></span>
<span class="text">Caja</span>
</a>
<a class="nav-item" data-page="reportes">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/chart-pie.svg" alt="reportes"></span>
<span class="text">Reportes</span>
</a>
<a class="nav-item" data-page="horarios">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/calendar.svg" alt="horarios"></span>
<span class="text">Horarios</span>
</a>
<a class="nav-item" data-page="configuracion">
<span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/cog-6-tooth.svg" alt="configuracion"></span>
<span class="text">Configuración</span>
</a>
</nav>
</aside>

<div class="mobile-overlay" id="mobileOverlay"></div>

<main class="main-content">
<header class="top-bar">
<button class="menu-toggle" id="menuToggle">☰</button>
<h1 class="page-title" id="pageTitle">Dashboard</h1>
<div class="user-area" id="userArea">
<div class="user-info">
<div class="user-text">
<div class="user-name-top">${sessionScope.username != null ? sessionScope.username : "Usuario"}</div>
<div class="user-role-top">${sessionScope.rol != null ? sessionScope.rol : "Rol"}</div>
</div>
<div class="user-avatar-small" id="userAvatar">
${sessionScope.username != null ? sessionScope.username.substring(0,1).toUpperCase() : "U"}
<div class="avatar-indicator" id="avatarIndicator">
<img src="${pageContext.request.contextPath}/assets/resources/icons/chevron-down.svg" alt="▼">
</div>
</div>
</div>
<div class="dropdown-menu" id="dropdownMenu">
<div class="dropdown-item logout" id="logoutBtn">
<span class="icon-img"><img src="${pageContext.request.contextPath}/assets/resources/icons/arrow-right-start-on-rectangle.svg" alt="salir"></span>
<span>Cerrar Sesión</span>
</div>
</div>
</div>
</header>

<div class="content" id="contentArea">
<div id="page-dashboard" class="page-content">
<!-- Contenido del Dashboard -->
</div>
<div id="page-cortes" class="page-content" style="display:none;">
<!-- Contenido de Cortes -->
</div>
<div id="page-empleados" class="page-content" style="display:none;">
<!-- Contenido de Empleados -->
</div>
<div id="page-clientes" class="page-content" style="display:none;">
<!-- Contenido de Clientes -->
</div>
<div id="page-recibos" class="page-content" style="display:none;">
<!-- Contenido de Recibos -->
</div>
<div id="page-caja" class="page-content" style="display:none;">
<!-- Contenido de Caja -->
</div>
<div id="page-reportes" class="page-content" style="display:none;">
<!-- Contenido de Reportes -->
</div>
<div id="page-horarios" class="page-content" style="display:none;">
<!-- Contenido de Horarios -->
</div>
<div id="page-configuracion" class="page-content" style="display:none;">
<!-- Contenido de Configuración -->
</div>
</div>
</main>
</div>

<script>
const sidebar = document.getElementById('sidebar');
const menuToggle = document.getElementById('menuToggle');
const mobileOverlay = document.getElementById('mobileOverlay');
const userArea = document.getElementById('userArea');
const dropdownMenu = document.getElementById('dropdownMenu');
const avatarIndicator = document.getElementById('avatarIndicator');
const indicatorIcon = avatarIndicator.querySelector('img');

function updateIndicatorIcon(isOpen) {
if (isOpen) {
indicatorIcon.src = '${pageContext.request.contextPath}/assets/resources/icons/chevron-up.svg';
indicatorIcon.alt = '▲';
} else {
indicatorIcon.src = '${pageContext.request.contextPath}/assets/resources/icons/chevron-down.svg';
indicatorIcon.alt = '▼';
}
}

menuToggle.addEventListener('click', () => {
if (window.innerWidth <= 768) {
sidebar.classList.toggle('mobile-open');
mobileOverlay.classList.toggle('active');
} else {
sidebar.classList.toggle('collapsed');
}
});

mobileOverlay.addEventListener('click', () => {
sidebar.classList.remove('mobile-open');
mobileOverlay.classList.remove('active');
});

userArea.addEventListener('click', (e) => {
e.stopPropagation();
const isOpen = dropdownMenu.classList.toggle('show');
updateIndicatorIcon(isOpen);
});

document.addEventListener('click', () => {
if (dropdownMenu.classList.contains('show')) {
dropdownMenu.classList.remove('show');
updateIndicatorIcon(false);
}
});

const pages = {
dashboard: document.getElementById('page-dashboard'),
cortes: document.getElementById('page-cortes'),
empleados: document.getElementById('page-empleados'),
clientes: document.getElementById('page-clientes'),
recibos: document.getElementById('page-recibos'),
caja: document.getElementById('page-caja'),
reportes: document.getElementById('page-reportes'),
horarios: document.getElementById('page-horarios'),
configuracion: document.getElementById('page-configuracion')
};

const pageTitles = {
dashboard: 'Dashboard',
cortes: 'Cortes',
empleados: 'Empleados',
clientes: 'Clientes',
recibos: 'Recibos',
caja: 'Caja',
reportes: 'Reportes',
horarios: 'Horarios',
configuracion: 'Configuración'
};

function showPage(pageId) {
Object.keys(pages).forEach(key => {
if (pages[key]) pages[key].style.display = 'none';
});
if (pages[pageId]) pages[pageId].style.display = 'block';
document.getElementById('pageTitle').innerText = pageTitles[pageId] || pageId;

document.querySelectorAll('.nav-item').forEach(item => {
item.classList.remove('active');
if (item.getAttribute('data-page') === pageId) {
item.classList.add('active');
}
});

if (window.innerWidth <= 768) {
sidebar.classList.remove('mobile-open');
mobileOverlay.classList.remove('active');
}
}

document.querySelectorAll('.nav-item[data-page]').forEach(item => {
item.addEventListener('click', (e) => {
e.preventDefault();
showPage(item.getAttribute('data-page'));
});
});

document.getElementById('logoutBtn').addEventListener('click', () => {
window.location.href = '${pageContext.request.contextPath}/logout';
});

showPage('dashboard');
</script>
</body>
</html>