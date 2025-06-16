<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String p = request.getParameter("page");
    if (p == null || p.isEmpty()) {
        p = (String) request.getAttribute("page");
        if (p == null || p.isEmpty()) {
            p = "DaftarTransaksi";
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Homepage</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    </head>
    <body class="bg-black text-white" style="font-family: 'Poppins', sans-serif;">
        <div class="container py-4">

            <!-- Profil dan Saldo -->
            <div class="d-flex justify-content-between align-items-center px-3 py-5">
                <div class="d-flex align-items-center">
                    <img src="<%= request.getContextPath()%>/src/10.png" alt="Profile" class="rounded-circle me-3" width="120" height="120" style="border: 3px solid #fff;">
                    <div class="mb-3 pt-3">
                        <h4 class="mb-2 fw-semibold text-white">Admin</h4>
                        <small class="text-white">ID xxxxxx</small>
                    </div>
                </div>
            </div>

            <!-- Navigasi -->
            <nav class="d-flex justify-content-center mb-4 gap-5 px-4 pt-2 border-bottom" style="border-color: #777;">
               <!--
                <a href="homepage.jsp?page=daftarTransaksi"
                   class="text-decoration-none <%= p.equals("daftarTransaksi") ? "fw-bold text-white border-bottom border-2 border-white pb-2" : "text-white-50" %>">
                    Daftar Transaksi
                </a>
               -->
                <a href="<%= request.getContextPath()%>/edit-akun"
                   class="text-decoration-none <%= p.equals("editAkun") ? "fw-bold text-white border-bottom border-2 border-white pb-2" : "text-white-50" %>">
                    Edit Akun
                </a>
                <a href="<%= request.getContextPath() %>/admin/homepage.jsp?page=pengaturan"
                   class="<%= p.equals("pengaturan") ? "fw-bold text-white border-bottom border-2 border-white pb-2" : "text-white-50"%> text-decoration-none">
                    Pengaturan</a>
            </nav>

            <!-- Konten Dinamis -->
            <div class="form-wrapper">
             
                <% if ("daftarTransaksi".equals(p)) { %>
                    <jsp:include page="daftarTransaksi.jsp" flush="true" /> 
                <% }else if ("editAkun".equals(p)) { %>
                    <jsp:include page="editAkun.jsp" flush="true" />
                <% } else if ("pengaturan".equals(p)) { %>
                    <jsp:include page="pengaturan.jsp" flush="true" />
                <% } else { %>
                    <p class="text-center">Selamat Datang.</p>
                <% } %>
            </div>

        </div>
    </body>
</html>
