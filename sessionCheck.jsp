<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Verificar si existe una sesión activa
    String usuarioSesion = (String) session.getAttribute("usuario");
    String rolSesion = (String) session.getAttribute("rol");
    
    if (usuarioSesion == null || rolSesion == null) {
        // No hay sesión activa, redireccionar al login
        response.sendRedirect("login.jsp?error=5");
        return;
    }
    
    // Verificar si la sesión ha expirado (opcional - configurar tiempo límite)
    java.util.Date loginTime = (java.util.Date) session.getAttribute("loginTime");
    if (loginTime != null) {
        long sessionDuration = System.currentTimeMillis() - loginTime.getTime();
        long maxSessionTime = 8 * 60 * 60 * 1000; // 8 horas en milisegundos
        
        if (sessionDuration > maxSessionTime) {
            session.invalidate();
            response.sendRedirect("login.jsp?error=6");
            return;
        }
    }
%>