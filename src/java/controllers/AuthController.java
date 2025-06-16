package controllers;

import classes.JDBC;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "AuthController", urlPatterns = {"/AuthController"})
public class AuthController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        JDBC db = new JDBC();
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            HttpSession existingSession = request.getSession(false);
            if (existingSession != null) {
                existingSession.invalidate();
            }

            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm_password");
            String username = request.getParameter("username");

            if (!password.equals(confirmPassword)) {
                response.sendRedirect("index.jsp?register_error=1");
                return;
            }

            try {
                String queryCheck = "SELECT * FROM user WHERE email = '" + email + "'";
                if (!db.query(queryCheck).isEmpty()) {
                    response.sendRedirect("index.jsp?register_error=email_used");
                    return;
                }

                String query = "INSERT INTO user (email, password, jum_uang, username) VALUES ('" + email + "', '" + password + "', 0, '" + username + "')";
                db.runQuery(query);
                response.sendRedirect("index.jsp?register_success=1");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("index.jsp?register_error=server");
            }

        } else if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {

                if ("admin123@admin".equals(email) && "admin123".equals(password)) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", "admin");
                    session.setAttribute("username", "Administrator");

                    response.sendRedirect("admin/homepage.jsp");
                    return;
                }

                String query = "SELECT * FROM user WHERE email = '" + email + "' AND password = '" + password + "'";
                var result = db.query(query);

                if (!result.isEmpty()) {
                    var row = result.get(0);
                    int userId = (int) row.get(0);
                    String username = (String) row.get(4);
                    int saldo = (int) row.get(3);

                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", userId);
                    session.setAttribute("userId", userId);
                    session.setAttribute("username", username);
                    session.setAttribute("saldo", saldo);

                    response.sendRedirect("pemasukan?menu=pendapatan");
                } else {
                    response.sendRedirect("index.jsp?error=1");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("index.jsp?error=server");
            }
        }
    }
}
