package controllers;

import classes.JDBC;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "PengeluaranController", urlPatterns = {"/pengeluaran"})
public class PengeluaranController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String menu = request.getParameter("menu");

        if (menu == null || "pengeluaran".equals(menu)) {
            JDBC db = new JDBC();
            String sql = String.format(
                    "SELECT p.tanggal, p.bank, u.username AS nama_penerima, p.nominal, p.kategori, p.penerima "
                    + "FROM pengeluaran p "
                    + "JOIN user u ON p.penerima = u.id "
                    + "WHERE p.id_user = %d "
                    + "ORDER BY p.tanggal DESC",
                    userId
            );
            ArrayList<ArrayList<Object>> pengeluaranList = db.query(sql);

            int saldo = getSaldo(userId);
            session.setAttribute("saldo", saldo);

            request.setAttribute("listPengeluaran", pengeluaranList);
            request.getRequestDispatcher("keuangan/homepage.jsp").forward(request, response);
        } else {
            response.sendRedirect("pengeluaran?menu=pengeluaran");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String menu = request.getParameter("menu");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if ("add".equals(menu)) {
            String bank = request.getParameter("bank");
            String nominalStr = request.getParameter("nominal");
            String kategori = request.getParameter("kategori");
            String penerimaStr = request.getParameter("penerima");

            int userId = (int) session.getAttribute("userId"); // Pengirim

            if (bank != null && nominalStr != null && kategori != null && penerimaStr != null
                    && !bank.isEmpty() && !nominalStr.isEmpty() && !kategori.isEmpty() && !penerimaStr.isEmpty()) {
                try {
                    int nominal = Integer.parseInt(nominalStr);
                    int penerima = Integer.parseInt(penerimaStr);

                    // Validasi saldo cukup
                    int saldoSaatIni = getSaldo(userId);
                    if (nominal > saldoSaatIni) {
                        response.sendRedirect("pengeluaran?menu=pengeluaran&error=saldo_kurang");
                        return;
                    }

                    JDBC db = new JDBC();

                    // 1. Insert pengeluaran dari pengirim
                    String pengeluaranQuery = String.format(
                            "INSERT INTO pengeluaran (bank, id_user, nominal, kategori, tanggal, penerima) "
                            + "VALUES ('%s', %d, %d, '%s', CURDATE(), %d)",
                            bank.replace("'", "\\'"), userId, nominal, kategori.replace("'", "\\'"), penerima
                    );
                    db.runQuery(pengeluaranQuery);

                    String getUsernameQuery = String.format("SELECT username FROM user WHERE id = %d", userId);
                    ArrayList<ArrayList<Object>> result = db.query(getUsernameQuery);
                    String usernamePengirim = "User";

                    if (!result.isEmpty() && !result.get(0).isEmpty()) {
                        usernamePengirim = result.get(0).get(0).toString();
                    }
                    // 2. Insert pemasukan ke penerima
                    String pemasukanQuery = String.format(
                        "INSERT INTO pemasukan (bank, id_user, nominal, kategori, tanggal) " +
                         "VALUES ('%s', %d, %d, '%s', CURDATE())",
                        bank.replace("'", "\\'"), penerima, nominal, kategori.replace("'", "\\'")
                    );

                    db.runQuery(pemasukanQuery);

                    // 3. Update saldo di session pengirim
                    int saldo = getSaldo(userId);
                    session.setAttribute("saldo", saldo);

                    response.sendRedirect("pengeluaran?menu=pengeluaran");

                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect("pengeluaran?menu=pengeluaran&error=invalid_input");
                }
            } else {
                response.sendRedirect("pengeluaran?menu=pengeluaran&error=incomplete");
            }
        } else {
            response.sendRedirect("pengeluaran?menu=pengeluaran");
        }
    }

    private int getSaldo(int userId) {
        JDBC db = new JDBC();
        int totalPemasukan = 0;
        int totalPengeluaran = 0;

        // Hitung total pemasukan
        String pemasukanSql = String.format("SELECT COALESCE(SUM(nominal), 0) FROM pemasukan WHERE id_user = %d", userId);
        ArrayList<ArrayList<Object>> hasil1 = db.query(pemasukanSql);
        if (!hasil1.isEmpty() && !hasil1.get(0).isEmpty()) {
            totalPemasukan = ((Number) hasil1.get(0).get(0)).intValue();
        }

        // Hitung total pengeluaran
        String pengeluaranSql = String.format("SELECT COALESCE(SUM(nominal), 0) FROM pengeluaran WHERE id_user = %d", userId);
        ArrayList<ArrayList<Object>> hasil2 = db.query(pengeluaranSql);
        if (!hasil2.isEmpty() && !hasil2.get(0).isEmpty()) {
            totalPengeluaran = ((Number) hasil2.get(0).get(0)).intValue();
        }

        return totalPemasukan - totalPengeluaran;
    }
}
