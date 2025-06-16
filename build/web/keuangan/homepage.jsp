<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null || session.getAttribute("userId") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String p = request.getParameter("menu");
    if (p == null || p.isEmpty()) {
        p = "pendapatan";
    }

    String username = (String) session.getAttribute("username");
    String userId = String.valueOf(session.getAttribute("userId"));

    String saldoAttr = String.valueOf(session.getAttribute("saldo"));
    String saldo = (saldoAttr == null || saldoAttr.equals("null")) ? "0" : saldoAttr;
%>

<%
    if (p == null || p.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "pemasukan?menu=pendapatan");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Home Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
        <style>
            .modal-content {
                max-width: 400px;
                margin: auto;
                padding: 1rem;
            }
            .modal-body input.form-control {
                height: 45px;
                font-family: 'Poppins', sans-serif;
                font-weight: 500;
            }
            .btn-custom {
                border: 2px solid #fff;
                color: white;
                background-color: transparent;
                font-family: 'Poppins', sans-serif;
                font-weight: 500;
                padding: 6px 16px;
                border-radius: 999px;
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
            }
            .btn-custom img {
                width: 16px;
                height: 16px;
            }
            .btn-custom:hover {
                background-color: white;
                color: black;
                transition: 0.3s;
            }
            select.form-control option:hover {
                background-color: #7A53D6;
                color: #fff;
            }
        </style>
    </head>
    <body class="bg-black text-white" style="font-family: 'Poppins', sans-serif;">
        <div class="container py-4">

            <!-- Profil -->
            <div class="d-flex justify-content-between align-items-center px-3 py-5">
                <div class="d-flex align-items-center">
                    <img src="<%= request.getContextPath()%>/src/10.png" class="rounded-circle me-3" width="120" height="120" style="border: 3px solid #fff;">
                    <div class="mb-3 pt-3">
                        <h4 class="mb-2 fw-semibold text-white"><%= username%></h4>
                        <small class="text-white">ID <%= userId%></small>
                    </div>
                </div>
                <div class="text-end pt-3">
                    <h4 class="mb-2 fw-bold text-white">Rp. <%= saldo%></h4>
                    <div class="d-flex gap-2 mt-3">
                        <button class="btn-custom" data-bs-toggle="modal" data-bs-target="#modalKirimUang">
                            <img src="<%= request.getContextPath()%>/src/Vector-1.png"> Kirim
                        </button>
                        <button class="btn-custom" data-bs-toggle="modal" data-bs-target="#modalTopUp">
                            <img src="<%= request.getContextPath()%>/src/Vector.png"> Top Up
                        </button>
                    </div>
                </div>
            </div>

            <!-- Navigasi -->
            <nav class="d-flex justify-content-center mb-2 gap-5 px-4 pt-2 border-bottom" style="border-color: #777;">
                <a href="pemasukan?menu=pendapatan" class="<%= p.equals("pendapatan") ? "fw-bold text-white border-bottom border-2 border-white pb-2" : "text-white-50"%> text-decoration-none">Pendapatan</a>
                <a href="pengeluaran?menu=pengeluaran" class="<%= p.equals("pengeluaran") ? "fw-bold text-white border-bottom border-2 border-white pb-2" : "text-white-50"%> text-decoration-none">Pengeluaran</a>
                <a href="laporan?menu=laporanKeuangan" class="<%= p.equals("laporanKeuangan") ? "fw-bold text-white border-bottom border-2 border-white pb-2" : "text-white-50"%> text-decoration-none">Laporan Keuangan</a>
                <a href="settings?menu=pengaturan" class="<%= p.equals("pengaturan") ? "fw-bold text-white border-bottom border-2 border-white pb-2" : "text-white-50"%> text-decoration-none">Pengaturan</a>
            </nav>

            <!-- Konten -->
            <div class="form-wrapper">
                <%
                    switch (p) {
                        case "pendapatan":
                %>
                <jsp:include page="pendapatan.jsp" flush="true" />
                <%
                        break;
                    case "pengeluaran":
                %>
                <jsp:include page="pengeluaran.jsp" flush="true" />
                <%
                        break;
                    case "laporanKeuangan":
                %>
                <jsp:include page="laporanKeuangan.jsp" flush="true" />
                <%
                        break;
                    case "pengaturan":
                %>
                <jsp:include page="pengaturan.jsp" flush="true"/>
                <%
                        break;
                    default:
                %>
                <p style="text-align:center;">Halaman tidak ditemukan</p>
                <%
                    }
                %>
            </div>

            <!-- Modal Kirim Uang -->
            <div class="modal fade" id="modalKirimUang" tabindex="-1" aria-labelledby="modalKirimUangLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content rounded-4" style="background-color: #D9F500;">
                        <div class="modal-header border-0">
                            <h5 class="modal-title fw-bold mx-auto" style="color:black">Kirim Uang</h5>
                            <button type="button" class="btn-close btn-close-black position-absolute end-0 me-3" data-bs-dismiss="modal"></button>
                        </div>
                        <form method="post" action="<%= request.getContextPath()%>/pengeluaran?menu=add">
                            <div class="d-flex flex-column align-items-center gap-3 px-3 pb-4">
                                <input type="hidden" name="id_user" value="<%= session.getAttribute("userId")%>"> <!-- ✅ Sesuai -->
                                <input name="bank" type="text" class="form-control text-black border-3 border-black rounded-4 py-3 px-4 fw-semibold" style="background:#D9F500; width:250px" placeholder="Nama Bank">
                                <input name="penerima" type="number" class="form-control text-black border-3 border-black rounded-4 py-3 px-4 fw-semibold" style="background:#D9F500; width:250px" placeholder="ID Penerima">
                                <input name="nominal" type="number" class="form-control text-black border-3 border-black rounded-4 py-3 px-4 fw-semibold" style="background:#D9F500; width:250px" placeholder="Jumlah Nominal">
                                <select name="kategori" required class="form-control text-black border-3 border-black rounded-4 py-3 px-4 fw-semibold" style="background:#D9F500; width:250px">
                                    <option value="" disabled selected hidden style="color: #41385D">Pilih Opsi</option>
                                    <option value="Makan">Makan</option>
                                    <option value="Kebutuhan">Kebutuhan</option>
                                    <option value="Lainya">Lainya</option>
                                </select>
                                <button type="submit" class="btn btn-dark rounded-4 py-3 px-4 fw-bold" style="color: #D9F500; width: 250px;">Kirim</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Modal Top Up -->
            <div class="modal fade" id="modalTopUp" tabindex="-1" aria-labelledby="modalTopUpLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content rounded-4" style="background-color: #9E6FF7;">
                        <div class="modal-header border-0">
                            <h5 class="modal-title fw-bold mx-auto text-white" id="modalTopUpLabel">Top Up</h5>
                            <button type="button" class="btn-close btn-close-white position-absolute end-0 me-3" data-bs-dismiss="modal"></button>
                        </div>
                        <form method="post" action="<%= request.getContextPath()%>/pemasukan?menu=add">
                            <div class="d-flex flex-column align-items-center gap-3 px-3 pb-4">
                                <input name="bank" type="text" class="form-control text-white border-3 border-white rounded-4 py-3 px-4 fw-semibold" style="background:#9E6FF7; width:250px" placeholder="Nama Bank">
                                <input name="nominal" type="number" class="form-control text-white border-3 border-white rounded-4 py-3 px-4 fw-semibold" style="background:#9E6FF7; width:250px" placeholder="Jumlah Nominal">
                                <select name="kategori" required class="form-control text-white border-3 border-white rounded-4 py-3 px-4 fw-semibold" style="background:#9E6FF7; width:250px">
                                    <option value="" disabled selected hidden style="color: #41385D">Pilih Opsi</option>
                                    <option value="Makan">Makan</option>
                                    <option value="Kebutuhan">Kebutuhan</option>
                                    <option value="Lainya">Lainya</option>
                                </select>
                                <button type="submit" class="btn btn-light rounded-4 py-3 px-4 fw-bold" style="color: #9E6FF7; width: 250px;">Top Up</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
