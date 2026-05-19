<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mi Módulo - ClipPay</title>
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
        }

        .modulo-container h1 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 1rem;
        }

        .modulo-container p {
            color: #64748b;
            margin-bottom: 0.5rem;
        }

        hr {
            margin: 1rem 0;
            border: none;
            border-top: 1px solid #e2e8f0;
        }

        @media (max-width: 768px) {
            .modulo-container {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/components/sidebar.jsp"/>

    <div class="modulo-container">
        <h1>📄 Nombre del Módulo</h1>
        <p>Aquí va el contenido de tu módulo.</p>
        <hr>
        <p>✅ Sidebar ya incluido | ✅ Espacio adaptable | ✅ Reemplaza este contenido</p>
    </div>

</body>
</html>