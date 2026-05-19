<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vista Previa - Periodos - ClipPay</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #f5f5f5;
            color: #1a1a1a;
        }
        
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }
        
        .card {
            background: #ffffff;
            border: 1px solid #e5e5e5;
            border-radius: 12px;
            padding: 2rem;
        }
        
        h1 {
            font-size: 1.25rem;
            font-weight: 500;
            letter-spacing: -0.3px;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #000000;
        }
        
        h1 img {
            width: 20px;
            height: 20px;
            filter: brightness(0);
        }
        
        .subtitle {
            color: #64748b;
            font-size: 0.75rem;
            margin-bottom: 1.5rem;
        }
        
        .stats {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }
        
        .stat-card {
            flex: 1;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 0.75rem;
            text-align: center;
        }
        
        .stat-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e293b;
        }
        
        .stat-label {
            font-size: 0.7rem;
            color: #64748b;
            margin-top: 0.25rem;
        }
        
        .table-wrapper {
            margin: 1.5rem 0;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.75rem;
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
        
        .badge-nuevo {
            display: inline-block;
            background: #f0fdf4;
            color: #166534;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.7rem;
            font-weight: 500;
        }
        
        .badge-existente {
            display: inline-block;
            background: #fef2f2;
            color: #991b1b;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.7rem;
            font-weight: 500;
        }
        
        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        
        .btn {
            flex: 1;
            padding: 0.625rem;
            font-size: 0.75rem;
            font-weight: 500;
            border-radius: 6px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            border: none;
            transition: all 0.2s ease;
        }
        
        .btn img {
            width: 14px;
            height: 14px;
        }
        
        .btn-primary {
            background: #1a1a1a;
            color: #ffffff;
        }
        
        .btn-primary:hover {
            background: #333333;
        }
        
        .btn-primary img {
            filter: brightness(0) invert(1);
        }
        
        .btn-secondary {
            background: #ffffff;
            color: #1a1a1a;
            border: 1px solid #e5e5e5;
        }
        
        .btn-secondary:hover {
            background: #f5f5f5;
        }
        
        .btn-secondary img {
            filter: brightness(0);
        }
        
        .alert {
            padding: 0.625rem 0.875rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .alert img {
            width: 14px;
            height: 14px;
        }
        
        .alert-warning {
            background: #fffbeb;
            color: #b45309;
            border: 1px solid #fde68a;
        }
        
        @media (max-width: 560px) {
            .container {
                margin: 1rem auto;
            }
            .card {
                padding: 1.5rem;
            }
            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h1>
            <img src="${pageContext.request.contextPath}/assets/resources/icons/eye.svg" alt="preview">
            Vista Previa
        </h1>
        <div class="subtitle">
            Periodos del ${mesInicio} al ${mesFin} de ${anio}
        </div>
        
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">${totalPrevisualizados}</div>
                <div class="stat-label">Total periodos</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" style="color: #10b981;">${totalNuevos}</div>
                <div class="stat-label">Nuevos por crear</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" style="color: #ef4444;">${totalExistentes}</div>
                <div class="stat-label">Ya existentes</div>
            </div>
        </div>
        
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Periodo</th>
                        <th>Rango</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${preview}" var="p">
                        <tr>
                            <td>${p.nombre}</td>
                            <td>${p.rango}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.yaExiste}">
                                        <span class="badge-existente">Ya existe</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-nuevo">Nuevo</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${totalNuevos == 0}">
            <div class="alert alert-warning">
                <img src="${pageContext.request.contextPath}/assets/resources/icons/exclamation-triangle.svg" alt="warning">
                No hay periodos nuevos para crear. Todos los periodos en este rango ya existen.
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin/periodos" method="post">
            <input type="hidden" name="action" value="crear">
            <input type="hidden" name="mesInicio" value="${mesInicio}">
            <input type="hidden" name="mesFin" value="${mesFin}">
            <input type="hidden" name="anio" value="${anio}">
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary" ${totalNuevos == 0 ? 'disabled' : ''}>
                    <img src="${pageContext.request.contextPath}/assets/resources/icons/check.svg" alt="crear">
                    Crear ${totalNuevos} periodos
                </button>
                <a href="${pageContext.request.contextPath}/admin/periodos?action=nuevo" class="btn btn-secondary">
                    Volver atras
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>