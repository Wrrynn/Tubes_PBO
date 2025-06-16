<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList" %>
<%
    int pendapatan = (int) request.getAttribute("totalPendapatan");
    int pengeluaran = (int) request.getAttribute("totalPengeluaran");
    int laba = (int) request.getAttribute("totalLaba");

    ArrayList<String> kategoriList = (ArrayList<String>) request.getAttribute("kategoriList");
    ArrayList<Integer> nominalList = (ArrayList<Integer>) request.getAttribute("nominalList");

    NumberFormat nf = NumberFormat.getInstance(new java.util.Locale("id", "ID"));
%>

<div class="container mt-5 text-white" style="font-family: 'Poppins', sans-serif;">
    <!-- ===== Bagian Atas: Ringkasan Laporan ===== -->
    <h2 class="mb-4 fw-bold text-center">Laporan Keuangan</h2>
    <div class="row mb-5">
        <div class="col-md-4 mb-3">
            <div class="p-4 rounded-4 text-center" style="background-color: #28a745;">
                <h5 class="mb-2">Total Pendapatan</h5>
                <h3>Rp <%= nf.format(pendapatan) %></h3>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="p-4 rounded-4 text-center" style="background-color: #dc3545;">
                <h5 class="mb-2">Total Pengeluaran</h5>
                <h3>Rp <%= nf.format(pengeluaran) %></h3>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="p-4 rounded-4 text-center" style="background-color: #007bff;">
                <h5 class="mb-2">Total Laba</h5>
                <h3>Rp <%= nf.format(laba) %></h3>
            </div>
        </div>
    </div>

    <!-- ===== Bagian Kategori Pengeluaran ===== -->
    <div class="row mb-5">
        <div class="col-md-12">
            <div class="p-4 rounded-4 text-white border border-light">
                <h4 class="mb-3">Kategori Pengeluaran</h4>
                <ul class="mb-0">
                    <%
                        if (kategoriList != null && nominalList != null) {
                            for (int i = 0; i < kategoriList.size(); i++) {
                    %>
                        <li><%= kategoriList.get(i) %> : Rp <%= nf.format(nominalList.get(i)) %></li>
                    <%
                            }
                        } else {
                    %>
                        <li>Data kategori tidak tersedia.</li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </div>

    <!-- ===== Bagian Bawah: Grafik Analisis ===== -->
    <h4 class="mb-3 fw-semibold text-center">Analisa</h4>
    <div class="bg-dark rounded-4 p-4 mb-4">
        <canvas id="chartLaporan" height="100"></canvas>
    </div>

    <!-- ===== Pie Chart: Kategori Pengeluaran ===== -->
    <h4 class="mb-3 fw-semibold text-center">Analisa Kategori Pengeluaran</h4>
    <div class="bg-dark rounded-4 p-4">
        <canvas id="pieChart" height="100"></canvas>
    </div>
</div>

<!-- Script Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Bar Chart (Pendapatan, Pengeluaran, Laba)
    const ctx = document.getElementById('chartLaporan').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Pendapatan', 'Pengeluaran', 'Laba'],
            datasets: [{
                label: 'Jumlah (Rp)',
                data: [<%= pendapatan %>, <%= pengeluaran %>, <%= laba %>],
                backgroundColor: ['#28a745', '#dc3545', '#007bff'],
                borderRadius: 10
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return 'Rp ' + value.toLocaleString('id-ID');
                        }
                    }
                }
            }
        }
    });

    // Pie Chart (Kategori Pengeluaran)
    // Pie Chart (Kategori Pengeluaran)
    const pieLabels = [
        <% 
            for (int i = 0; i < kategoriList.size(); i++) { 
                out.print("'" + kategoriList.get(i) + "'"); // kasih tanda petik
                if (i < kategoriList.size() - 1) out.print(", ");
            }
        %>
    ];

    const pieData = [
        <% 
            for (int i = 0; i < nominalList.size(); i++) { 
                out.print(nominalList.get(i));
                if (i < nominalList.size() - 1) out.print(", ");
            }
        %>
    ];

    console.log("Pie Labels:", pieLabels);   // Debug di Console
    console.log("Pie Data:", pieData);       // Debug di Console

    const pieCtx = document.getElementById('pieChart').getContext('2d');
    new Chart(pieCtx, {
        type: 'pie',
        data: {
            labels: pieLabels,
            datasets: [{
                data: pieData,
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#8AFF33', '#FF33F6']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom' }
            }
        }
    });
</script>
