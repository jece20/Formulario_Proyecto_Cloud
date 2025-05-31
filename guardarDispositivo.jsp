<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    String id_cliente = request.getParameter("id_cliente");
    String tipo_dispositivo = request.getParameter("tipo_dispositivo");
    String marca = request.getParameter("marca");
    String modelo = request.getParameter("modelo");
    String numero_serie = request.getParameter("numero_serie");
    String problema_reportado = request.getParameter("problema_reportado");
    String estado = request.getParameter("estado");
    
    try {
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO dispositivos (id_cliente, tipo_dispositivo, marca, modelo, " +
            "numero_serie, problema_reportado, estado) VALUES (?, ?, ?, ?, ?, ?, ?)");
        
        ps.setInt(1, Integer.parseInt(id_cliente));
        ps.setString(2, tipo_dispositivo);
        ps.setString(3, marca);
        ps.setString(4, modelo);
        ps.setString(5, numero_serie);
        ps.setString(6, problema_reportado);
        ps.setString(7, estado);
        
        int i = ps.executeUpdate();
        if(i > 0) {
            // Registrar el estado inicial en el historial
            int idDispositivo = 0;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID() as id");
            if(rs.next()) {
                idDispositivo = rs.getInt("id");
            }
            rs.close();
            stmt.close();
            
            PreparedStatement psHistorial = con.prepareStatement(
                "INSERT INTO historial_estados (id_dispositivo, estado_anterior, estado_nuevo, usuario) " +
                "VALUES (?, NULL, ?, ?)");
            psHistorial.setInt(1, idDispositivo);
            psHistorial.setString(2, estado);
            psHistorial.setString(3, "Sistema");
            psHistorial.executeUpdate();
            psHistorial.close();
            
            response.sendRedirect("index.jsp?success=1");
        } else {
            response.sendRedirect("index.jsp?error=1");
        }
        ps.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if(con != null) con.close();
    }
%>