<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<ArrayList<Object>> list = (ArrayList<ArrayList<Object>>) request.getAttribute("listPengeluaran");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Pengeluaran</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #000; /* Hitam */
                color: white;
                font-family: 'Poppins', sans-serif;
            }
            h3 {
                margin-bottom: 20px;
                font-weight: 600;
            }
            table.custom-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                border: 2px solid #D7F44E;
                border-radius: 20px;
                overflow: hidden;
            }
            table.custom-table thead {
                background-color: #D7F44E;
                color: black;
            }
            table.custom-table th,
            table.custom-table td {
                border: 1px solid #D7F44E;
                text-align: center;
                padding: 10px;
            }
            table.custom-table tbody tr:nth-child(even) {
                background-color: #1a1a1a;
            }
            table.custom-table tbody tr:nth-child(odd) {
                background-color: #111;
            }
            table.custom-table th:first-child {
                border-top-left-radius: 20px;
            }
            table.custom-table th:last-child {
                border-top-right-radius: 20px;
            }
            table.custom-table tr:last-child td:first-child {
                border-bottom-left-radius: 20px;
            }
            table.custom-table tr:last-child td:last-child {
                border-bottom-right-radius: 20px;
            }
            .custom-button {
                background-color: #D7F44E;
                color: black;
                font-weight: 600;
                padding: 8px 20px;
                border: none;
                border-radius: 16px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .custom-button:hover {
                background-color: #c8e94c; /* efek hover sedikit lebih gelap */
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="mb-0">Pengeluaran</h3>
                <button class="custom-button" href="#" data-bs-toggle="modal" data-bs-target="#modalAturBatas">Atur Batas</button>
            </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th>NO</th>
                        <th>Tanggal</th>
                        <th>Nama Bank</th>
                        <th>Nama Penerima</th>
                        <th>Jumlah</th>
                        <th>Kategori</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (list != null && !list.isEmpty()) {
                            int no = 1;
                            for (ArrayList<Object> row : list) {
                    %>
                    <tr>
                        <td><%= no++%></td>
                        <td><%= row.get(0)%></td>
                        <td><%= row.get(1)%></td>
                        <td><%= row.get(2)%></td>
                        <td><%= row.get(3)%></td>
                        <td><%= row.get(4)%></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5">Belum ada transaksi</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>

        <!--
        <!-- Popup atur Batas-->
        <div class="modal fade" id="modalAturBatas" tabindex="-1" aria-labelledby="modalAturBatas" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-4" 
                     style="width: 400px; max-width: 100%; min-height: 275px; background-color: #D7F44E;">
                    <div class="modal-header border-0 mb-2">
                        <h5 class="modal-title fw-bold mx-auto" style="color:black" id="modalAturBatas">Atur Batas</h5>
                        <button type="button" class="btn-close btn-close-black position-absolute end-0 me-3" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="d-flex flex-column align-items-center gap-2">
                        <form>
                            <div class="mb-2">
                                <input type="text" class="form-control text-black border-3 border-black rounded-4 py-3 px-4 text-black fw-semibold" 
                                       style="background: #D7F44E; width: 250px" placeholder="Masukan Nominal">
                            </div>
                            <div class="d-grid">
                                <button type="submit" style="color: #D7F44E; width: 250px;" class="btn btn-dark rounded-4 py-3 px-4 fw-bold" data-bs-dismiss="modal">Atur</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        -->
    </body>
</html>

