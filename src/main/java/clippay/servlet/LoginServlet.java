package clippay.servlet;

import clippay.dao.UsuarioDAO;
import clippay.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String pin = request.getParameter("pin");

        if (username == null || pin == null || username.trim().isEmpty() || pin.trim().isEmpty()) {
            request.setAttribute("error", "Usuario y PIN son obligatorios");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        Usuario user = dao.login(username, pin);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", user);
            session.setAttribute("usuario_id", user.getUsuId());
            session.setAttribute("username", user.getUsuNombre());
            session.setAttribute("rol", user.getRolNombre());
            session.setAttribute("emp_id", user.getEmpId());
            session.setAttribute("emp_nombre", user.getEmpNombre());
            session.setAttribute("emp_apellido", user.getEmpApellido());
            
            System.out.println("Login exitoso: " + username + " - Rol: " + user.getRolNombre());
            
            if ("ADMIN".equalsIgnoreCase(user.getRolNombre())) {
                response.sendRedirect(request.getContextPath() + "/admin/empleados"); 
            } else if ("BARBERO".equalsIgnoreCase(user.getRolNombre())) {
                response.sendRedirect(request.getContextPath() + "/barbero/panel");
            } else if ("RECEPCIONISTA".equalsIgnoreCase(user.getRolNombre())) {
                response.sendRedirect(request.getContextPath() + "/pages/recepcion/panel.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            }
        } else {
            request.setAttribute("error", "Usuario o PIN incorrectos");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
}