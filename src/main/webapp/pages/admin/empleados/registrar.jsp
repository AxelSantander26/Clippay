<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrar Empleado - ClipPay</title>
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
        
        input, select {
            width: 100%;
            padding: 0.625rem;
            font-size: 0.8rem;
            font-family: inherit;
            border: 1px solid #e5e5e5;
            border-radius: 6px;
            background: #ffffff;
            transition: all 0.2s ease;
        }
        
        input:focus, select:focus {
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
            <img src="${pageContext.request.contextPath}/assets/resources/icons/user-plus.svg" alt="registrar">
            Registrar Empleado
        </h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <img src="${pageContext.request.contextPath}/assets/resources/icons/exclamation-circle.svg" alt="error">
                ${error}
            </div>
        <% } %>
        
        <form action="${pageContext.request.contextPath}/admin/empleados" method="post">
            <input type="hidden" name="action" value="registrar">
            
            <div class="row">
                <div class="field">
                    <label>DNI</label>
                    <input type="text" name="dni" maxlength="8" placeholder="12345678" required>
                </div>
                <div class="field">
                    <label>Teléfono</label>
                    <input type="text" name="telefono" placeholder="987654321">
                </div>
            </div>
            
            <div class="row">
                <div class="field">
                    <label>Nombre</label>
                    <input type="text" name="nombre" placeholder="Nombre" required>
                </div>
                <div class="field">
                    <label>Apellido</label>
                    <input type="text" name="apellido" placeholder="Apellido" required>
                </div>
            </div>
            
            <div class="field">
                <label>Correo</label>
                <input type="email" name="correo" placeholder="correo@ejemplo.com" required>
            </div>
            
            <div class="row">
                <div class="field">
                    <label>Usuario</label>
                    <input type="text" name="usuNombre" placeholder="nombre.usuario" required>
                </div>
                <div class="field">
                    <label>Rol</label>
                    <select name="rol" required>
                        <c:forEach items="${roles}" var="rol">
                            <option value="${rol}">${rol}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            
            <div class="field">
                <label>PIN (6 dígitos)</label>
                <input type="password" name="pin" maxlength="6" pattern="\d{6}" placeholder="123456" required>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">
                    Registrar
                </button>
                <a href="${pageContext.request.contextPath}/admin/empleados" class="btn btn-secondary">
                    Cancelar
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>