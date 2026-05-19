<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Gestionar Servicios - ClipPay</title>
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

        .btn-secondary {
            background: white;
            color: #1e293b;
            border: 1px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }

        .btn-secondary img {
            filter: brightness(0) saturate(100%) invert(11%) sepia(91%) saturate(1692%) hue-rotate(199deg) brightness(96%) contrast(94%);
        }

        .btn-primary img {
            filter: brightness(0) invert(1);
        }

        .btn-divider {
            width: 1px;
            height: 30px;
            background: #e2e8f0;
            margin: 0 0.25rem;
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
            min-width: 600px;
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

        .precio {
            font-weight: 600;
            color: #1e293b;
        }

        .comision {
            color: #10b981;
            font-weight: 500;
        }

        .estado {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
        }

        .estado-activo {
            color: #10b981;
        }

        .estado-inactivo {
            color: #ef4444;
        }

        .acciones {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .accion {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            padding: 0.25rem 0.5rem;
            font-size: 0.7rem;
            border-radius: 4px;
            text-decoration: none;
        }

        .accion-editar {
            background: #f5f5f5;
            color: #1a1a1a;
        }

        .accion-eliminar {
            background: #fef2f2;
            color: #991b1b;
        }

        .accion-reactivar {
            background: #f0fdf4;
            color: #166534;
        }

        @media (max-width: 768px) {
            .modulo-container {
                padding: 1rem;
            }

            .accion span {
                display: none;
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
                <img src="${pageContext.request.contextPath}/assets/resources/icons/scissors.svg" alt="">
                Gestionar Servicios
            </h1>

            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/admin/servicios?mostrarInactivos=${!mostrandoInactivos}"
                   class="btn ${!mostrandoInactivos ? 'btn-primary' : 'btn-secondary'}">
                    <img src="${pageContext.request.contextPath}/assets/resources/icons/check-circle.svg" alt="activos" width="18" height="18">
                    Activos
                </a>

                <a href="${pageContext.request.contextPath}/admin/servicios?mostrarInactivos=true"
                   class="btn ${mostrandoInactivos ? 'btn-primary' : 'btn-secondary'}">
                    <img src="${pageContext.request.contextPath}/assets/resources/icons/square-2-stack.svg" alt="todos" width="18" height="18">
                    Todos
                </a>

                <div class="btn-divider"></div>

                <a href="${pageContext.request.contextPath}/admin/servicios?action=nuevo"
                   class="btn btn-primary">
                    <img src="${pageContext.request.contextPath}/assets/resources/icons/plus.svg" alt="nuevo" width="18" height="18">
                    Nuevo Servicio
                </a>
            </div>
        </div>

        <% if (session.getAttribute("mensaje") != null) { %>
            <div class="alert alert-success">
                ${sessionScope.mensaje}
            </div>
            <% session.removeAttribute("mensaje"); %>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                ${error}
            </div>
        <% } %>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Servicio</th>
                        <th>Precio</th>
                        <th>Comisión</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${servicios}" var="serv">
                        <tr>
                            <td>${serv.serId}</td>
                            <td>${serv.serNombre}</td>
                            <td class="precio">S/ ${serv.serPrecio}</td>
                            <td class="comision">${serv.serComisionPorcentaje}%</td>
                            <td>
                                <span class="estado ${serv.serActivo ? 'estado-activo' : 'estado-inactivo'}">
                                    ${serv.serActivo ? 'Activo' : 'Inactivo'}
                                </span>
                            </td>
                            <td class="acciones">
                                <c:if test="${serv.serActivo}">
                                    <a class="accion accion-editar" 
                                       href="${pageContext.request.contextPath}/admin/servicios?action=editar&id=${serv.serId}">
                                        Editar
                                    </a>
                                    
                                    <a class="accion accion-eliminar" 
                                       href="${pageContext.request.contextPath}/admin/servicios?action=eliminar&id=${serv.serId}"
                                       onclick="return confirm('¿Desactivar servicio "${serv.serNombre}"?')">
                                        Desactivar
                                    </a>
                                </c:if>
                                
                                <c:if test="${!serv.serActivo}">
                                    <a class="accion accion-reactivar" 
                                       href="${pageContext.request.contextPath}/admin/servicios?action=reactivar&id=${serv.serId}"
                                       onclick="return confirm('¿Reactivar servicio "${serv.serNombre}"?')">
                                        Reactivar
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty servicios}">
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 3rem; color: #94a3b8;">
                                No hay servicios registrados
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>