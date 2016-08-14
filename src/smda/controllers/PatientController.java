package smda.controllers; /**
 * Created by Max on 23.07.2016.
 */

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;
import smda.Properties;
import smda.models.Patient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class PatientController extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Map<String, String[]> params = request.getParameterMap();
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver").newInstance();
            conn =
                    DriverManager.getConnection("jdbc:postgresql://"+ Properties.host+"/botkin?" +
                            "user="+Properties.db_username+"&password="+Properties.db_password);
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
