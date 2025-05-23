<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../WEB-INF/conexion.jspf" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guardar Proyecto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
<%
    try {
        request.setCharacterEncoding("UTF-8");

        String idUsuarioStr = request.getParameter("id_usuario");
        String idIdeaStr = request.getParameter("id_idea");
        String nombreArchivo = request.getParameter("nombre_archivo");
        String calificacionStr = request.getParameter("calificacion");

        // Mostrar los valores recibidos (opcional)
        out.println("<div class='card p-4 mb-4'>");
        out.println("<h3>Valores recibidos:</h3>");
        out.println("<p>ID Usuario: " + idUsuarioStr + "</p>");
        out.println("<p>ID Idea: " + idIdeaStr + "</p>");
        out.println("<p>Nombre Archivo: " + nombreArchivo + "</p>");
        out.println("<p>Calificación: " + calificacionStr + "</p>");
        out.println("</div>");

        if (idUsuarioStr == null || idUsuarioStr.isEmpty() ||
            idIdeaStr == null || idIdeaStr.isEmpty() ||
            nombreArchivo == null || nombreArchivo.isEmpty() ||
            calificacionStr == null || calificacionStr.isEmpty()) {
%>
    <div class="alert alert-danger">Error: Faltan datos en el formulario.</div>
    <p><a href="insertestudiante.jsp" class="btn btn-primary">Volver</a></p>
<%
        } else {
            try {
                int idUsuario = Integer.parseInt(idUsuarioStr);
                int idIdea = Integer.parseInt(idIdeaStr);
                double calificacion = Double.parseDouble(calificacionStr);

%>
                <sql:update dataSource="${trabajosUTS}">
                    INSERT INTO proyectos (id_usuario, id_idea, archivo_pdf, calificacion) 
                    VALUES (?, ?, ?, ?)
                    <sql:param value="<%= idUsuario %>" />
                    <sql:param value="<%= idIdea %>" />
                    <sql:param value="<%= nombreArchivo %>" />
                    <sql:param value="<%= calificacion %>" />
                </sql:update>

                <div class="alert alert-success">
                    Proyecto guardado correctamente con nombre de archivo: <strong><%= nombreArchivo %></strong>
                </div>
                <p><a href="readestudiante.jsp" class="btn btn-primary">Ver proyectos</a></p>
<%
            } catch (NumberFormatException e) {
%>
                <div class="alert alert-danger">Error: Datos no válidos. Detalles: <%= e.getMessage() %></div>
                <p><a href="insertestudiante.jsp" class="btn btn-primary">Volver</a></p>
<%
            } catch (Exception e) {
%>
                <div class="alert alert-danger">Error al procesar: <%= e.getMessage() %></div>
                <p><a href="insertestudiante.jsp" class="btn btn-primary">Volver</a></p>
<%
            }
        }
    } catch (Exception e) {
%>
    <div class="alert alert-danger">Error general: <%= e.getMessage() %></div>
    <p><a href="insertestudiante.jsp" class="btn btn-primary">Volver</a></p>
<%
        e.printStackTrace();
    }
%>
</div>
</body>
</html>
