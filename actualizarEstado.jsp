<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    String id_dispositivo = request.getParameter("id_dispositivo");
    String estado_anterior = request.getParameter("estado_anterior");
    String estado_nuevo = request.getParameter("estado_nuevo");
    String usuario = request.getParameter("usuario");
    
    try {
        // Actualizar estado en la tabla dispositivos
        PreparedStatement ps = con.prepareStatement(
            "UPDATE dispositivos SET estado = ? WHERE id_dispositivo = ?");
        ps.setString(1, estado_nuevo);
        ps.setInt(2, Integer.parseInt(id_dispositivo));
        ps.executeUpdate();
        ps.close();
        
        // Registrar cambio en el historial
        PreparedStatement psHistorial = con.prepareStatement(
            "INSERT INTO historial_estados (id_dispositivo, estado_anterior, estado_nuevo, usuario) " +
            "VALUES (?, ?, ?, ?)");
        psHistorial.setInt(1, Integer.parseInt(id_dispositivo));
        psHistorial.setString(2, estado_anterior);
        psHistorial.setString(3, estado_nuevo);
        psHistorial.setString(4, usuario);
        psHistorial.executeUpdate();
        psHistorial.close();
        
        response.setStatus(HttpServletResponse.SC_OK);
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    } finally {
        if(con != null) con.close();
    }
%>