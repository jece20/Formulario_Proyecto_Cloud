<!-- filepath: c:\xampp\tomcat\webapps\Proyectos de Grado\Estudiante\readestudiante.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../WEB-INF/conexion.jspf" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Proyectos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center text-primary mb-4">Proyectos Registrados</h2>
    
    <!-- Consulta para obtener proyectos con información relacionada -->
    <sql:query var="proyectos" dataSource="${trabajosUTS}">
        SELECT p.id, u.nombre as estudiante, i.modalidad, p.archivo_pdf, p.calificacion 
        FROM proyectos p
        JOIN usuarios u ON p.id_usuario = u.id
        JOIN ideas i ON p.id_idea = i.id
        ORDER BY p.id DESC;
    </sql:query>
    
    <div class="mb-3">
        <a href="insertestudiante.jsp" class="btn btn-success">Nuevo Proyecto</a>
    </div>
    
    <div class="card shadow">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Estudiante</th>
                            <th>Modalidad</th>
                            <th>Archivo</th>
                            <th>Calificación</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="proyecto" items="${proyectos.rows}">
                            <tr>
                                <td>${proyecto.id}</td>
                                <td>${proyecto.estudiante}</td>
                                <td>${proyecto.modalidad}</td>
                                <td>
                                    <c:if test="${not empty proyecto.archivo_pdf}">
                                        <a href="${proyecto.archivo_pdf}" target="_blank" class="text-decoration-none">
                                            ${proyecto.archivo_pdf}
                                        </a>
                                    </c:if>
                                </td>
                                <td>${proyecto.calificacion}</td>
                                <td>
                                    <a href="editestudiante.jsp?id=${proyecto.id}" class="btn btn-sm btn-warning">Editar</a>
                                    <a href="javascript:confirmarEliminar(${proyecto.id})" class="btn btn-sm btn-danger">Eliminar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!-- Mensaje si no hay registros -->
            <c:if test="${empty proyectos.rows}">
                <div class="alert alert-info text-center">
                    No hay proyectos registrados.
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Script para confirmación de eliminación -->
<script>
function confirmarEliminar(id) {
    if (confirm("¿Está seguro de que desea eliminar este proyecto?")) {
        window.location.href = "deleteestudiante.jsp?id=" + id;
    }
}
</script>
</body>
</html>
