<!-- filepath: c:\xampp\tomcat\webapps\Proyectos de Grado\index.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="WEB-INF/conexion.jspf" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login UTS</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e6f4ea;
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

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4" style="width: 25rem;">
        <h4 class="text-center mb-4 text-success">Ingreso Plataforma UTS</h4>
        <form method="post" action="./login/validar.jsp">
            <div class="mb-3">
                <label for="cedula" class="form-label">Cédula</label>
                <input type="text" class="form-control" id="cedula" name="cedula" required>
            </div>
            <div class="mb-3">
                <label for="contrasena" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="contrasena" name="contrasena" required>
            </div>
            <button type="submit" class="btn btn-green w-100">Ingresar</button>
        </form>
    </div>
</div>

</body>
</html>