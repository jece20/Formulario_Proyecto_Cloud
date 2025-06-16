<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidar la sesión completamente
    if (session != null) {
        session.invalidate();
    }
    
    // Redireccionar al login con mensaje de logout exitoso
    response.sendRedirect("login.jsp?logout=1");
%>