<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    * {
        box-sizing: border-box;
    }

    /* SOLO LOS ESTILOS DEL SIDEBAR, nada de body ni main */
    .sidebar {
        width: 220px;
        height: 100vh;
        background: white;
        border-right: 1px solid #e2e8f0;
        display: flex;
        flex-direction: column;
        transition: width 0.3s ease;
        overflow-y: auto;
        flex-shrink: 0;
        position: sticky;
        top: 0;
    }

    .sidebar.collapsed {
        width: 70px;
    }

    .sidebar-header {
        padding: 1.5rem 0.75rem;
        text-align: center;
        border-bottom: 1px solid #e2e8f0;
        margin-bottom: 1rem;
        position: relative;
    }

    .menu-toggle {
        position: absolute;
        top: 12px;
        right: 12px;
        background: none;
        border: none;
        font-size: 1rem;
        cursor: pointer;
        color: #1a1a2e;
        padding: 0.4rem;
        border-radius: 8px;
        transition: background 0.2s ease;
    }

    .menu-toggle:hover {
        background: #f1f5f9;
    }

    .sidebar-header img {
        width: 90px;
        height: auto;
        margin-bottom: 0.5rem;
        transition: width 0.3s ease;
    }

    .sidebar-header h1 {
        font-size: 1rem;
        font-weight: 700;
        color: #1a1a2e;
        margin: 0;
    }

    .sidebar-header p {
        font-size: 0.75rem;
        color: #94a3b8;
        margin-top: 0.25rem;
    }

    .sidebar.collapsed .sidebar-header {
        padding: 1rem 0;
    }

    .sidebar.collapsed .sidebar-header img {
        width: 38px;
    }

    .sidebar.collapsed .sidebar-header h1,
    .sidebar.collapsed .sidebar-header p {
        display: none;
    }

    .sidebar-nav {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 4px;
        padding: 0 0.5rem;
    }

    .nav-item {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 0.75rem;
        color: #64748b;
        text-decoration: none;
        font-size: 0.82rem;
        font-weight: 500;
        border-radius: 10px;
        transition: all 0.2s ease;
        white-space: nowrap;
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

    .nav-item .icon img {
        width: 18px;
        height: 18px;
    }

    .sidebar.collapsed .nav-item {
        justify-content: center;
        padding: 0.75rem 0;
    }

    .sidebar.collapsed .nav-item .text {
        display: none;
    }

    .sidebar-user {
        margin-top: auto;
        padding: 1rem 0.5rem;
        border-top: 1px solid #e2e8f0;
        position: relative;
    }

    .user-area {
        cursor: pointer;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 0.5rem;
        border-radius: 12px;
        transition: background 0.2s ease;
    }

    .user-info:hover {
        background: #f1f5f9;
    }

    .user-text {
        flex: 1;
        overflow: hidden;
    }

    .user-name-top {
        font-size: 0.78rem;
        font-weight: 600;
        color: #1a1a2e;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .user-role-top {
        font-size: 0.68rem;
        color: #94a3b8;
    }

    .user-avatar-small {
        width: 38px;
        height: 38px;
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
        flex-shrink: 0;
    }

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
        border: 1px solid #e2e8f0;
    }

    .avatar-indicator img {
        width: 10px;
        height: 10px;
    }

    .sidebar.collapsed .user-text {
        display: none;
    }

    .sidebar.collapsed .user-info {
        justify-content: center;
    }

    .dropdown-menu {
        position: absolute;
        bottom: 72px;
        left: 10px;
        right: 10px;
        background: white;
        border: 1px solid #e2e8f0;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        border-radius: 10px;
        overflow: hidden;
        display: none;
        z-index: 300;
    }

    .dropdown-menu.show {
        display: block;
    }

    .dropdown-item {
        display: block;
        padding: 0.8rem 1rem;
        color: #64748b;
        text-decoration: none;
        font-size: 0.75rem;
        transition: background 0.2s ease;
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
</style>

<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <button class="menu-toggle" id="menuToggle">☰</button>
        <img src="${pageContext.request.contextPath}/assets/resources/images/tijerasLogo.png" alt="MADDOG">
        <h1>MADDOG</h1>
        <p>barbería</p>
    </div>

    <nav class="sidebar-nav">
        <a class="nav-item" href="${pageContext.request.contextPath}/dashboard">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/chart-bar.svg" alt=""></span>
            <span class="text">Dashboard</span>
        </a>
        <!-- EMPLEADOS - listo -->    
        <a class="nav-item" href="${pageContext.request.contextPath}/admin/empleados">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/user-group.svg" alt=""></span>
            <span class="text">Empleados</span>
        </a>
        <!-- Periodos de Pago - Listo -->
        <a class="nav-item" href="${pageContext.request.contextPath}/admin/periodos">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/calendar.svg" alt=""></span>
            <span class="text">Periodos</span>
        </a>
        <!-- SERVICIOS - listo -->
        <a class="nav-item" href="${pageContext.request.contextPath}/admin/servicios">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/scissors.svg" alt=""></span>
            <span class="text">Servicios</span>
        </a>

        <a class="nav-item" href="${pageContext.request.contextPath}/recibos">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/document-text.svg" alt=""></span>
            <span class="text">Recibos</span>
        </a>

        <a class="nav-item" href="${pageContext.request.contextPath}/caja">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/currency-dollar.svg" alt=""></span>
            <span class="text">Caja</span>
        </a>

        <a class="nav-item" href="${pageContext.request.contextPath}/reportes">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/chart-pie.svg" alt=""></span>
            <span class="text">Reportes</span>
        </a>

        <a class="nav-item" href="${pageContext.request.contextPath}/horarios">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/calendar.svg" alt=""></span>
            <span class="text">Horarios</span>
        </a>

        <a class="nav-item" href="${pageContext.request.contextPath}/configuracion">
            <span class="icon"><img src="${pageContext.request.contextPath}/assets/resources/icons/cog-6-tooth.svg" alt=""></span>
            <span class="text">Configuración</span>
        </a>
    </nav>

    <div class="sidebar-user">
        <div class="user-area" id="userArea">
            <div class="user-info">
                <div class="user-text">
                    <div class="user-name-top">${sessionScope.username != null ? sessionScope.username : "Usuario"}</div>
                    <div class="user-role-top">${sessionScope.rol != null ? sessionScope.rol : "Rol"}</div>
                </div>
                <div class="user-avatar-small">
                    ${sessionScope.username != null ? sessionScope.username.substring(0,1).toUpperCase() : "U"}
                    <div class="avatar-indicator">
                        <img src="${pageContext.request.contextPath}/assets/resources/icons/chevron-down.svg" alt="▼" id="indicatorIcon">
                    </div>
                </div>
            </div>
            <div class="dropdown-menu" id="dropdownMenu">
                <a class="dropdown-item logout" href="${pageContext.request.contextPath}/logout">Cerrar Sesión</a>
            </div>
        </div>
    </div>
</aside>

<script>
    const sidebar = document.getElementById('sidebar');
    const menuToggle = document.getElementById('menuToggle');
    const userArea = document.getElementById('userArea');
    const dropdownMenu = document.getElementById('dropdownMenu');
    const indicatorIcon = document.getElementById('indicatorIcon');

    if (menuToggle) {
        menuToggle.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
            localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
        });
    }

    if (localStorage.getItem('sidebarCollapsed') === 'true') {
        sidebar.classList.add('collapsed');
    }

    if (userArea) {
        userArea.addEventListener('click', (e) => {
            e.stopPropagation();
            const isOpen = dropdownMenu.classList.toggle('show');
            if (indicatorIcon) {
                indicatorIcon.src = isOpen
                        ? '${pageContext.request.contextPath}/assets/resources/icons/chevron-up.svg'
                        : '${pageContext.request.contextPath}/assets/resources/icons/chevron-down.svg';
            }
        });

        document.addEventListener('click', () => {
            dropdownMenu.classList.remove('show');
            if (indicatorIcon) {
                indicatorIcon.src = '${pageContext.request.contextPath}/assets/resources/icons/chevron-down.svg';
            }
        });
    }

    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-item').forEach(item => {
        const href = item.getAttribute('href');
        if (href && currentPath.startsWith(href)) {
            item.classList.add('active');
        }
    });
</script>