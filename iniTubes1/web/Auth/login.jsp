<%-- 
    Document   : login
    Created on : 6 Jun 2025, 21.33.29
    Author     : dwiwi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h2>Login</h2>
            </div>
            <div class="card-body">
                <form method="POST" action="<%= request.getContextPath() %>/AuthController">
                    <input type="hidden" name="action" value="login">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="username" placeholder="Username" required>
                        <label>Username</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" name="password" placeholder="Password" required>
                        <label>Password</label>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger mt-3 text-center">
                    Username atau password salah!
                </div>
                <% } %>
            </div>
    </body>
</html>
