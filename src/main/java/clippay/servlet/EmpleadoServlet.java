package clippay.servlet;

import clippay.dao.EmpleadoDAO;
import clippay.model.Empleado;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/empleados")
public class EmpleadoServlet extends HttpServlet {
    
    private EmpleadoDAO empleadoDAO = new EmpleadoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            String mostrarInactivos = request.getParameter("mostrarInactivos");
            boolean soloActivos = !"true".equals(mostrarInactivos);
            
            List<Empleado> empleados = empleadoDAO.listarTodos(soloActivos);
            request.setAttribute("empleados", empleados);
            request.setAttribute("mostrandoInactivos", !soloActivos);
            request.getRequestDispatcher("/pages/admin/empleados/listar.jsp").forward(request, response);
            
        } else if (action.equals("nuevo")) {
            List<String> roles = empleadoDAO.listarRoles();
            request.setAttribute("roles", roles);
            request.getRequestDispatcher("/pages/admin/empleados/registrar.jsp").forward(request, response);
            
        } else if (action.equals("editar")) {
            int empId = Integer.parseInt(request.getParameter("id"));
            Empleado empleado = empleadoDAO.buscarPorId(empId);
            request.setAttribute("empleado", empleado);
            request.getRequestDispatcher("/pages/admin/empleados/editar.jsp").forward(request, response);
            
        } else if (action.equals("eliminar")) {
            int empId = Integer.parseInt(request.getParameter("id"));
            Empleado emp = empleadoDAO.buscarPorId(empId);
            empleadoDAO.desactivar(empId);
            request.getSession().setAttribute("mensaje", "Empleado " + emp.getNombreCompleto() + " desactivado correctamente");
            response.sendRedirect(request.getContextPath() + "/admin/empleados");
            
        } else if (action.equals("reactivar")) {
            int empId = Integer.parseInt(request.getParameter("id"));
            Empleado emp = empleadoDAO.buscarPorId(empId);
            empleadoDAO.reactivar(empId);
            request.getSession().setAttribute("mensaje", "Empleado " + emp.getNombreCompleto() + " reactivado correctamente");
            response.sendRedirect(request.getContextPath() + "/admin/empleados?mostrarInactivos=true");
            
        } else if (action.equals("resetpin")) {
            int usuId = Integer.parseInt(request.getParameter("usuId"));
            int empId = Integer.parseInt(request.getParameter("empId"));
            empleadoDAO.resetearPin(usuId);
            Empleado emp = empleadoDAO.buscarPorId(empId);
            request.getSession().setAttribute("mensaje", "PIN restablecido a 123456 para " + emp.getNombreCompleto());
            response.sendRedirect(request.getContextPath() + "/admin/empleados");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action.equals("registrar")) {
            String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            String usuNombre = request.getParameter("usuNombre");
            String rol = request.getParameter("rol");
            String pin = request.getParameter("pin");
            
            if (empleadoDAO.existeDni(dni)) {
                request.setAttribute("error", "El DNI ya está registrado");
                List<String> roles = empleadoDAO.listarRoles();
                request.setAttribute("roles", roles);
                request.getRequestDispatcher("/pages/admin/empleados/registrar.jsp").forward(request, response);
                return;
            }
            
            if (empleadoDAO.existeUsuario(usuNombre)) {
                request.setAttribute("error", "El nombre de usuario ya existe");
                List<String> roles = empleadoDAO.listarRoles();
                request.setAttribute("roles", roles);
                request.getRequestDispatcher("/pages/admin/empleados/registrar.jsp").forward(request, response);
                return;
            }
            
            Empleado empleado = new Empleado();
            empleado.setEmpDni(dni);
            empleado.setEmpNombre(nombre);
            empleado.setEmpApellido(apellido);
            empleado.setEmpCorreo(correo);
            empleado.setEmpTelefono(telefono);
            
            int rolId = empleadoDAO.obtenerRolId(rol);
            
            if (empleadoDAO.registrar(empleado, usuNombre, rolId, pin)) {
                request.getSession().setAttribute("mensaje", "Empleado " + nombre + " " + apellido + " registrado correctamente");
                response.sendRedirect(request.getContextPath() + "/admin/empleados");
            } else {
                request.setAttribute("error", "Error al registrar empleado");
                List<String> roles = empleadoDAO.listarRoles();
                request.setAttribute("roles", roles);
                request.getRequestDispatcher("/pages/admin/empleados/registrar.jsp").forward(request, response);
            }
            
        } else if (action.equals("actualizar")) {
            int empId = Integer.parseInt(request.getParameter("empId"));
            int usuId = Integer.parseInt(request.getParameter("usuId"));
            String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            String usuNombre = request.getParameter("usuNombre");
            
            Empleado empActual = empleadoDAO.buscarPorId(empId);
            if (!empActual.getUsuNombre().equals(usuNombre) && empleadoDAO.existeUsuario(usuNombre)) {
                request.setAttribute("error", "El nombre de usuario ya existe");
                request.setAttribute("empleado", empActual);
                request.getRequestDispatcher("/pages/admin/empleados/editar.jsp").forward(request, response);
                return;
            }
            
            Empleado empleado = new Empleado();
            empleado.setEmpId(empId);
            empleado.setEmpDni(dni);
            empleado.setEmpNombre(nombre);
            empleado.setEmpApellido(apellido);
            empleado.setEmpCorreo(correo);
            empleado.setEmpTelefono(telefono);
            
            if (empleadoDAO.actualizar(empleado)) {
                empleadoDAO.actualizarUsuario(usuId, usuNombre);
                request.getSession().setAttribute("mensaje", "Empleado actualizado correctamente");
                response.sendRedirect(request.getContextPath() + "/admin/empleados");
            } else {
                request.setAttribute("error", "Error al actualizar empleado");
                request.setAttribute("empleado", empleado);
                request.getRequestDispatcher("/pages/admin/empleados/editar.jsp").forward(request, response);
            }
        }
    }
}