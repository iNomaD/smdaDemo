/**
 * Created by Max on 23.07.2016.
 */

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HelloWorldExample extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Map<String, String[]> params = request.getParameterMap();
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver").newInstance();
            conn =
                    DriverManager.getConnection("jdbc:postgresql://localhost:5432/botkin?" +
                            "user=postgres&password=12345");
            Statement st = conn.createStatement();
            String sql = "select * from patients" + (params.get("pattern") == null || params.get("pattern").equals("") ? " " : " where name LIKE '" + request.getParameter("pattern") + "' ");
            System.out.println(sql);
            ResultSet rs = st.executeQuery(sql);
            List<Patient> list1 = new ArrayList<Patient>();
            Patient p;
            while (rs.next()) {
                p = new Patient();
                p.setId(rs.getString("id"));
                p.setAge(rs.getInt("age"));
                p.setSex(rs.getBoolean("sex"));
                p.setDiagnosis(rs.getString("diagnosis"));
                p.setName(rs.getString("name"));
                list1.add(p);
            }
            Gson gson = new Gson();
            JsonElement element = gson.toJsonTree(list1, new TypeToken<List<Patient>>() {
            }.getType());
            JsonArray jsonArray = element.getAsJsonArray();
            response.setContentType("application/json");
            response.getWriter().print(jsonArray);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
