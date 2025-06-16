<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<%
    // Obtener parámetros del formulario
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String telefono = request.getParameter("telefono");
    String email = request.getParameter("email");
    String direccion = request.getParameter("direccion");
    String ciudad = request.getParameter("ciudad");
    String codigo_postal = request.getParameter("codigo_postal");
    
    Connection conn = null;
    PreparedStatement psUsuario = null;
    PreparedStatement psCliente = null;
    ResultSet rs = null;
    
    try {
        conn = conexion;
        conn.setAutoCommit(false); // Iniciar transacción
        
        // 1. Insertar en tabla usuarios
        String sqlUsuario = "INSERT INTO usuarios (username, password, rol) VALUES (?, ?, 'cliente')";
        psUsuario = conn.prepareStatement(sqlUsuario, Statement.RETURN_GENERATED_KEYS);
        psUsuario.setString(1, username);
        psUsuario.setString(2, password);
        psUsuario.executeUpdate();
        
        // Obtener el ID del usuario insertado
        rs = psUsuario.getGeneratedKeys();
        int idUsuario = 0;
        if (rs.next()) {
            idUsuario = rs.getInt(1);
        }
        
        // 2. Insertar en tabla clientes
        String sqlCliente = "INSERT INTO clientes (id_usuario, nombre, apellidos, telefono, email, direccion, ciudad, codigo_postal) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        psCliente = conn.prepareStatement(sqlCliente);
        psCliente.setInt(1, idUsuario);
        psCliente.setString(2, nombre);
        psCliente.setString(3, apellidos);
        psCliente.setString(4, telefono);
        psCliente.setString(5, email);
        psCliente.setString(6, direccion);
        psCliente.setString(7, ciudad);
        psCliente.setString(8, codigo_postal);
        psCliente.executeUpdate();
        
        conn.commit(); // Confirmar transacción
        
        // Establecer sesión y redirigir
        session.setAttribute("id_usuario", idUsuario);
        session.setAttribute("usuario", username);
        session.setAttribute("rol", "cliente");
        session.setAttribute("loginTime", new java.util.Date());
        
        response.sendRedirect("cliente/dashboard.jsp");
        
    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback(); // Revertir en caso de error
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        e.printStackTrace();
        response.sendRedirect("registro.jsp?error=1");
    } finally {
        // Cerrar recursos
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (psUsuario != null) try { psUsuario.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (psCliente != null) try { psCliente.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>