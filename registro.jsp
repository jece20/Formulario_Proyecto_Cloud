<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - TechService</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(-45deg, #00ffe7, #1e2a3a, #00bfff, #98bbc4, #232b38, #00ffe7);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Orbitron', 'Segoe UI', Arial, sans-serif;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .ts {
            font-size: 2.8rem;
            margin-bottom: 0.5rem;
            font-family: 'Orbitron', 'Segoe UI', Arial, sans-serif;
            letter-spacing: 2px;
            color: #fff;
            text-shadow: 0 2px 12px #00ffe799, 0 0px 2px #222;
        }

        .register-card {
            border-radius: 1.5rem;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            background: rgba(50, 62, 88, 0.95);
            border: 1.5px solid #00ffe7;
        }
        
        .brand-logo {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 50%;
            box-shadow: 0 2px 8px #00ffe799;
            border: 2px solid #00ffe7;
            background: #222;
        }
        
        .form-label, .form-control {
            font-family: 'Orbitron', 'Segoe UI', Arial, sans-serif;
            color: #00ffe7;
            letter-spacing: 1px;
        }
        
        .form-control {
            background:rgb(51, 70, 100);
            border: 1.5px solid #00ffe7;
            color: #00ffe7;
            font-size: 1.1rem;
        }
        
        .form-control:focus {
            background: #232b38;
            border-color: #00ffe7;
            box-shadow: 0 0 0 0.2rem #00ffe733;
            color: #00ffe7;
        }
        
        .btn-primary {
            background: linear-gradient(90deg, #00ffe7 0%, #00bfff 100%);
            border: none;
            color: #232b38;
            font-family: 'Orbitron', 'Segoe UI', Arial, sans-serif;
            font-weight: 700;
            letter-spacing: 1px;
            box-shadow: 0 2px 8px #00ffe799;
            transition: background 0.2s, color 0.2s;
        }
        
        .btn-primary:hover {
            background: linear-gradient(90deg, #00bfff 0%, #00ffe7 100%);
            color: #111;
        }
        
        .alert-danger {
            background: rgba(255, 0, 80, 0.15);
            border: 1.5px solid #ff0050;
            color: #ff0050;
            font-family: 'Orbitron', 'Segoe UI', Arial, sans-serif;
        }
        
        .text-secondary, .text-muted, small {
            color: #b0eaff !important;
            font-family: 'Orbitron', 'Segoe UI', Arial, sans-serif;
        }
        
        .login-link {
            color: #00ffe7;
            text-decoration: none;
            font-weight: bold;
        }
        
        .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card register-card p-4">
                    <div class="text-center mb-4">
                        <img src="img/log.jpg" alt="Logo" class="brand-logo mb-2">
                        <h2 class="ts">TechService</h2>
                        <p class="text-secondary mb-0">Registro de nuevo cliente</p>
                    </div>
                    <% if ("1".equals(error)) { %>
                        <div class="alert alert-danger text-center py-2">
                            <i class="bi bi-exclamation-triangle me-1"></i> Error en el registro. Intente nuevamente.
                        </div>
                    <% } %>
                    <form action="registroProcess.jsp" method="post" autocomplete="off">
                        <h5 class="text-secondary mb-3">Datos de acceso</h5>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Usuario*</label>
                                <input type="text" name="username" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Contraseña*</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                        </div>
                        
                        <h5 class="text-secondary mb-3 mt-4">Información personal</h5>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Nombre*</label>
                                <input type="text" name="nombre" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Apellidos*</label>
                                <input type="text" name="apellidos" class="form-control" required>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Teléfono*</label>
                                <input type="tel" name="telefono" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email*</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Dirección*</label>
                            <input type="text" name="direccion" class="form-control" required>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Ciudad*</label>
                                <input type="text" name="ciudad" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Código Postal</label>
                                <input type="text" name="codigo_postal" class="form-control">
                            </div>
                        </div>
                        
                        <button class="btn btn-primary w-100 mb-2" type="submit">
                            <i class="bi bi-person-plus me-1"></i> Registrarse
                        </button>
                        <div class="text-center mt-2">
                            <small class="text-muted">¿Ya tienes cuenta? 
                                <a href="login.jsp" class="login-link">Inicia sesión aquí</a>
                            </small>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>