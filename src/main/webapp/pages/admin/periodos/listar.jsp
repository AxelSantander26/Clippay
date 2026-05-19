<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
    <title>Periodos de Pago - ClipPay</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f5f5f5;
            display: flex;
        }

        .modulo-container {
            flex: 1;
            min-height: 100vh;
            padding: 2rem;
            overflow-x: auto;
            transition: all 0.3s ease;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .header h1 {
            font-size: 1.25rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #000;
        }

        .header h1 img {
            width: 20px;
            height: 20px;
        }

        .btn-group {
            display: flex;
            gap: 0.75rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.625rem 1.25rem;
            font-size: 0.875rem;
            font-weight: 500;
            font-family: 'Inter', sans-serif;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
            white-space: nowrap;
        }

        .btn img {
            width: 18px;
            height: 18px;
        }

        .btn-primary {
            background: #1e293b;
            color: white;
            border: 1px solid #1e293b;
        }

        .btn-primary:hover {
            background: #0f172a;
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .btn-primary img {
            filter: brightness(0) invert(1);
        }

        .alert {
            padding: 0.75rem 1rem;
            border-radius: 6px;
            margin-bottom: 1.5rem;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-success {
            background: #f0fdf4;
            color: #166534;
            border: 1px solid #dcfce7;
        }

        .alert-error {
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fee2e2;
        }

        .table-wrapper {
            background: white;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.75rem;
            min-width: 700px;
        }

        th {
            text-align: left;
            padding: 0.75rem 1rem;
            background: #fafafa;
            font-weight: 500;
            color: #737373;
            border-bottom: 1px solid #e5e5e5;
            font-size: 0.7rem;
            text-transform: uppercase;
        }

        td {
            padding: 0.75rem 1rem;
            border-bottom: 1px solid #e5e5e5;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .periodo-actual {
            background: linear-gradient(90deg, #eff6ff 0%, #ffffff 100%);
            border-left: 4px solid #3b82f6;
            box-shadow: 0 1px 3px rgba(59,130,246,0.1);
        }

        .actual-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            background: #3b82f6;
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 20px;
            font-size: 0.65rem;
            font-weight: 500;
            margin-left: 0.5rem;
        }

        .actual-badge img {
            width: 12px;
            height: 12px;
            filter: brightness(0) invert(1);
        }

        .badge-abierto {
            display: inline-block;
            background: #f0fdf4;
            color: #166534;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.7rem;
            font-weight: 500;
        }

        .badge-cerrado {
            display: inline-block;
            background: #fef2f2;
            color: #991b1b;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.7rem;
            font-weight: 500;
        }

        .acciones {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .accion-cerrar {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            padding: 0.25rem 0.5rem;
            font-size: 0.7rem;
            border-radius: 4px;
            text-decoration: none;
            background: #fef2f2;
            color: #991b1b;
        }

        .accion-cerrar:hover {
            background: #fee2e2;
        }

        .info-box {
            background: #eff6ff;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.75rem;
            color: #1e40af;
            border: 1px solid #bfdbfe;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .info-box img {
            width: 20px;
            height: 20px;
        }

        .periodo-nombre {
            font-weight: 500;
            color: #1e293b;
        }

        @media (max-width: 768px) {
            .modulo-container {
                padding: 1rem;
            }
            
            .btn {
                padding: 0.5rem 1rem;
                font-size: 0.75rem;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/components/sidebar.jsp"/>

    <div class="modulo-container">
        <div class="header">
            <h1>
                <img src="${pageContext.request.contextPath}/assets/resources/icons/calendar.svg" alt="periodos">
                Periodos de Pago
            </h1>

            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/admin/periodos?action=nuevo"
                   class="btn btn-primary">
                    <img src="${pageContext.request.contextPath}/assets/resources/icons/plus.svg" alt="nuevo" width="18" height="18">
                    Generar Periodos
                </a>
            </div>
        </div>

        <div class="info-box">
            <img src="${pageContext.request.contextPath}/assets/resources/icons/information-circle.svg" alt="info">
            <div>
                <strong>Periodo actual:</strong> Es la quincena en la que nos encontramos hoy.
                Los periodos deben cerrarse manualmente despues de pagar la nomina correspondiente.
            </div>
        </div>

        <% if (session.getAttribute("mensaje") != null) { %>
            <div class="alert alert-success">
                <img src="${pageContext.request.contextPath}/assets/resources/icons/check-circle.svg" alt="check" width="14" height="14">
                ${sessionScope.mensaje}
            </div>
            <% session.removeAttribute("mensaje"); %>
        <% } %>

        <% if (session.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <img src="${pageContext.request.contextPath}/assets/resources/icons/exclamation-circle.svg" alt="error" width="14" height="14">
                ${sessionScope.error}
            </div>
            <% session.removeAttribute("error"); %>
        <% } %>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Periodo</th>
                        <th>Fecha Inicio</th>
                        <th>Fecha Fin</th>
                        <th>Estado</th>
                        <th>Fecha Cierre</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${periodos}" var="per">
                        <c:set var="esPeriodoActual" value="false" />
                        <%
                            pageContext.setAttribute("fechaActual", LocalDate.now());
                        %>
                        <c:if test="${per.perFechaInicio le fechaActual and per.perFechaFin ge fechaActual and !per.perCerrado}">
                            <c:set var="esPeriodoActual" value="true" />
                        </c:if>
                        
                        <tr class="${esPeriodoActual ? 'periodo-actual' : ''}">
                            <td class="periodo-nombre">
                                ${per.perNombre}
                                <c:if test="${esPeriodoActual}">
                                    <span class="actual-badge">
                                        <img src="${pageContext.request.contextPath}/assets/resources/icons/clock.svg" alt="actual" width="12" height="12">
                                        Actual
                                    </span>
                                </c:if>
                            </td>
                            <td>${per.perFechaInicio}</td>
                            <td>${per.perFechaFin}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${per.perCerrado}">
                                        <span class="badge-cerrado">Cerrado</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-abierto">Abierto</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${per.perCerrado}">
                                    ${per.perFechaCierre}
                                </c:if>
                                <c:if test="${!per.perCerrado}">
                                    —
                                </c:if>
                            </td>
                            <td class="acciones">
                                <c:if test="${!per.perCerrado}">
                                    <a class="accion-cerrar" 
                                       href="${pageContext.request.contextPath}/admin/periodos?action=cerrar&id=${per.perId}"
                                       onclick="return confirm('¿Cerrar el periodo \"${per.perNombre}\"? Esta accion no se puede deshacer.')">
                                        <img src="${pageContext.request.contextPath}/assets/resources/icons/lock-closed.svg" alt="cerrar" width="12" height="12">
                                        Cerrar Periodo
                                    </a>
                                </c:if>
                                <c:if test="${per.perCerrado}">
                                    <span style="color: #94a3b8; font-size: 0.7rem;">Cerrado</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty periodos}">
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 3rem; color: #94a3b8;">
                                <img src="${pageContext.request.contextPath}/assets/resources/icons/calendar.svg" alt="empty" width="24" height="24" style="margin-bottom: 0.5rem; opacity: 0.5;"><br>
                                No hay periodos de pago registrados.
                                <br><br>
                                <a href="${pageContext.request.contextPath}/admin/periodos?action=nuevo" style="color: #1e293b;">Generar periodos</a>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <c:if test="${not empty periodos}">
            <div style="margin-top: 1rem; font-size: 0.7rem; color: #94a3b8; text-align: center;">
                Mostrando ${periodos.size()} periodos | Ordenados del mas antiguo al mas reciente
            </div>
        </c:if>
    </div>

</body>
</html>