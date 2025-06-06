<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%
    // Cek apakah user sudah login
    if (session.getAttribute("user") == null) {
        response.sendRedirect("Auth/login.jsp");
        return;
    }

    String p = request.getParameter("page");
    if (p == null) {
        p = "pendapatan";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TUBES PBO</title>
    <link rel="stylesheet" href="stylesheet/style.css">
</head>
<body>

    <div class="profile-section">
        <img src="src/10.png" alt="Avatar">
        <div>
            <h4>Nama Pengguna</h4>
            <span>IDxxxxxx</span>
        </div>
    </div>

    <div class="balance">
        <h3>Rp. xxxxxxx</h3>
        <div class="buttons">
            <button class="btn btn-outline-light" onclick="location.href = 'fitur/kirimUang.jsp'"
                    <img src="src/vector-1.png" alt="Kirim Icon">Kirim</button>
            <button class="btn btn-outline-light" onclick="location.href = 'fitur/topUp.jsp'">Top Up</button>
        </div>
    </div>

    <nav class="px-4 pt-3">
        <a href="index.jsp?page=pendapatan" class="<%= p.equals("pendapatan") ? "active" : ""%>">Pendapatan</a>
        <a href="index.jsp?page=pengeluaran" class="<%= p.equals("pengeluaran") ? "active" : ""%>">Pengeluaran</a>
        <a href="index.jsp?page=laporanKeuangan" class="<%= p.equals("laporanKeuangan") ? "active" : ""%>">Laporan Keuangan</a>
    </nav>

    <div class="form-wrapper">
        <% if ("pendapatan".equals(p)) { %>
            <jsp:include page="fitur/pendapatan.jsp" flush="false" />
        <% } else if ("pengeluaran".equals(p)) { %>
            <jsp:include page="fitur/pengeluaran.jsp" flush="false" />
        <% } else if ("laporanKeuangan".equals(p)) {%>
            <jsp:include page="fitur/laporanKeuangan.jsp" flush="false" />
        <% } else { %>
            <p style="text-align:center;">Halaman tidak ditemukan</p>
        <% } %>
    </div>

</body>
</html>
