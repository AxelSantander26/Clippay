package clippay.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Rutas que NO requieren autenticación
        boolean isPublicResource
                = uri.endsWith("/login")
                || // Servlet de login
                uri.contains("/assets/")
                || // Recursos estáticos
                uri.endsWith(".css")
                || uri.endsWith(".js")
                || uri.endsWith(".png")
                || uri.endsWith(".jpg")
                || uri.endsWith(".ico")
                || uri.equals(contextPath + "/")
                || // Raíz
                uri.equals(contextPath);

        if (isPublicResource) {
            chain.doFilter(request, response);
            return;
        }

        // Verificar si el usuario está autenticado
        if (session == null || session.getAttribute("usuario_id") == null) {
            // Redirigir al SERVLET /login, no al JSP directamente
            res.sendRedirect(contextPath + "/login");
            return;
        }

        // Verificar roles según la URL
        String rol = (String) session.getAttribute("rol");

        if (uri.contains("/admin/") && !"ADMIN".equals(rol)) {
            res.sendRedirect(contextPath + "/login?error=sin_permiso");
            return;
        }
        if (uri.contains("/barbero/") && !"BARBERO".equals(rol)) {
            res.sendRedirect(contextPath + "/login?error=sin_permiso");
            return;
        }
        if (uri.contains("/recepcion/") && !"RECEPCIONISTA".equals(rol)) {
            res.sendRedirect(contextPath + "/login?error=sin_permiso");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
