<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Generar Periodos - ClipPay</title>
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
            max-width: 560px;
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
            margin-bottom: 1.5rem;
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
        
        .info-box {
            background: #eff6ff;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.75rem;
            color: #1e40af;
            border: 1px solid #bfdbfe;
        }
        
        .info-box p {
            margin-bottom: 0.25rem;
        }
        
        .info-box p:last-child {
            margin-bottom: 0;
        }
        
        .field {
            margin-bottom: 1.25rem;
        }
        
        label {
            display: block;
            font-size: 0.7rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #737373;
            margin-bottom: 0.375rem;
        }
        
        select {
            width: 100%;
            padding: 0.625rem;
            font-size: 0.8rem;
            font-family: inherit;
            border: 1px solid #e5e5e5;
            border-radius: 6px;
            background: #ffffff;
            transition: all 0.2s ease;
            cursor: pointer;
        }
        
        select:focus {
            outline: none;
            border-color: #1a1a1a;
        }
        
        .row {
            display: flex;
            gap: 1rem;
        }
        
        .row .field {
            flex: 1;
        }
        
        .btn-group {
            margin-top: 1.5rem;
        }
        
        .btn {
            width: 100%;
            padding: 0.625rem;
            font-size: 0.75rem;
            font-weight: 500;
            border-radius: 6px;
            cursor: pointer;
            display: flex;
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
            margin-top: 0.75rem;
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
        
        .alert-error {
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fee2e2;
        }
        
        @media (max-width: 560px) {
            .container {
                margin: 1rem auto;
            }
            .card {
                padding: 1.5rem;
            }
            .row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <h1>
            <img src="${pageContext.request.contextPath}/assets/resources/icons/calendar.svg" alt="periodos">
            Generar Periodos
        </h1>
        
        <div class="info-box">
            <p>Los periodos se generan automaticamente en quincenas:</p>
            <p>• Quincena 1: dias 1 al 14 de cada mes</p>
            <p>• Quincena 2: dias 15 al ultimo dia del mes</p>
            <p>Nota: Solo se generaran los periodos que aun no existen en el sistema.</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <img src="${pageContext.request.contextPath}/assets/resources/icons/exclamation-circle.svg" alt="error">
                ${error}
            </div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/admin/periodos" method="get">
            <input type="hidden" name="action" value="preview">
            
            <div class="row">
                <div class="field">
                    <label>Año</label>
                    <select name="anio" required>
                        <c:forEach items="${anios}" var="anio">
                            <option value="${anio}" ${anio == anioActual ? 'selected' : ''}>${anio}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            
            <div class="row">
                <div class="field">
                    <label>Mes de inicio</label>
                    <select name="mesInicio" required>
                        <c:forEach items="${meses}" var="mes">
                            <option value="${mes}" ${mes == mesActual ? 'selected' : ''}>
                                ${mes} - ${nombresMeses[mes-1]}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="field">
                    <label>Mes de fin</label>
                    <select name="mesFin" required>
                        <c:forEach items="${meses}" var="mes">
                            <option value="${mes}" ${mes == 12 ? 'selected' : ''}>
                                ${mes} - ${nombresMeses[mes-1]}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">
                    <img src="${pageContext.request.contextPath}/assets/resources/icons/eye.svg" alt="preview" width="14" height="14">
                    Ver Vista Previa
                </button>
                <a href="${pageContext.request.contextPath}/admin/periodos" class="btn btn-secondary">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    const mesInicio = document.querySelector('select[name="mesInicio"]');
    const mesFin = document.querySelector('select[name="mesFin"]');
    
    function validarRango() {
        if (parseInt(mesInicio.value) > parseInt(mesFin.value)) {
            mesFin.value = mesInicio.value;
        }
    }
    
    mesInicio.addEventListener('change', validarRango);
</script>
</body>
</html>