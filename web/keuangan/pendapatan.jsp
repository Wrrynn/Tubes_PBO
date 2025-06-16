<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<ArrayList<Object>> list = (ArrayList<ArrayList<Object>>) request.getAttribute("listPemasukan");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Data Pendapatan</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #000;
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
                border: 2px solid #a566ff;
                border-radius: 20px;
                overflow: hidden;
            }
            table.custom-table thead {
                background-color: #a566ff;
                color: white;
            }
            table.custom-table th,
            table.custom-table td {
                border: 1px solid #a566ff;
                text-align: center;
                padding: 10px;
            }
            table.custom-table tbody tr:nth-child(even) {
                background-color: #1a1a1a;
            }
            table.custom-table tbody tr:nth-child(odd) {
                background-color: #111;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h3>Pendapatan</h3>
            <table class="custom-table">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Tanggal</th>
                        <th>Bank</th>
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
                        <td><%= row.get(0)%></td> <%-- tanggal --%>
                        <td><%= row.get(1)%></td> <%-- bank --%>
                        <td>Rp <%= row.get(2)%></td> <%-- nominal --%>
                        <td><%= row.get(3)%></td> <%-- kategori --%>
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
    </body>
</html>
