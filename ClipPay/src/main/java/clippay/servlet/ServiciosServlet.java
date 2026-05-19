package clippay.servlet;

import clippay.dao.ServicioDAO;
import clippay.model.Servicio;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/servicios")
public class ServiciosServlet extends HttpServlet {
    
    private ServicioDAO servicioDAO = new ServicioDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            String mostrarInactivos = request.getParameter("mostrarInactivos");
            boolean soloActivos = !"true".equals(mostrarInactivos);
            
            List<Servicio> servicios = servicioDAO.listarTodos(soloActivos);
            request.setAttribute("servicios", servicios);
            request.setAttribute("mostrandoInactivos", !soloActivos);
            request.getRequestDispatcher("/pages/admin/servicios/listar.jsp").forward(request, response);
            
        } else if (action.equals("nuevo")) {
            request.getRequestDispatcher("/pages/admin/servicios/crear.jsp").forward(request, response);
            
        } else if (action.equals("editar")) {
            int serId = Integer.parseInt(request.getParameter("id"));
            Servicio servicio = servicioDAO.buscarPorId(serId);
            request.setAttribute("servicio", servicio);
            request.getRequestDispatcher("/pages/admin/servicios/editar.jsp").forward(request, response);
            
        } else if (action.equals("eliminar")) {
            int serId = Integer.parseInt(request.getParameter("id"));
            Servicio servicio = servicioDAO.buscarPorId(serId);
            servicioDAO.desactivar(serId);
            request.getSession().setAttribute("mensaje", "Servicio \"" + servicio.getSerNombre() + "\" desactivado correctamente");
            response.sendRedirect(request.getContextPath() + "/admin/servicios");
            
        } else if (action.equals("reactivar")) {
            int serId = Integer.parseInt(request.getParameter("id"));
            Servicio servicio = servicioDAO.buscarPorId(serId);
            servicioDAO.reactivar(serId);
            request.getSession().setAttribute("mensaje", "Servicio \"" + servicio.getSerNombre() + "\" reactivado correctamente");
            response.sendRedirect(request.getContextPath() + "/admin/servicios?mostrarInactivos=true");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action.equals("registrar")) {
            String nombre = request.getParameter("nombre");
            double precio = Double.parseDouble(request.getParameter("precio"));
            double comision = Double.parseDouble(request.getParameter("comision"));
            
            if (servicioDAO.existeNombre(nombre)) {
                request.setAttribute("error", "El nombre del servicio ya existe");
                request.getRequestDispatcher("/pages/admin/servicios/crear.jsp").forward(request, response);
                return;
            }
            
            Servicio servicio = new Servicio();
            servicio.setSerNombre(nombre);
            servicio.setSerPrecio(precio);
            servicio.setSerComisionPorcentaje(comision);
            
            if (servicioDAO.registrar(servicio)) {
                request.getSession().setAttribute("mensaje", "Servicio \"" + nombre + "\" registrado correctamente");
                response.sendRedirect(request.getContextPath() + "/admin/servicios");
            } else {
                request.setAttribute("error", "Error al registrar servicio");
                request.getRequestDispatcher("/pages/admin/servicios/crear.jsp").forward(request, response);
            }
            
        } else if (action.equals("actualizar")) {
            int serId = Integer.parseInt(request.getParameter("serId"));
            String nombre = request.getParameter("nombre");
            double precio = Double.parseDouble(request.getParameter("precio"));
            double comision = Double.parseDouble(request.getParameter("comision"));
            
            Servicio servicioActual = servicioDAO.buscarPorId(serId);
            if (!servicioActual.getSerNombre().equals(nombre) && servicioDAO.existeNombre(nombre)) {
                request.setAttribute("error", "El nombre del servicio ya existe");
                request.setAttribute("servicio", servicioActual);
                request.getRequestDispatcher("/pages/admin/servicios/editar.jsp").forward(request, response);
                return;
            }
            
            Servicio servicio = new Servicio();
            servicio.setSerId(serId);
            servicio.setSerNombre(nombre);
            servicio.setSerPrecio(precio);
            servicio.setSerComisionPorcentaje(comision);
            
            if (servicioDAO.actualizar(servicio)) {
                request.getSession().setAttribute("mensaje", "Servicio actualizado correctamente");
                response.sendRedirect(request.getContextPath() + "/admin/servicios");
            } else {
                request.setAttribute("error", "Error al actualizar servicio");
                request.setAttribute("servicio", servicio);
                request.getRequestDispatcher("/pages/admin/servicios/editar.jsp").forward(request, response);
            }
        }
    }
}