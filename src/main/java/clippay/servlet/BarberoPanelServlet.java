package clippay.servlet;

import clippay.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/barbero/panel")
public class BarberoPanelServlet extends HttpServlet {
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
        String nombreCompleto = user.getEmpNombre() + " " + user.getEmpApellido();
        
        // Datos para el panel
        request.setAttribute("nombreCompleto", nombreCompleto);
        request.setAttribute("rol", user.getRolNombre());
        
        request.getRequestDispatcher("/pages/barbero/panel.jsp").forward(request, response);
    }
}