<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    String id = request.getParameter("id");
    
    try {
        // Primero eliminamos los servicios asociados
        PreparedStatement psServicios = con.prepareStatement(
            "DELETE FROM servicios WHERE id_dispositivo = ?");
        psServicios.setInt(1, Integer.parseInt(id));
        psServicios.executeUpdate();
        psServicios.close();
        
        // Luego eliminamos el historial asociado
        PreparedStatement psHistorial = con.prepareStatement(
            "DELETE FROM historial_estados WHERE id_dispositivo = ?");
        psHistorial.setInt(1, Integer.parseInt(id));
        psHistorial.executeUpdate();
        psHistorial.close();
        
        // Finalmente eliminamos el dispositivo
        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM dispositivos WHERE id_dispositivo = ?");
        ps.setInt(1, Integer.parseInt(id));
        
        int i = ps.executeUpdate();
        if(i > 0) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        
        ps.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    } finally {
        if(con != null) con.close();
    }
%>