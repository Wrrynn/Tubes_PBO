package controllers;

import classes.JDBC;
import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "EditAkunController", urlPatterns = {"/edit-akun"})
public class EditAkunController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        JDBC db = new JDBC();

        try {
            String query = "SELECT u.id, u.username, "
                    + "  COALESCE(SUM(p.nominal), 0) - COALESCE(SUM(pg.nominal), 0) AS saldo "
                    + "FROM user u "
                    + "LEFT JOIN pemasukan p ON u.id = p.id_user "
                    + "LEFT JOIN pengeluaran pg ON u.id = pg.id_user "
                    + "GROUP BY u.id, u.username";
            ArrayList<ArrayList<Object>> result = db.query(query);

            List<Map<String, Object>> userList = new ArrayList<>();
            for (ArrayList<Object> row : result) {
                Map<String, Object> userData = new HashMap<>();
                int id = (int) row.get(0);
                userData.put("id", id);
                userData.put("username", row.get(1));
                userData.put("saldo", row.get(2));
                userData.put("aksi", "<a href='hapus-akun?id=" + id + "' class='text-danger'>Hapus</a>");
                userList.add(userData);
            }

            request.setAttribute("list", userList);
            request.setAttribute("page", "editAkun");
            request.getRequestDispatcher("admin/homepage.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/homepage.jsp?page=editAkun&error=database");
        }
    }
}
