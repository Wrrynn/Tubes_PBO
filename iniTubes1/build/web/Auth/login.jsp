<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

            @keyframes float {
                0% {
                    transform: translateY(0);
                }
                50% {
                    transform: translateY(-10px);
                }
                100% {
                    transform: translateY(0);
                }
            }
            /* Tambahan ini penting */
            ::placeholder {
                color: #b0b0b0 !important; /* Abu-abu */
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
                <div class="col-md-6 d-none d-md-flex justify-content-center align-items-center bg-light">
                    <img src="../src/bgLogin.png" alt="bg" class="img-fluid bg-animation" style="max-height: 90%;">
                </div>

                <!-- Kanan: Form -->
                <div class="col-md-6 d-flex align-items-center justify-content-center bg-black text-white">
                    <div class="w-100" style="max-width: 350px;">
                        <h1 class="fw-bold mb-4">Welcome Back!</h1>

                        <form action="../fitur/laporanKeuangan.jsp" method="post">
                            <div class="mb-3">
                                <input type="email" name="email" placeholder="Email"
                                       class="form-control bg-black text-white border border-white rounded-4 py-3 px-4"
                                       required>
                            </div>
                            <div class="mb-2">
                                <input type="password" name="password" placeholder="Password"
                                       class="form-control bg-black text-white border border-white rounded-4 py-3 px-4"
                                       required>
                            </div>

                            <div class="mb-3">
                                <small>Belum punya akun?
                                    <a href="#" data-bs-toggle="modal" data-bs-target="#registerModal" class="fw-bold text-decoration-none" style="color: #a879ff;">
                                        Daftar Sekarang
                                    </a>
                                </small>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn text-black rounded-4 fw-semibold py-3"
                                        style="background-color: #f2f2f2;">Login</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="registerModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-black text-white rounded-4 p-4">
                    <div class="modal-header border-0">
                        <h5 class="modal-title fw-bold">Register</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="prosesRegister.jsp" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <input type="email" name="email" placeholder="Email"
                                       class="form-control bg-black text-white border border-white rounded-4 py-3 px-4"
                                       required>
                            </div>
                            <div class="mb-3">
                                <input type="password" name="password" placeholder="Password"
                                       class="form-control bg-black text-white border border-white rounded-4 py-3 px-4"
                                       required>
                            </div>
                            <div class="mb-3">
                                <input type="password" name="confirm_password" placeholder="Confirm Password"
                                       class="form-control bg-black text-white border border-white rounded-4 py-3 px-4"
                                       required>
                            </div>
                        </div>
                        <small>Sudah punya akun? 
                            <a href="#" data-bs-dismiss="modal" class="fw-bold text-decoration-none" style="color: #a879ff;">
                                Login Sekarang
                            </a>
                        </small>
                        <div class="modal-footer border-0 d-grid gap-2">
                            <button type="submit" class="btn text-black rounded-4 fw-semibold py-3"
                                    style="background-color: #f2f2f2;">Register</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
