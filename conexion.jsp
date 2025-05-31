<%@ page import="java.sql.*" %>
<%
    Connection con = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servicio_pcs", "root", "");
    } catch(Exception e) {
        out.println("Error de conexión: " + e.getMessage());
    }
%>