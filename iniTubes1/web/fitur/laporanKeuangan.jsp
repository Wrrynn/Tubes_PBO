<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Laporan Keuangan</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts (optional aesthetic) -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
</head>
<body class="bg-black text-white" style="font-family: 'Poppins', sans-serif;">

<div class="container py-4">

    <!-- Profil dan Saldo -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div class="d-flex align-items-center">
            <img src="../src/10.png" alt="Profile" class="rounded-circle me-3" width="80" height="80">
            <div>
                <h4 class="mb-0">Nama Pengguna</h4>
                <small>IDxxxxxxx</small>
            </div>
        </div>
        <div class="text-end">
            <h4 class="mb-2 fw-bold">Rp. xxxxxxx</h4>
            <div class="d-flex justify-content-end gap-2">
                <button class="btn btn-outline-light btn-sm px-3">➤ Kirim</button>
                <button class="btn btn-outline-light btn-sm px-3">＋ Top Up</button>
            </div>
        </div>
    </div>

    <!-- Tabs -->
    <ul class="nav nav-tabs border-secondary mb-4 justify-content-center" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active text-white bg-transparent border-0 border-bottom border-white" id="pendapatan-tab" data-bs-toggle="tab" data-bs-target="#pendapatan" type="button" role="tab">Pendapatan</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link text-white bg-transparent border-0" id="pengeluaran-tab" data-bs-toggle="tab" data-bs-target="#pengeluaran" type="button" role="tab">Pengeluaran</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link text-white bg-transparent border-0" id="analisa-tab" data-bs-toggle="tab" data-bs-target="#analisa" type="button" role="tab">Analisa</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link text-white bg-transparent border-0" id="laporan-tab" data-bs-toggle="tab" data-bs-target="#laporan" type="button" role="tab">Laporan Keuangan</button>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="myTabContent">

        <!-- Tab Pendapatan -->
        <div class="tab-pane fade show active" id="pendapatan" role="tabpanel">
            <h3 class="mb-3">Pendapatan</h3>
            <div class="table-responsive rounded">
                <table class="table table-dark table-borderless table-striped text-center">
                    <thead class="table-primary text-black">
                        <tr>
                            <th>NO</th>
                            <th>Tanggal</th>
                            <th>Nama Pengirim</th>
                            <th>Jumlah</th>
                            <th>Kategori</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>2025-06-01</td>
                            <td>Budi</td>
                            <td>Rp 500.000</td>
                            <td>Gaji</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>2025-06-03</td>
                            <td>Ani</td>
                            <td>Rp 250.000</td>
                            <td>Transfer</td>
                        </tr>
                        <!-- Tambah baris lain jika perlu -->
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Tab Pengeluaran -->
        <div class="tab-pane fade" id="pengeluaran" role="tabpanel">
            <h3 class="mb-3">Pengeluaran</h3>
            <p>Belum ada data pengeluaran.</p>
        </div>

        <!-- Tab Analisa -->
        <div class="tab-pane fade" id="analisa" role="tabpanel">
            <h3 class="mb-3">Analisa</h3>
            <p>Grafik dan insight akan ditampilkan di sini.</p>
        </div>

        <!-- Tab Laporan -->
        <div class="tab-pane fade" id="laporan" role="tabpanel">
            <h3 class="mb-3">Laporan Keuangan</h3>
            <p>Ringkasan laporan keuangan ditampilkan di sini.</p>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>