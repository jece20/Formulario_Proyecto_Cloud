<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema de Servicio de Mantenimiento</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h1>Sistema de Servicio de Mantenimiento</h1>
        
        <div class="tabs">
            <button class="tab-btn active" onclick="openTab('clientes')">Clientes</button>
            <button class="tab-btn" onclick="openTab('dispositivos')">Dispositivos</button>
            <button class="tab-btn" onclick="openTab('servicios')">Servicios</button>
            <button class="tab-btn" onclick="openTab('historial')">Historial</button>
        </div>
        
        <!-- Pestaña de Clientes -->
        <div id="clientes" class="tab-content active">
            <h2>Registro de Clientes</h2>
            <form id="clienteForm" action="guardarCliente.jsp" method="post">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>
                <div class="form-group">
                    <label for="apellidos">Apellidos:</label>
                    <input type="text" id="apellidos" name="apellidos" required>
                </div>
                <div class="form-group">
                    <label for="telefono">Teléfono:</label>
                    <input type="text" id="telefono" name="telefono" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email">
                </div>
                <div class="form-group">
                    <label for="direccion">Dirección:</label>
                    <input type="text" id="direccion" name="direccion" required>
                </div>
                <div class="form-group">
                    <label for="ciudad">Ciudad:</label>
                    <input type="text" id="ciudad" name="ciudad" required>
                </div>
                <div class="form-group">
                    <label for="codigo_postal">Código Postal:</label>
                    <input type="text" id="codigo_postal" name="codigo_postal">
                </div>
                <button type="submit" class="btn">Guardar Cliente</button>
            </form>
            
            <h2>Lista de Clientes</h2>
            <table id="clientesTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Apellidos</th>
                        <th>Teléfono</th>
                        <th>Email</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    try {
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM clientes");
                        
                        while(rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id_cliente") %></td>
                        <td><%= rs.getString("nombre") %></td>
                        <td><%= rs.getString("apellidos") %></td>
                        <td><%= rs.getString("telefono") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td>
                            <button onclick="editarCliente(<%= rs.getInt("id_cliente") %>)">Editar</button>
                            <button onclick="eliminarCliente(<%= rs.getInt("id_cliente") %>)">Eliminar</button>
                        </td>
                    </tr>
                    <%
                        }
                        rs.close();
                        stmt.close();
                    } catch(Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                    %>
                </tbody>
            </table>
        </div>
        
        <!-- Pestaña de Dispositivos -->
        <div id="dispositivos" class="tab-content">
            <h2>Registro de Dispositivos</h2>
            <form id="dispositivoForm" action="guardarDispositivo.jsp" method="post">
                <div class="form-group">
                    <label for="id_cliente">Cliente:</label>
                    <select id="id_cliente" name="id_cliente" required>
                        <option value="">Seleccione un cliente</option>
                        <%
                        try {
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT id_cliente, nombre, apellidos FROM clientes");
                            
                            while(rs.next()) {
                        %>
                        <option value="<%= rs.getInt("id_cliente") %>">
                            <%= rs.getString("nombre") %> <%= rs.getString("apellidos") %>
                        </option>
                        <%
                            }
                            rs.close();
                            stmt.close();
                        } catch(Exception e) {
                            out.println("Error: " + e.getMessage());
                        }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="tipo_dispositivo">Tipo de Dispositivo:</label>
                    <select id="tipo_dispositivo" name="tipo_dispositivo" required>
                        <option value="PC">PC</option>
                        <option value="Laptop">Laptop</option>
                        <option value="Tablet">Tablet</option>
                        <option value="Impresora">Impresora</option>
                        <option value="Monitor">Monitor</option>
                        <option value="Otro">Otro</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="marca">Marca:</label>
                    <input type="text" id="marca" name="marca" required>
                </div>
                <div class="form-group">
                    <label for="modelo">Modelo:</label>
                    <input type="text" id="modelo" name="modelo" required>
                </div>
                <div class="form-group">
                    <label for="numero_serie">Número de Serie:</label>
                    <input type="text" id="numero_serie" name="numero_serie">
                </div>
                <div class="form-group">
                    <label for="problema_reportado">Problema Reportado:</label>
                    <textarea id="problema_reportado" name="problema_reportado" required></textarea>
                </div>
                <div class="form-group">
                    <label for="estado">Estado:</label>
                    <select id="estado" name="estado" required>
                        <option value="Recibido">Recibido</option>
                        <option value="En diagnóstico">En diagnóstico</option>
                        <option value="En reparación">En reparación</option>
                        <option value="Reparado">Reparado</option>
                        <option value="Entregado">Entregado</option>
                    </select>
                </div>
                <button type="submit" class="btn">Guardar Dispositivo</button>
            </form>
            
            <h2>Lista de Dispositivos</h2>
            <table id="dispositivosTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Tipo</th>
                        <th>Marca</th>
                        <th>Modelo</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(
                            "SELECT d.*, c.nombre, c.apellidos FROM dispositivos d " +
                            "JOIN clientes c ON d.id_cliente = c.id_cliente");
                        
                        while(rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id_dispositivo") %></td>
                        <td><%= rs.getString("nombre") %> <%= rs.getString("apellidos") %></td>
                        <td><%= rs.getString("tipo_dispositivo") %></td>
                        <td><%= rs.getString("marca") %></td>
                        <td><%= rs.getString("modelo") %></td>
                        <td><%= rs.getString("estado") %></td>
                        <td>
                            <button onclick="editarDispositivo(<%= rs.getInt("id_dispositivo") %>)">Editar</button>
                            <button onclick="eliminarDispositivo(<%= rs.getInt("id_dispositivo") %>)">Eliminar</button>
                            <button onclick="cambiarEstado(<%= rs.getInt("id_dispositivo") %>)">Cambiar Estado</button>
                        </td>
                    </tr>
                    <%
                        }
                        rs.close();
                        stmt.close();
                    } catch(Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                    %>
                </tbody>
            </table>
        </div>
        
        <!-- Pestaña de Servicios -->
        <div id="servicios" class="tab-content">
            <h2>Registro de Servicios</h2>
            <form id="servicioForm" action="guardarServicio.jsp" method="post">
                <div class="form-group">
                    <label for="id_dispositivo">Dispositivo:</label>
                    <select id="id_dispositivo" name="id_dispositivo" required>
                        <option value="">Seleccione un dispositivo</option>
                        <%
                        try {
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery(
                                "SELECT d.id_dispositivo, d.tipo_dispositivo, d.marca, d.modelo, c.nombre, c.apellidos " +
                                "FROM dispositivos d JOIN clientes c ON d.id_cliente = c.id_cliente");
                            
                            while(rs.next()) {
                        %>
                        <option value="<%= rs.getInt("id_dispositivo") %>">
                            <%= rs.getString("tipo_dispositivo") %> <%= rs.getString("marca") %> 
                            <%= rs.getString("modelo") %> (<%= rs.getString("nombre") %> <%= rs.getString("apellidos") %>)
                        </option>
                        <%
                            }
                            rs.close();
                            stmt.close();
                        } catch(Exception e) {
                            out.println("Error: " + e.getMessage());
                        }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="descripcion_servicio">Descripción del Servicio:</label>
                    <textarea id="descripcion_servicio" name="descripcion_servicio" required></textarea>
                </div>
                <div class="form-group">
                    <label for="costo">Costo:</label>
                    <input type="number" id="costo" name="costo" step="0.01" min="0" required>
                </div>
                <div class="form-group">
                    <label for="tecnico_asignado">Técnico Asignado:</label>
                    <input type="text" id="tecnico_asignado" name="tecnico_asignado" required>
                </div>
                <div class="form-group">
                    <label for="observaciones">Observaciones:</label>
                    <textarea id="observaciones" name="observaciones"></textarea>
                </div>
                <button type="submit" class="btn">Guardar Servicio</button>
            </form>
            
            <h2>Lista de Servicios</h2>
            <table id="serviciosTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Dispositivo</th>
                        <th>Descripción</th>
                        <th>Costo</th>
                        <th>Técnico</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(
                            "SELECT s.*, d.tipo_dispositivo, d.marca, d.modelo, c.nombre, c.apellidos " +
                            "FROM servicios s " +
                            "JOIN dispositivos d ON s.id_dispositivo = d.id_dispositivo " +
                            "JOIN clientes c ON d.id_cliente = c.id_cliente");
                        
                        while(rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id_servicio") %></td>
                        <td>
                            <%= rs.getString("tipo_dispositivo") %> <%= rs.getString("marca") %> 
                            <%= rs.getString("modelo") %><br>
                            (<%= rs.getString("nombre") %> <%= rs.getString("apellidos") %>)
                        </td>
                        <td><%= rs.getString("descripcion_servicio") %></td>
                        <td>$<%= rs.getDouble("costo") %></td>
                        <td><%= rs.getString("tecnico_asignado") %></td>
                        <td>
                            <button onclick="editarServicio(<%= rs.getInt("id_servicio") %>)">Editar</button>
                            <button onclick="eliminarServicio(<%= rs.getInt("id_servicio") %>)">Eliminar</button>
                        </td>
                    </tr>
                    <%
                        }
                        rs.close();
                        stmt.close();
                    } catch(Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                    %>
                </tbody>
            </table>
        </div>
        
        <!-- Pestaña de Historial -->
        <div id="historial" class="tab-content">
            <h2>Historial de Estados</h2>
            <div class="form-group">
                <label for="filtro_dispositivo">Filtrar por Dispositivo:</label>
                <select id="filtro_dispositivo" onchange="filtrarHistorial()">
                    <option value="">Todos los dispositivos</option>
                    <%
                    try {
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(
                            "SELECT d.id_dispositivo, d.tipo_dispositivo, d.marca, d.modelo, c.nombre, c.apellidos " +
                            "FROM dispositivos d JOIN clientes c ON d.id_cliente = c.id_cliente");
                        
                        while(rs.next()) {
                    %>
                    <option value="<%= rs.getInt("id_dispositivo") %>">
                        <%= rs.getString("tipo_dispositivo") %> <%= rs.getString("marca") %> 
                        <%= rs.getString("modelo") %> (<%= rs.getString("nombre") %> <%= rs.getString("apellidos") %>)
                    </option>
                    <%
                        }
                        rs.close();
                        stmt.close();
                    } catch(Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                    %>
                </select>
            </div>
            
            <table id="historialTable">
                <thead>
                    <tr>
                        <th>Dispositivo</th>
                        <th>Estado Anterior</th>
                        <th>Estado Nuevo</th>
                        <th>Fecha Cambio</th>
                        <th>Usuario</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(
                            "SELECT h.*, d.tipo_dispositivo, d.marca, d.modelo, c.nombre, c.apellidos " +
                            "FROM historial_estados h " +
                            "JOIN dispositivos d ON h.id_dispositivo = d.id_dispositivo " +
                            "JOIN clientes c ON d.id_cliente = c.id_cliente " +
                            "ORDER BY h.fecha_cambio DESC");
                        
                        while(rs.next()) {
                    %>
                    <tr>
                        <td>
                            <%= rs.getString("tipo_dispositivo") %> <%= rs.getString("marca") %> 
                            <%= rs.getString("modelo") %><br>
                            (<%= rs.getString("nombre") %> <%= rs.getString("apellidos") %>)
                        </td>
                        <td><%= rs.getString("estado_anterior") != null ? rs.getString("estado_anterior") : "N/A" %></td>
                        <td><%= rs.getString("estado_nuevo") %></td>
                        <td><%= rs.getTimestamp("fecha_cambio") %></td>
                        <td><%= rs.getString("usuario") %></td>
                    </tr>
                    <%
                        }
                        rs.close();
                        stmt.close();
                    } catch(Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Modal para cambiar estado -->
    <div id="estadoModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="cerrarModal()">&times;</span>
            <h2>Cambiar Estado del Dispositivo</h2>
            <form id="cambiarEstadoForm" onsubmit="return confirmarCambioEstado()">
                <input type="hidden" id="modal_id_dispositivo">
                <div class="form-group">
                    <label for="estado_actual">Estado Actual:</label>
                    <input type="text" id="estado_actual" readonly>
                </div>
                <div class="form-group">
                    <label for="nuevo_estado">Nuevo Estado:</label>
                    <select id="nuevo_estado" required>
                        <option value="">Seleccione un estado</option>
                        <option value="Recibido">Recibido</option>
                        <option value="En diagnóstico">En diagnóstico</option>
                        <option value="En reparación">En reparación</option>
                        <option value="Reparado">Reparado</option>
                        <option value="Entregado">Entregado</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="usuario">Usuario:</label>
                    <input type="text" id="usuario" required>
                </div>
                <button type="submit" class="btn">Actualizar Estado</button>
            </form>
        </div>
    </div>
    
    <script src="js/script.js"></script>
</body>
</html>
<%
    if(con != null) {
        try {
            con.close();
        } catch(Exception e) {
            out.println("Error al cerrar conexión: " + e.getMessage());
        }
    }
%>