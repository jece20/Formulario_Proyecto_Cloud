<!-- filepath: c:\xampp\tomcat\webapps\Proyectos de Grado\Estudiante\deleteestudiante.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../WEB-INF/conexion.jspf" %>
<%@ page import="java.io.File" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Proyecto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
<%
    try {
        String idProyecto = request.getParameter("id");
        
        if (idProyecto == null || idProyecto.isEmpty()) {
%>
            <div class="alert alert-danger">Error: No se especificó el ID del proyecto.</div>
            <p><a href="readestudiante.jsp" class="btn btn-primary">Volver</a></p>
<%
        } else {
            // Primero obtenemos la ruta del archivo antes de eliminar
%>
            <sql:query var="archivoQuery" dataSource="${trabajosUTS}">
                SELECT archivo_pdf FROM proyectos WHERE id = ?
                <sql:param value="${param.id}" />
            </sql:query>
            
            <c:if test="${archivoQuery.rowCount > 0}">
                <c:set var="rutaArchivo" value="${archivoQuery.rows[0].archivo_pdf}" />
                
                <!-- Eliminar el registro -->
                <sql:update dataSource="${trabajosUTS}">
                    DELETE FROM proyectos WHERE id = ?
                    <sql:param value="${param.id}" />
                </sql:update>
                
                <!-- Intentar eliminar el archivo físico si existe -->
                <%
                    String rutaArchivo = (String)pageContext.getAttribute("rutaArchivo");
                    if (rutaArchivo != null && !rutaArchivo.isEmpty()) {
                        String rutaCompleta = application.getRealPath("/") + rutaArchivo;
                        File archivo = new File(rutaCompleta);
                        if (archivo.exists()) {
                            archivo.delete();
                            out.println("<div class='alert alert-info'>Archivo físico eliminado: " + rutaArchivo + "</div>");
                        }
                    }
                %>
                
                <div class="alert alert-success">Proyecto eliminado correctamente.</div>
            </c:if>
            
            <c:if test="${archivoQuery.rowCount == 0}">
                <div class="alert alert-warning">No se encontró el proyecto con ID: ${param.id}</div>
            </c:if>
            
            <p><a href="readestudiante.jsp" class="btn btn-primary">Volver a la lista</a></p>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <div class="alert alert-danger">Error al eliminar: <%= e.getMessage() %></div>
        <p><a href="readestudiante.jsp" class="btn btn-primary">Volver</a></p>
<%
    }
%>
    </div>
</body>
</html>