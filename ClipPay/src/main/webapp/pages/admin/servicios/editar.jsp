<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Servicio - ClipPay</title>
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
            background: #f0fdf4;
            padding: 0.625rem 0.875rem;
            border-radius: 6px;
            margin-bottom: 1rem;
            font-size: 0.7rem;
            color: #166534;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            border: 1px solid #dcfce7;
        }
        
        .info-box img {
            width: 14px;
            height: 14px;
        }
        
        .field {
            margin-bottom: 1rem;
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
        
        input {
            width: 100%;
            padding: 0.625rem;
            font-size: 0.8rem;
            font-family: inherit;
            border: 1px solid #e5e5e5;
            border-radius: 6px;
            background: #ffffff;
            transition: all 0.2s ease;
        }
        
        input:focus {
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
            filter: brightness(0);
        }
        
        .btn-primary {
            background: #1a1a1a;
            color: #ffffff;
        }
        
        .btn-primary:hover {
            background: #333333;
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
            <img src="${pageContext.request.contextPath}/assets/resources/icons/pencil.svg" alt="editar">
            Editar Servicio
        </h1>
        
        <div class="info-box">
            <img src="${pageContext.request.contextPath}/assets/resources/icons/information-circle.svg" alt="info">
            Modifica los datos del servicio. La comisión afecta el cálculo de nómina.
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <img src="${pageContext.request.contextPath}/assets/resources/icons/exclamation-circle.svg" alt="error">
                ${error}
            </div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/admin/servicios" method="post">
            <input type="hidden" name="action" value="actualizar">
            <input type="hidden" name="serId" value="${servicio.serId}">
            
            <div class="field">
                <label>Nombre del Servicio</label>
                <input type="text" name="nombre" value="${servicio.serNombre}" required>
            </div>
            
            <div class="row">
                <div class="field">
                    <label>Precio (S/)</label>
                    <input type="number" name="precio" step="0.01" min="0" value="${servicio.serPrecio}" required>
                </div>
                <div class="field">
                    <label>Comisión (%)</label>
                    <input type="number" name="comision" step="0.01" min="0" max="100" value="${servicio.serComisionPorcentaje}" required>
                </div>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">
                    Actualizar Servicio
                </button>
                <a href="${pageContext.request.contextPath}/admin/servicios" class="btn btn-secondary">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>