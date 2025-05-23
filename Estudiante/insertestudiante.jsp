<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../WEB-INF/conexion.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Insertar Proyecto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center text-primary mb-4">Registrar Nuevo Proyecto</h2>

    <!-- Obtener el usuario logueado -->
    <sql:query var="usuario" dataSource="${trabajosUTS}">
        SELECT id, nombre FROM usuarios WHERE id = ${sessionScope.usuarioId};
    </sql:query>
    
    <sql:query var="ideas" dataSource="${trabajosUTS}">
        SELECT id, idea FROM ideas
    </sql:query>
    <form action="insertestudianteaction.jsp" method="post" enctype="multipart/form-data" class="card shadow p-4">
        <!-- Campo de Estudiante (solo el usuario logueado) -->
        <div class="mb-3">
            <label for="id_usuario" class="form-label">Estudiante</label>
            <input type="text" class="form-control" value="${usuario.rows[0].nombre}" disabled>
            <!-- Campo oculto para enviar el ID del usuario -->
            <input type="hidden" name="id_usuario" value="${usuario.rows[0].id}">
        </div>

        <!-- Consultas para obtener ideas -->
        <sql:query var="modalidad" dataSource="${trabajosUTS}">
            SELECT id, modalidad FROM modalidad
        </sql:query>

        <!-- Campo de Modalidad -->
        <div class="mb-3">
            <label for="id_modalidad" class="form-label">Modalidad</label>
            <select name="id_modalidad" id="id_modalidad" class="form-select" required>
                <option value="">Seleccione una modalidad</option>
                <c:forEach var="modalidad" items="${modalidad.rows}">
                    <option value="${modalidad.id}">${modalidad.modalidad}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Campo de archivo PDF -->
        <div class="mb-3">
            <label class="form-label">Archivo PDF</label>
        </div>
        

        <!-- Campo de calificación -->
       
        <!-- Botones de acción -->
        <div class="d-flex justify-content-between">
            <a href="readestudiante.jsp" class="btn btn-secondary">Cancelar</a>
            <button type="submit" class="btn btn-primary">Registrar</button>
        </div>
    </form>
</div>
</body>
</html>
