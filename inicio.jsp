<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="WEB-INF/conexion.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");
%>
<%@ page session="true" %>
<%
    if (session.getAttribute("cedula") == null) {
        response.sendRedirect("index.jsp"); // redirige si no hay sesión activa
    }
    String nombre = (String) session.getAttribute("nombre");
    String cedula = (String) session.getAttribute("cedula");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Plataforma UTS</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e6f4ea;
        }
        .navbar {
            background-color: #28a745;
        }
        .navbar-brand,
        .nav-link {
            color: white !important;
            font-weight: bold;
        }
        .nav-link:hover {
            color: #d4f4db !important;
        }
        .card-custom {
            transition: transform 0.3s ease;
        }
        .card-custom:hover {
            transform: scale(1.05);
        }
        .card {
            border: 2px solid #28a745;
            box-shadow: 0 4px 8px rgba(40, 167, 69, 0.2);
        }
        .btn-green {
            background-color: #28a745;
            color: white;
        }
        .btn-green:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>


<nav class="navbar navbar-expand-lg">
    <div class="container mt-3 text-end">
        <span class="text-success fw-bold">¡Bienvenido, <%= nombre %>!</span>
    </div>
    
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="img/logo_uts.png" alt="UTS Logo" width="40" class="me-2">
            Plataforma UTS
        </a>
        <div class="ms-auto">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="inicio.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login/cerrarSesion.jsp">Cerrar Sesión</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- TARJETAS -->
<div class="container mt-5">
    <div class="row justify-content-center g-4">
        <div class="col-md-4">
            <div class="card card-custom text-center">
                <div class="card-body">
                    <h5 class="card-title text-success">Calendario Académico</h5>
                    <p class="card-text">Semestre 1 – 2025 Modificación I.</p>
                    <iframe src="https://www.uts.edu.co/sitio/wp-content/uploads/2019/10/Acuerdo-No.-03-006-Modificaci%C3%B3n-calendario-acad%C3%A9mico.pdf" style="border: 0" width="100%" height="300" frameborder="0" scrolling="no"></iframe>
                    
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-custom text-center">
                <div class="card-body">
                    <h5 class="card-title text-success">Calendario Académico</h5>
                    <p class="card-text">Semestre 1 – 2025.</p>
                    <iframe src="https://www.uts.edu.co/sitio/wp-content/uploads/2025/01/ACUERDO-03-001-MODIFICACION-CALENDARIO-ACADE-PRESENCIAL.pdf" style="border: 0" width="100%" height="300" frameborder="0" scrolling="no"></iframe>
                    
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-custom text-center">
                <div class="card-body">
                    <h5 class="card-title text-success">Formatos de Grado</h5>
                    <p class="card-text">Descarga los formatos necesarios para tu proyecto de grado.</p>
                    <a href="https://www.dropbox.com/scl/fo/pudgcaq639agy7t06ahjs/AN084HnuyHffgYL5i--v_Ks/DOCUMENTOS%20DE%20GRADO?dl=0&rlkey=6s0b9ajweteyx2ang7ywvk6xm&subfolder_nav_tracking=1" target="_blank" class="btn btn-green">Ver Formatos</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-custom text-center">
                <div class="card-body">
                    <h5 class="card-title text-success">Subir Proyecto</h5>
                    <p class="card-text">Envía tu archivo PDF para evaluación.</p>
                    <a href="subirProyecto.jsp" class="btn btn-green">Subir Ahora</a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
