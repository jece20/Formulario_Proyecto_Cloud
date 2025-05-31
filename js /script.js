// Función para cambiar entre pestañas
function openTab(tabName) {
    // Oculta todos los contenidos de pestañas
    const tabContents = document.getElementsByClassName("tab-content");
    for (let i = 0; i < tabContents.length; i++) {
        tabContents[i].classList.remove("active");
    }
    
    // Desactiva todos los botones de pestañas
    const tabButtons = document.getElementsByClassName("tab-btn");
    for (let i = 0; i < tabButtons.length; i++) {
        tabButtons[i].classList.remove("active");
    }
    
    // Muestra la pestaña actual y activa el botón
    document.getElementById(tabName).classList.add("active");
    event.currentTarget.classList.add("active");
    
    // Guarda la pestaña activa en sessionStorage
    sessionStorage.setItem('activeTab', tabName);
}

// Función para filtrar el historial por dispositivo
function filtrarHistorial() {
    const dispositivoId = document.getElementById("filtro_dispositivo").value;
    const rows = document.querySelectorAll("#historialTable tbody tr");
    
    rows.forEach(row => {
        const rowDispositivoId = row.getAttribute("data-dispositivo-id");
        if (!dispositivoId || rowDispositivoId === dispositivoId) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}

// Funciones para clientes
function editarCliente(id) {
    // Implementar lógica para cargar datos del cliente en un formulario de edición
    alert("Editar cliente con ID: " + id);
    // Aquí podrías hacer una petición AJAX para obtener los datos del cliente
}

function eliminarCliente(id) {
    if (confirm("¿Estás seguro de que deseas eliminar este cliente y todos sus dispositivos asociados?")) {
        fetch('eliminarCliente.jsp?id=' + id)
            .then(response => {
                if (response.ok) {
                    alert("Cliente eliminado correctamente");
                    location.reload();
                } else {
                    alert("Error al eliminar el cliente");
                }
            })
            .catch(error => console.error('Error:', error));
    }
}

// Funciones para dispositivos
function editarDispositivo(id) {
    // Implementar lógica para cargar datos del dispositivo en un formulario de edición
    alert("Editar dispositivo con ID: " + id);
}

function eliminarDispositivo(id) {
    if (confirm("¿Estás seguro de que deseas eliminar este dispositivo y todos sus servicios asociados?")) {
        fetch('eliminarDispositivo.jsp?id=' + id)
            .then(response => {
                if (response.ok) {
                    alert("Dispositivo eliminado correctamente");
                    location.reload();
                } else {
                    alert("Error al eliminar el dispositivo");
                }
            })
            .catch(error => console.error('Error:', error));
    }
}

// Funciones para servicios
function editarServicio(id) {
    // Implementar lógica para cargar datos del servicio en un formulario de edición
    alert("Editar servicio con ID: " + id);
}

function eliminarServicio(id) {
    if (confirm("¿Estás seguro de que deseas eliminar este servicio?")) {
        fetch('eliminarServicio.jsp?id=' + id)
            .then(response => {
                if (response.ok) {
                    alert("Servicio eliminado correctamente");
                    location.reload();
                } else {
                    alert("Error al eliminar el servicio");
                }
            })
            .catch(error => console.error('Error:', error));
    }
}

// Funciones para el modal de cambio de estado
let currentDispositivoId = null;
let currentEstado = null;

function cambiarEstado(idDispositivo, estadoActual) {
    currentDispositivoId = idDispositivo;
    currentEstado = estadoActual;
    
    document.getElementById("modal_id_dispositivo").value = idDispositivo;
    document.getElementById("estado_actual").value = estadoActual;
    document.getElementById("nuevo_estado").value = "";
    document.getElementById("usuario").value = "";
    
    document.getElementById("estadoModal").style.display = "block";
}

function cerrarModal() {
    document.getElementById("estadoModal").style.display = "none";
}

function confirmarCambioEstado() {
    const nuevoEstado = document.getElementById("nuevo_estado").value;
    const usuario = document.getElementById("usuario").value;
    
    if (!nuevoEstado || !usuario) {
        alert("Por favor complete todos los campos");
        return false;
    }
    
    if (nuevoEstado === currentEstado) {
        alert("El nuevo estado debe ser diferente al estado actual");
        return false;
    }
    
    const formData = new FormData();
    formData.append("id_dispositivo", currentDispositivoId);
    formData.append("estado_anterior", currentEstado);
    formData.append("estado_nuevo", nuevoEstado);
    formData.append("usuario", usuario);
    
    fetch('actualizarEstado.jsp', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.ok) {
            alert("Estado actualizado correctamente");
            cerrarModal();
            location.reload();
        } else {
            alert("Error al actualizar el estado");
        }
    })
    .catch(error => console.error('Error:', error));
    
    return false;
}

// Cargar la pestaña activa guardada
document.addEventListener('DOMContentLoaded', function() {
    const activeTab = sessionStorage.getItem('activeTab') || 'clientes';
    document.getElementById(activeTab).classList.add("active");
    document.querySelector(`.tab-btn[onclick="openTab('${activeTab}')"]`).classList.add("active");
    
    // Mostrar mensajes de éxito/error
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('success')) {
        alert("Operación realizada con éxito");
        // Limpiar parámetro de la URL
        window.history.replaceState({}, document.title, window.location.pathname);
    } else if (urlParams.has('error')) {
        alert("Error al realizar la operación");
        window.history.replaceState({}, document.title, window.location.pathname);
    }
    
    // Cerrar modal al hacer clic fuera de él
    window.onclick = function(event) {
        const modal = document.getElementById("estadoModal");
        if (event.target == modal) {
            cerrarModal();
        }
    }
});
