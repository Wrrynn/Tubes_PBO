<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Cegah user yang sudah login kembali ke halaman ini
    if (session != null && session.getAttribute("user") != null) {
        response.sendRedirect("keuangan/homepage.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        .bg-animation {
            animation: float 4s ease-in-out infinite;
        }

        .bg-custom {
            background-color: #EBE9EA;
        }

        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0); }
        }

        ::placeholder {
            color: #b0b0b0 !important;
            opacity: 1;
        }
        
        :-ms-input-placeholder {
            color: #b0b0b0 !important;
        }
        ::-ms-input-placeholder {
            color: #b0b0b0 !important;
        }
    </style>
</head>
<body class="bg-black text-white">

<div class="container-fluid vh-100">
    <div class="row h-100">
        <!-- Kiri: Gambar -->
        <div class="col-md-6 d-none d-md-flex justify-content-center align-items-center bg-custom">
            <img src="src/bgLogin.png" alt="bg" class="img-fluid bg-animation" style="max-height: 90%;">
        </div>

        <!-- Kanan: Form -->
        <div class="col-md-6 d-flex align-items-center justify-content-center bg-black text-white">
            <div class="w-100" style="max-width: 350px;">
                <h1 class="fw-bold mb-4 text-center">Welcome Back!</h1>

                <form method="POST" action="<%= request.getContextPath() %>/AuthController">
                    <input type="hidden" name="action" value="login">

                    <div class="mb-3 d-flex justify-content-center">
                        <input type="email" name="email" placeholder="Email"
                               class="form-control bg-black text-white border-2 border-white rounded-4 py-3 px-4"
                               style="width:300px" required>
                    </div>
                    <div class="mb-2 d-flex justify-content-center">
                        <input type="password" name="password" placeholder="Password"
                               class="form-control bg-black text-white border-2 border-white rounded-4 py-3 px-4"
                               style="width:300px" required>
                    </div>

                    <div class="mb-3 d-flex justify-content-center">
                        <small>Belum punya akun?
                            <a href="#" data-bs-toggle="modal" data-bs-target="#registerModal"
                               class="fw-bold text-decoration-none" style="color: #a879ff;">Daftar Sekarang</a>
                        </small>
                    </div>

                    <div class="d-grid d-flex justify-content-center">
                        <button type="submit" class="btn text-black rounded-4 fw-semibold py-3"
                                style="background-color: #f2f2f2; width:300px;">Login
                        </button>
                    </div>
                </form>

                <!-- Notifikasi -->
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger mt-3 text-center">Email atau password salah!</div>
                <% } %>

                <% if (request.getParameter("register_error") != null) { %>
                <div class="alert alert-danger mt-3 text-center">Password dan konfirmasi tidak sama!</div>
                <script>
                    // Buka modal register jika error
                    window.onload = function () {
                        var myModal = new bootstrap.Modal(document.getElementById('registerModal'));
                        myModal.show();
                    };
                </script>
                <% } %>

                <% if (request.getParameter("register_success") != null) { %>
                <div class="alert alert-success mt-3 text-center">Registrasi berhasil! Silakan login.</div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- Modal Register -->
<div class="modal fade" id="registerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-black text-white rounded-4 px-4 py-3"
             style="width: 420px; max-width: 100%; min-height: 500px;">

            <div class="modal-header border-0 justify-content-center position-relative">
                <h5 class="modal-title fw-bold text-white">Register</h5>
                <button type="button" class="btn-close btn-close-white position-absolute end-0 me-3"
                        data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form action="<%= request.getContextPath() %>/AuthController" method="post">
                <div class="modal-body d-flex flex-column align-items-center gap-3">
                    <input type="hidden" name="action" value="register">

                    <input type="email" name="email" placeholder="Email"
                           class="form-control bg-black text-white border-2 border-white rounded-4 py-3 px-4"
                           style="width: 300px;" required>

                    <input type="text" name="username" placeholder="Username"
                           class="form-control bg-black text-white border-2 border-white rounded-4 py-3 px-4"
                           style="width: 300px;" required>

                    <input type="password" name="password" placeholder="Password"
                           class="form-control bg-black text-white border-2 border-white rounded-4 py-3 px-4"
                           style="width: 300px;" required>

                    <input type="password" name="confirm_password" placeholder="Confirm Password"
                           class="form-control bg-black text-white border-2 border-white rounded-4 py-3 px-4"
                           style="width: 300px;" required>

                    <small class="text-center text-white">
                        Sudah punya akun?
                        <a href="#" data-bs-dismiss="modal" class="fw-bold text-decoration-none"
                           style="color: #a879ff;">Login Sekarang</a>
                    </small>
                </div>

                <div class="modal-footer border-0 d-flex justify-content-center pt-0">
                    <button type="submit" class="btn text-black fw-semibold rounded-4 py-3 px-5"
                            style="background-color: #f2f2f2; width: 300px;">
                        Register
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
