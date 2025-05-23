<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/conexion.jspf" %>

<sql:query var="usuario" dataSource="${trabajosUTS}">
    SELECT * FROM usuarios WHERE cedula = ? AND contrasena = ?
    <sql:param value="${param.cedula}" />
    <sql:param value="${param.contrasena}" />
</sql:query>

<c:choose>
    <c:when test="${not empty usuario.rows}">
        <c:set var="user" value="${usuario.rows[0]}" />
        <c:choose>
            <c:when test="${user.id_rol == 1}">
                <c:redirect url="../Administrador/inicioadministrador.jsp" />
            </c:when>
            <c:when test="${user.id_rol == 2}">
                <c:redirect url="../Coordinacion/iniciocoordinacion.jsp" />
            </c:when>
            <c:when test="${user.id_rol == 3}">
                <c:redirect url="../Director/iniciodirector.jsp" />
            </c:when>
            <c:when test="${user.id_rol == 4}">
                <c:redirect url="../evaluador/inicioevaluador.jsp" />
            </c:when>
            <c:when test="${user.id_rol == 5}">
                <c:redirect url="../Estudiante/inicioestudiante.jsp" />
            </c:when>
            <c:otherwise>
                <c:redirect url="../error.jsp" />
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <c:redirect url="../loginError.jsp" />
    </c:otherwise>
</c:choose>
