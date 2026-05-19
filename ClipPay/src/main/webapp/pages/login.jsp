<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <title>Login | ClipPay</title>
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
            .login-container {
                display: flex;
                height: 100vh;
                width: 100%;
            }
            .login-left {
                flex: 1;
                background: white;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
            }
            .carousel-container {
                width: 100%;
                max-width: 450px;
                text-align: center;
                padding: 2rem;
            }
            .logo-carousel {
                margin-bottom: 2rem;
            }
            .logo-carousel img {
                width: 240px;
                height: auto;
                margin-bottom: 1rem;
            }
            .logo-carousel h2 {
                font-size: 1.5rem;
                font-weight: 600;
                color: #1a1a2e;
            }
            .carousel-title {
                font-size: 1.2rem;
                font-weight: 500;
                color: #1a1a2e;
                margin: 1.5rem 0 2rem 0;
                line-height: 1.4;
            }
            .carousel-slide {
                display: none;
                animation: fadeIn 0.5s ease;
            }
            .carousel-slide.active {
                display: block;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .carousel-icon {
                margin-bottom: 1rem;
            }
            .carousel-icon img {
                width: 60px;
                height: 60px;
                margin: 0 auto;
            }
            .carousel-slide h4 {
                font-size: 1.1rem;
                font-weight: 600;
                color: #1a1a2e;
                margin-bottom: 0.5rem;
            }
            .carousel-slide p {
                font-size: 0.85rem;
                color: #64748b;
                line-height: 1.5;
                max-width: 280px;
                margin: 0 auto;
            }
            .carousel-indicators {
                display: flex;
                justify-content: center;
                gap: 8px;
                margin-top: 2rem;
            }
            .indicator {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                background: #cbd5e1;
                cursor: pointer;
                transition: all 0.3s;
            }
            .indicator.active {
                width: 24px;
                border-radius: 4px;
                background: #1a1a2e;
            }
            .login-right {
                flex: 1;
                background: white;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 1rem;
            }
            .login-form-container {
                width: 100%;
                max-width: 320px;
            }
            .logo {
                text-align: center;
                margin-bottom: 1rem;
            }
            .logo h1 {
                font-size: 1.8rem;
                font-weight: 600;
                color: #1a1a2e;
            }
            .logo p {
                font-size: 0.7rem;
                color: #94a3b8;
                letter-spacing: 1px;
                text-transform: uppercase;
            }
            h3 {
                font-size: 1.2rem;
                font-weight: 600;
                color: #1a1a2e;
                margin-bottom: 0.25rem;
            }
            .subtitle {
                font-size: 0.7rem;
                color: #64748b;
                margin-bottom: 1rem;
            }
            .field {
                margin-bottom: 0.8rem;
            }
            .field label {
                display: block;
                font-size: 0.65rem;
                font-weight: 500;
                text-transform: uppercase;
                color: #64748b;
                margin-bottom: 0.25rem;
            }
            .field input {
                width: 100%;
                padding: 0.5rem 0;
                border: none;
                border-bottom: 2px solid #e2e8f0;
                font-size: 0.85rem;
                font-family: inherit;
                background: transparent;
                transition: border-color 0.2s;
            }
            .field input:focus {
                outline: none;
                border-bottom-color: #1a1a2e;
            }
            .pin-display {
                text-align: center;
                margin: 0.5rem 0 0.8rem 0;
            }
            .pin-display input {
                width: 160px;
                text-align: center;
                font-size: 1.3rem;
                letter-spacing: 6px;
                font-weight: 500;
                border: none;
                border-bottom: 2px solid #e2e8f0;
                padding: 0.4rem 0;
                background: transparent;
                font-family: monospace;
            }
            .pin-display input:focus {
                outline: none;
                border-bottom-color: #1a1a2e;
            }
            .teclado {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 6px;
                margin: 1rem 0;
            }
            .tecla {
                background: #f8fafc;
                border: 1px solid #e2e8f0;
                padding: 8px;
                font-size: 1.1rem;
                font-weight: 500;
                font-family: monospace;
                cursor: pointer;
                transition: all 0.1s;
                color: #1a1a2e;
                border-radius: 8px;
            }
            .tecla:active {
                background: #e2e8f0;
                transform: scale(0.96);
            }
            .tecla.borrar, .tecla.limpiar {
                font-size: 0.7rem;
                text-transform: uppercase;
            }
            .btn-ingresar {
                width: 100%;
                background: #1a1a2e;
                color: white;
                border: none;
                padding: 10px;
                font-size: 0.7rem;
                font-weight: 600;
                letter-spacing: 2px;
                text-transform: uppercase;
                cursor: pointer;
                transition: background 0.2s;
                border-radius: 30px;
            }
            .btn-ingresar:active {
                background: #2d2d44;
            }
            .error {
                background: #fee9ed;
                color: #d83752;
                padding: 0.4rem;
                border-radius: 6px;
                font-size: 0.65rem;
                text-align: center;
                margin-bottom: 0.8rem;
                transition: opacity 0.5s ease;
            }
            .error.fade-out {
                opacity: 0;
            }
            .divider {
                height: 1px;
                background: #e2e8f0;
                margin: 0.8rem 0;
            }
            .footer-text {
                text-align: center;
                font-size: 0.55rem;
                color: #cbd5e1;
                margin-top: 0.8rem;
            }
            @media (max-width: 768px) {
                .login-left {
                    display: none;
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-left">
                <div class="carousel-container">
                    <div class="logo-carousel">
                        <img src="${pageContext.request.contextPath}/assets/resources/images/tijerasLogo.png" alt="ClipPay Logo">
                        <h2>CLIPPAY</h2>
                    </div>
                    <div class="carousel-title">
                        Disfruta de la administración digitalizada de tu barbería.
                    </div>
                    <div class="carousel-slide active" data-slide="0">
                        <div class="carousel-icon">
                            <img src="${pageContext.request.contextPath}/assets/resources/icons/document-text.svg" alt="recibo">
                        </div>
                        <h4>Gestión de recibos</h4>
                        <p>Podrás ver el detalle de tus recibos, cada mes.</p>
                    </div>
                    <div class="carousel-slide" data-slide="1">
                        <div class="carousel-icon">
                            <img src="${pageContext.request.contextPath}/assets/resources/icons/user-group.svg" alt="empleados">
                        </div>
                        <h4>Administra tus empleados</h4>
                        <p>Controla horarios, cortes y comisiones de tu equipo.</p>
                    </div>
                    <div class="carousel-slide" data-slide="2">
                        <div class="carousel-icon">
                            <img src="${pageContext.request.contextPath}/assets/resources/icons/check-circle.svg" alt="seguimiento">
                        </div>
                        <h4>Seguimiento de cortes</h4>
                        <p>Podrás ver el historial y detalle de cada servicio.</p>
                    </div>
                    <div class="carousel-indicators">
                        <div class="indicator active" data-indicator="0"></div>
                        <div class="indicator" data-indicator="1"></div>
                        <div class="indicator" data-indicator="2"></div>
                    </div>
                </div>
            </div>
            <div class="login-right">
                <div class="login-form-container">
                    <div class="logo">
                        <h1>MADDOG</h1>
                        <p>barbería</p>
                    </div>
                    <h3>Bienvenido</h3>
                    <p class="subtitle">Ingrese sus credenciales</p>
                    <div id="errorContainer"></div>
                    <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                        <div class="field">
                            <label>USUARIO</label>
                            <input type="text" name="username" id="username" placeholder="Nombre de usuario" autocomplete="off">
                        </div>
                        <div class="pin-display">
                            <input type="password" id="pinDisplay" placeholder="______" maxlength="6" readonly>
                        </div>
                        <input type="hidden" name="pin" id="pinHidden" value="">
                        <div class="teclado">
                            <button type="button" class="tecla" data-num="1">1</button>
                            <button type="button" class="tecla" data-num="2">2</button>
                            <button type="button" class="tecla" data-num="3">3</button>
                            <button type="button" class="tecla" data-num="4">4</button>
                            <button type="button" class="tecla" data-num="5">5</button>
                            <button type="button" class="tecla" data-num="6">6</button>
                            <button type="button" class="tecla" data-num="7">7</button>
                            <button type="button" class="tecla" data-num="8">8</button>
                            <button type="button" class="tecla" data-num="9">9</button>
                            <button type="button" class="tecla borrar" id="borrar">⌫</button>
                            <button type="button" class="tecla" data-num="0">0</button>
                            <button type="button" class="tecla limpiar" id="limpiar">✕</button>
                        </div>
                        <button type="submit" class="btn-ingresar">Ingresar</button>
                    </form>
                </div>
                <script>
                    let currentSlide = 0;
                    const slides = document.querySelectorAll('.carousel-slide');
                    const indicators = document.querySelectorAll('.indicator');
                    const totalSlides = slides.length;
                    let interval;
                    function showSlide(index) {
                        slides.forEach(slide => slide.classList.remove('active'));
                        indicators.forEach(ind => ind.classList.remove('active'));
                        slides[index].classList.add('active');
                        indicators[index].classList.add('active');
                        currentSlide = index;
                    }
                    function nextSlide() {
                        let next = (currentSlide + 1) % totalSlides;
                        showSlide(next);
                    }
                    function startCarousel() {
                        interval = setInterval(nextSlide, 4000);
                    }
                    function stopCarousel() {
                        clearInterval(interval);
                    }
                    indicators.forEach((indicator, idx) => {
                        indicator.addEventListener('click', () => {
                            stopCarousel();
                            showSlide(idx);
                            startCarousel();
                        });
                    });
                    const carouselContainer = document.querySelector('.carousel-container');
                    carouselContainer.addEventListener('mouseenter', stopCarousel);
                    carouselContainer.addEventListener('mouseleave', startCarousel);
                    startCarousel();
                    let pin = "";
                    const pinDisplay = document.getElementById("pinDisplay");
                    const pinHidden = document.getElementById("pinHidden");
                    const errorContainer = document.getElementById("errorContainer");
                    function mostrarError(mensaje) {
                        const errorDiv = document.createElement('div');
                        errorDiv.className = 'error';
                        errorDiv.innerHTML = '✗ ' + mensaje;
                        errorContainer.innerHTML = '';
                        errorContainer.appendChild(errorDiv);
                        setTimeout(() => {
                            errorDiv.classList.add('fade-out');
                            setTimeout(() => {
                                if (errorDiv.parentNode) {
                                    errorDiv.parentNode.removeChild(errorDiv);
                                }
                            }, 500);
                        }, 3000);
                    }
                    <% if (request.getAttribute("error") != null) { %>
                    mostrarError("<%= request.getAttribute("error") %>");
                    <% } %>
                    const updateDisplay = () => {
                        pinDisplay.value = pin ? "●".repeat(pin.length) : "______";
                        pinHidden.value = pin;
                    };
                    document.querySelectorAll(".tecla[data-num]").forEach(btn => {
                        btn.onclick = () => {
                            if (pin.length < 6) {
                                pin += btn.dataset.num;
                                updateDisplay();
                            }
                        };
                    });
                    document.getElementById("borrar").onclick = () => {
                        pin = pin.slice(0, -1);
                        updateDisplay();
                    };
                    document.getElementById("limpiar").onclick = () => {
                        pin = "";
                        updateDisplay();
                    };
                    document.getElementById("loginForm").onsubmit = (e) => {
                        if (pin.length !== 6 || !document.getElementById("username").value.trim()) {
                            e.preventDefault();
                            if (pin.length !== 6) {
                                mostrarError("PIN de 6 dígitos");
                            } else {
                                mostrarError("Ingrese usuario");
                            }
                        }
                    };
                    document.getElementById("username").focus();
                </script>
                </body>
                </html>