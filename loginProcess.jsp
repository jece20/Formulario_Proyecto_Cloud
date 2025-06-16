<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>

<%
    String usuario = request.getParameter("usuario");
    String password = request.getParameter("password");
    
    if (usuario == null || password == null) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }
    
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        conn = conexion;
        String sql = "SELECT id_usuario, username, rol FROM usuarios WHERE username = ? AND password = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, usuario);
        ps.setString(2, password);
        
        rs = ps.executeQuery();
        
        if (rs.next()) {
            // Establecer atributos de sesión
            session.setAttribute("id_usuario", rs.getInt("id_usuario"));
            session.setAttribute("usuario", rs.getString("username"));
            session.setAttribute("rol", rs.getString("rol"));
            session.setAttribute("loginTime", new java.util.Date());
            
            // Redirección según rol
            String redirectPage;
            switch(rs.getString("rol")) {
                case "admin":
                    redirectPage = "index.jsp";
                    break;
                case "tecnico":
                    redirectPage = "index.jsp";
                    break;
                case "cliente":
                    redirectPage = "index.jsp";
                    break;
                default:
                    response.sendRedirect("login.jsp?error=3");
                    return;
            }
            response.sendRedirect(redirectPage);
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("login.jsp?error=2");
    } finally {
        // Cerrar recursos
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>