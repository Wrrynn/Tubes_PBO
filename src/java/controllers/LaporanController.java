package controllers;

import classes.JDBC;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "LaporanController", urlPatterns = {"/laporan"})
public class LaporanController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        JDBC db = new JDBC();

        // Ambil total pemasukan
        int totalPendapatan = 0;
        String pemasukanSql = String.format("SELECT COALESCE(SUM(nominal), 0) FROM pemasukan WHERE id_user = %d", userId);
        ArrayList<ArrayList<Object>> pemasukan = db.query(pemasukanSql);
        if (!pemasukan.isEmpty() && !pemasukan.get(0).isEmpty()) {
            totalPendapatan = ((Number) pemasukan.get(0).get(0)).intValue();
        }

        // Ambil total pengeluaran
        int totalPengeluaran = 0;
        String pengeluaranSql = String.format("SELECT COALESCE(SUM(nominal), 0) FROM pengeluaran WHERE id_user = %d", userId);
        ArrayList<ArrayList<Object>> pengeluaran = db.query(pengeluaranSql);
        if (!pengeluaran.isEmpty() && !pengeluaran.get(0).isEmpty()) {
            totalPengeluaran = ((Number) pengeluaran.get(0).get(0)).intValue();
        }

        int totalLaba = totalPendapatan - totalPengeluaran;

        // Ambil data kategori pengeluaran
        String kategoriSql = String.format(
            "SELECT kategori, SUM(nominal) as total FROM pengeluaran WHERE id_user = %d GROUP BY kategori", userId
        );
        ArrayList<ArrayList<Object>> kategoriData = db.query(kategoriSql);

        ArrayList<String> kategoriList = new ArrayList<>();
        ArrayList<Integer> nominalList = new ArrayList<>();

        for (ArrayList<Object> row : kategoriData) {
            kategoriList.add((String) row.get(0));
            nominalList.add(((Number) row.get(1)).intValue());
        }

        // Kirim data ke JSP
        request.setAttribute("totalPendapatan", totalPendapatan);
        request.setAttribute("totalPengeluaran", totalPengeluaran);
        request.setAttribute("totalLaba", totalLaba);
        request.setAttribute("kategoriList", kategoriList);
        request.setAttribute("nominalList", nominalList);

        request.getRequestDispatcher("keuangan/homepage.jsp").forward(request, response);
    }
}
