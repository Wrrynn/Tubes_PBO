<%-- 
    Document   : editAkun
    Created on : 14 Jun 2025, 07.18.02
    Author     : dwiwi
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Akun</title>
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
                <h3 class="mb-0">Edit Akun</h3>
            </div>

            <table class="table table-dark table-bordered">
                <thead class="table-light text-dark">
                    <tr>
                        <th>NO</th>
                        <th>ID</th>
                        <th>Nama</th>
                        <th>Saldo</th>
                        <th>Aksi</th>
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
                        <td><%= i++%></td>
                        <td><%= row.get("id") %></td>
                        <td><%= row.get("username")%></td>
                        <td><%= row.get("saldo")%></td>
                        <td><%= row.get("aksi")%></td>
                    </tr>
                    <%      }
                    } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">Belum ada akun.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>
