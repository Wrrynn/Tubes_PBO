package controllers;

import classes.JDBC;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "PemasukanServlet", urlPatterns = {"/pemasukan"})
public class PemasukanController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String menu = request.getParameter("menu"); // gunakan "menu" agar konsisten

        if (menu == null || "pendapatan".equals(menu)) {
            JDBC db = new JDBC();
            String sql = String.format(
                "SELECT tanggal, bank, nominal, kategori FROM pemasukan WHERE id_user = %d ORDER BY tanggal DESC",
                userId
            );
            ArrayList<ArrayList<Object>> pemasukanList = db.query(sql);
            
             int saldo = getSaldo(userId);
               session.setAttribute("saldo", saldo);

            request.setAttribute("listPemasukan", pemasukanList);
            request.getRequestDispatcher("keuangan/homepage.jsp?page=pendapatan").forward(request, response);
        } else {
            response.sendRedirect("keuangan/homepage.jsp?page=pendapatan");
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

        int userId = (int) session.getAttribute("userId");

        if ("add".equals(menu)) {
            String bank = request.getParameter("bank");
            String nominalStr = request.getParameter("nominal");
            String kategori = request.getParameter("kategori");

            if (bank != null && nominalStr != null && kategori != null &&
                !bank.isEmpty() && !nominalStr.isEmpty() && !kategori.isEmpty()) {
                try {
                    int nominal = Integer.parseInt(nominalStr);

                    JDBC db = new JDBC();
                    String query = String.format(
                        "INSERT INTO pemasukan (bank, id_user, nominal, kategori, tanggal) " +
                        "VALUES ('%s', %d, %d, '%s', CURDATE())",
                        bank.replace("'", "\\'"), userId, nominal, kategori.replace("'", "\\'")
                    );

                    db.runQuery(query);
                    
                    int saldo = getSaldo(userId);
                    session.setAttribute("saldo", saldo);

                    // Redirect ke tampilan pendapatan setelah insert
                    response.sendRedirect("pemasukan?menu=pendapatan");

                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect("keuangan/homepage.jsp?page=pendapatan&error=invalid_input");
                }
            } else {
                response.sendRedirect("keuangan/homepage.jsp?page=pendapatan&error=incomplete");
            }
        } else {
            // Jika menu tidak dikenali, kembalikan ke tampilan pendapatan
            response.sendRedirect("pemasukan?menu=pendapatan");
        }
    }
    private int getSaldo(int userId) {
    JDBC db = new JDBC();
    int totalPemasukan = 0;
    int totalPengeluaran = 0;

    String pemasukanSql = String.format("SELECT COALESCE(SUM(nominal), 0) FROM pemasukan WHERE id_user = %d", userId);
    ArrayList<ArrayList<Object>> hasil1 = db.query(pemasukanSql);
    if (!hasil1.isEmpty() && !hasil1.get(0).isEmpty()) {
        totalPemasukan = ((Number) hasil1.get(0).get(0)).intValue();
    }

    String pengeluaranSql = String.format("SELECT COALESCE(SUM(nominal), 0) FROM pengeluaran WHERE id_user = %d", userId);
    ArrayList<ArrayList<Object>> hasil2 = db.query(pengeluaranSql);
    if (!hasil2.isEmpty() && !hasil2.get(0).isEmpty()) {
        totalPengeluaran = ((Number) hasil2.get(0).get(0)).intValue();
    }

    return totalPemasukan - totalPengeluaran;
}

}
