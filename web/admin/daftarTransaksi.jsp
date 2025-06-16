<%-- 
    Document   : daftarTransaksi
    Created on : 14 Jun 2025, 07.03.54
    Author     : dwiwi
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Daftar Transaksi</title>
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
    </style>
    </head>
    <body>
    <div class="container mt-5">
        <h3>Daftar Transaksi</h3>
        <table class="custom-table">
            <thead>
                <tr>
                    <th>NO</th>
                    <th>Tanggal</th>
                    <th>Nama Pengirim</th>
                    <th>Nama Penerima</th>
                    <th>Jumlah</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("list");
                    int i = 1;
                    if (list != null && !list.isEmpty()) {
                        for (Map<String, Object> row : list) {
                %>
                <tr>
                    <td><%= i %></td>
                    <td><%= row.get("tanggal") %></td>
                    <td><%= row.get("username") %></td>
                    <td><%= row.get("username") %></td>
                    <td><%= row.get("jum_uang") %></td>
                </tr>
                <%
                            i++;
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">Belum ada transaksi</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
