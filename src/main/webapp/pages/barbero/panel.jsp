<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
<title>ClipPay | Panel Barbero</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<style>
:root {
    --primary: #5d87a8;
    --primary-dark: #4f7391;
    --text: #1e293b;
    --gray: #64748b;
    --bg: #f8fafc;
    --red: #dc2626;
    --white: #ffffff;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', sans-serif;
    background: var(--bg);
    min-height: 100vh;
}

/* HEADER */
.header {
    background: #ffffff;
    padding: 18px;
    border-bottom: 1px solid #eef2f7;
}

.header-row {
    display: flex;
    gap: 10px;
    align-items: stretch;
}

/* PANEL AZUL TURNO */
.shift-panel {
    flex: 1.4;
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    border-radius: 22px;
    padding: 14px 16px;
    color: white;
    display: flex;
    flex-direction: column;
    justify-content: center;
    box-shadow: 0 8px 18px rgba(93, 135, 168, 0.18);
}

.shift-label {
    font-size: 10px;
    text-transform: uppercase;
    letter-spacing: 1px;
    opacity: 0.78;
    font-weight: 700;
    margin-bottom: 6px;
}

.shift-time {
    font-size: 22px;
    font-weight: 900;
    letter-spacing: -1px;
    line-height: 1;
}

.shift-time span {
    font-size: 10px;
    opacity: 0.82;
}

.shift-date {
    margin-top: 8px;
    font-size: 11px;
    opacity: 0.82;
    font-weight: 500;
}

/* PANEL USUARIO */
.user-panel {
    flex: 0.7;
    background: #fff;
    border-radius: 22px;
    padding: 12px 14px;
    border: 1px solid #eef2f7;
    box-shadow: 0 4px 10px rgba(15, 23, 42, 0.04);
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;
    cursor: pointer;
    transition: 0.2s;
}

.user-panel:active {
    transform: scale(0.99);
}

.user-info {
    display: flex;
    align-items: center;
    gap: 10px;
    min-width: 0;
}

.user-icon {
    width: 34px;
    height: 34px;
    flex-shrink: 0;
}

.user-icon img {
    width: 34px;
    height: 34px;
}

.user-text {
    min-width: 0;
}

.user-name {
    font-size: 14px;
    font-weight: 800;
    color: var(--text);
    line-height: 1.1;
    letter-spacing: -0.2px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.user-role {
    margin-top: 4px;
    font-size: 10px;
    font-weight: 800;
    color: var(--primary);
    text-transform: uppercase;
    letter-spacing: 1px;
}

.arrow-indicator {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    padding-left: 6px;
    flex-shrink: 0;
}

.arrow-indicator img {
    width: 22px;
    height: 22px;
    transition: 0.2s;
}

.user-panel.active .arrow-indicator img {
    transform: rotate(180deg);
}

.dropdown {
    position: absolute;
    top: calc(100% + 10px);
    right: 0;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-6px);
    transition: 0.22s ease;
    z-index: 100;
}

.user-panel.active .dropdown {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.logout-btn {
    border: none;
    background: linear-gradient(135deg, #ef4444, var(--red));
    color: white;
    padding: 13px 18px;
    border-radius: 15px;
    font-size: 11px;
    font-weight: 800;
    letter-spacing: 0.3px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
    white-space: nowrap;
    box-shadow: 0 10px 22px rgba(220, 38, 38, 0.28);
    transition: 0.2s;
}

.logout-btn:active {
    transform: scale(0.97);
}

.logout-btn img {
    width: 14px;
    height: 14px;
}

/* GRID PRINCIPAL */
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 10px;
    padding: 20px;
    background-color: var(--bg);
}

.grid-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100px;
    background: #fff;
    border-radius: 18px;
    border: 1px solid #f1f5f9;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    text-align: center;
    transition: all 0.2s ease;
    cursor: pointer;
}

.grid-item:active {
    transform: scale(0.97);
}

.grid-item img {
    width: 24px;
    height: 24px;
    margin-bottom: 8px;
}

.grid-item span {
    font-size: 10px;
    font-weight: 700;
    color: var(--text);
    text-transform: uppercase;
    line-height: 1.2;
}

.grid-item.action {
    background-color: #fef2f2;
    border: 1px solid #fee2e2;
}

/* SECCIÓN ÚLTIMAS COMISIONES */
.recent-section {
    padding: 0 20px 30px;
    background-color: var(--bg);
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.section-title {
    font-size: 14px;
    font-weight: 700;
    color: var(--gray);
}

.view-more-btn {
    background: none;
    border: none;
    color: var(--primary);
    font-size: 12px;
    font-weight: 700;
    cursor: pointer;
    text-transform: uppercase;
}

.view-more-btn:hover {
    text-decoration: underline;
}

.list-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px;
    background: #fff;
    margin-bottom: 10px;
    border-radius: 15px;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

.service-info .id-tag {
    font-size: 10px;
    font-weight: 900;
    color: var(--primary);
    display: block;
    margin-bottom: 3px;
}

.service-info .date {
    font-size: 12px;
    font-weight: 500;
    color: var(--gray);
}

.commission-badge {
    margin-top: 6px;
    display: inline-block;
    padding: 5px 10px;
    border-radius: 8px;
    background: #ecfdf5;
    color: #059669;
    font-size: 12px;
    font-weight: 800;
}

.price-status {
    text-align: right;
}

.total-amount {
    display: block;
    font-size: 14px;
    font-weight: 800;
    color: var(--text);
    margin-bottom: 4px;
}

.status-badge {
    padding: 4px 8px;
    border-radius: 6px;
    font-size: 9px;
    font-weight: 800;
    text-transform: uppercase;
}

.earned {
    background: #ecfdf5;
    color: #059669;
}

.pending {
    background: #fff1f2;
    color: #e11d48;
}

/* MODAL */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(3px);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    visibility: hidden;
    opacity: 0;
    transition: all 0.2s ease;
}

.modal-overlay.active {
    visibility: visible;
    opacity: 1;
}

.modal-card {
    background: white;
    width: 280px;
    border-radius: 28px;
    padding: 24px 20px 20px;
    text-align: center;
    box-shadow: 0 20px 35px -8px rgba(0, 0, 0, 0.2);
}

.modal-card h3 {
    font-size: 18px;
    font-weight: 700;
    margin-bottom: 8px;
    color: var(--text);
}

.modal-card p {
    font-size: 13px;
    color: var(--gray);
    margin-bottom: 24px;
}

.modal-actions {
    display: flex;
    gap: 12px;
    justify-content: center;
}

.modal-cancel {
    background: #f1f5f9;
    border: none;
    padding: 10px 20px;
    border-radius: 40px;
    font-weight: 600;
    font-size: 13px;
    cursor: pointer;
    color: var(--gray);
}

.modal-confirm {
    background: var(--red);
    border: none;
    padding: 10px 20px;
    border-radius: 40px;
    font-weight: 600;
    font-size: 13px;
    cursor: pointer;
    color: white;
}

.modal-confirm:hover {
    background-color: #b91c1c;
}

.modal-cancel:hover {
    background-color: #e2e8f0;
}
</style>
</head>
<body>

<div class="header">
    <div class="header-row">
        <div class="shift-panel">
            <div class="shift-label">Turno actual</div>
            <div class="shift-time">
                8:00 <span>AM</span> — 5:00 <span>PM</span>
            </div>
            <div class="shift-date">
                <%
                    LocalDate hoy = LocalDate.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, d 'de' MMMM 'de' yyyy", new Locale("es", "ES"));
                    String fecha = hoy.format(formatter);
                    fecha = fecha.substring(0, 1).toUpperCase() + fecha.substring(1);
                %>
                <%= fecha %>
            </div>
        </div>

        <div class="user-panel" id="userPanel">
            <div class="user-info">
                <div class="user-icon">
                    <img src="${pageContext.request.contextPath}/assets/resources/icons/user-circle.svg" alt="user">
                </div>
                <div class="user-text">
                    <div class="user-name">${nombreCompleto != null ? nombreCompleto : "Usuario"}</div>
                    <div class="user-role">${rol != null ? rol : "Barbero"}</div>
                </div>
            </div>
            <div class="arrow-indicator">
                <img src="${pageContext.request.contextPath}/assets/resources/icons/chevron-down.svg" alt="▼">
            </div>
            <div class="dropdown">
                <button class="logout-btn" id="logoutBtn">
                    <img src="${pageContext.request.contextPath}/assets/resources/icons/arrow-right-start-on-rectangle.svg" alt="salir">
                    Cerrar sesión
                </button>
            </div>
        </div>
    </div>
</div>

<div class="grid-container">
    <div class="grid-item" data-modulo="asistencia">
        <img src="${pageContext.request.contextPath}/assets/resources/icons/clock.svg" alt="asistencia">
        <span>Control<br>Asistencia</span>
    </div>
    <div class="grid-item" data-modulo="calendario">
        <img src="${pageContext.request.contextPath}/assets/resources/icons/calendar.svg" alt="calendario">
        <span>Calendario<br>Laboral</span>
    </div>
    <div class="grid-item" data-modulo="boletas">
        <img src="${pageContext.request.contextPath}/assets/resources/icons/document-text.svg" alt="boletas">
        <span>Boletas<br>de Pago</span>
    </div>
    <div class="grid-item" data-modulo="permisos">
        <img src="${pageContext.request.contextPath}/assets/resources/icons/briefcase.svg" alt="permisos">
        <span>Gestionar<br>Permisos</span>
    </div>
    <div class="grid-item action" data-modulo="venta">
        <img src="${pageContext.request.contextPath}/assets/resources/icons/plus.svg" alt="venta">
        <span>Registrar<br>Venta</span>
    </div>
    <div class="grid-item" data-modulo="desempeno">
        <img src="${pageContext.request.contextPath}/assets/resources/icons/chart-bar.svg" alt="desempeño">
        <span>Mi<br>Desempeño</span>
    </div>
</div>

<div class="recent-section">
    <div class="section-header">
        <span class="section-title">Últimas Comisiones</span>
        <button class="view-more-btn" id="viewAllBtn">Ver Todas</button>
    </div>

    <!-- Comisiones simuladas directamente en el JSP -->
    <div class="list-item">
        <div class="service-info">
            <span class="id-tag">ID: #00842</span>
            <p class="date">20 Mayo · 14:20</p>
            <div class="commission-badge">Comisión: S/ 27.00</div>
        </div>
        <div class="price-status">
            <span class="total-amount">S/ 120.00</span>
            <span class="status-badge earned">PAGADO</span>
        </div>
    </div>

    <div class="list-item">
        <div class="service-info">
            <span class="id-tag">ID: #00845</span>
            <p class="date">20 Mayo · 15:45</p>
            <div class="commission-badge">Comisión: S/ 12.50</div>
        </div>
        <div class="price-status">
            <span class="total-amount">S/ 45.00</span>
            <span class="status-badge pending">EN CAJA</span>
        </div>
    </div>

    <div class="list-item">
        <div class="service-info">
            <span class="id-tag">ID: #00849</span>
            <p class="date">19 Mayo · 16:30</p>
            <div class="commission-badge">Comisión: S/ 6.00</div>
        </div>
        <div class="price-status">
            <span class="total-amount">S/ 25.00</span>
            <span class="status-badge earned">PAGADO</span>
        </div>
    </div>

    <div class="list-item">
        <div class="service-info">
            <span class="id-tag">ID: #00853</span>
            <p class="date">19 Mayo · 18:15</p>
            <div class="commission-badge">Comisión: S/ 18.00</div>
        </div>
        <div class="price-status">
            <span class="total-amount">S/ 80.00</span>
            <span class="status-badge earned">PAGADO</span>
        </div>
    </div>
</div>

<div id="logoutModal" class="modal-overlay">
    <div class="modal-card">
        <h3>Cerrar sesión</h3>
        <p>¿Seguro que deseas salir de tu cuenta?</p>
        <div class="modal-actions">
            <button class="modal-cancel" id="cancelLogout">Cancelar</button>
            <button class="modal-confirm" id="confirmLogout">Sí, salir</button>
        </div>
    </div>
</div>

<script>
const userPanel = document.getElementById('userPanel');
const logoutBtn = document.getElementById('logoutBtn');
const modal = document.getElementById('logoutModal');
const cancelBtn = document.getElementById('cancelLogout');
const confirmBtn = document.getElementById('confirmLogout');
const viewAllBtn = document.getElementById('viewAllBtn');

if (userPanel) {
    userPanel.addEventListener('click', function(e) {
        e.stopPropagation();
        userPanel.classList.toggle('active');
    });
}

document.addEventListener('click', function(e) {
    if (userPanel && !userPanel.contains(e.target)) {
        userPanel.classList.remove('active');
    }
});

if (logoutBtn) {
    logoutBtn.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        modal.classList.add('active');
        if (userPanel) userPanel.classList.remove('active');
    });
}

function closeModal() {
    modal.classList.remove('active');
}

if (cancelBtn) cancelBtn.addEventListener('click', closeModal);

if (confirmBtn) {
    confirmBtn.addEventListener('click', function() {
        window.location.href = '${pageContext.request.contextPath}/logout';
    });
}

if (modal) {
    modal.addEventListener('click', function(e) {
        if (e.target === modal) closeModal();
    });
}

if (viewAllBtn) {
    viewAllBtn.addEventListener('click', function() {
        alert('📋 Redirigiendo al historial completo de comisiones');
    });
}

const gridItems = document.querySelectorAll('.grid-item');
gridItems.forEach(item => {
    item.addEventListener('click', () => {
        const modulo = item.getAttribute('data-modulo');
        alert('🔧 Abriendo módulo: ' + modulo);
    });
});
</script>

</body>
</html>