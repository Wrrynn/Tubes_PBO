package controllers;

import classes.JDBC;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "HapusAkunController", urlPatterns = {"/hapus-akun"})
public class HapusAkunController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                JDBC db = new JDBC();

                db.runQuery("DELETE FROM pengeluaran WHERE id_user = " + id);
                db.runQuery("DELETE FROM pemasukan WHERE id_user = " + id);
                db.runQuery("DELETE FROM user WHERE id = " + id);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("edit-akun");
    }
}
