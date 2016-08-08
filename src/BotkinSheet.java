import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by m.lapaev on 26.07.16.
 */
public class BotkinSheet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Map<String, String[]> params = request.getParameterMap();
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            conn =
                    DriverManager.getConnection("jdbc:mysql://localhost/botkin?" +
                            "user=root&password=12345");
            Statement st = conn.createStatement();
            String sql = "select * from analysis" + (params.get("patient") == null || params.get("patient").equals("") ? " " : " where patientId = " + request.getParameter("patient"));
            ResultSet rs = st.executeQuery(sql);
            List<Analysis> list1 = new ArrayList<Analysis>();
            Analysis a;
            while (rs.next()) {
                a = new Analysis();
                a.setId(rs.getInt("id"));
                a.setDate(rs.getDate("date"));
                a.setHct(rs.getFloat("hct"));
                a.setHgb(rs.getFloat("hgb"));
                a.setWbc(rs.getFloat("wbc"));
                a.setLimpho_perc(rs.getFloat("limpho_perc"));
                a.setNeutrophil_perc(rs.getFloat("neutrophil_perc"));
                a.setNeutrophil_stick_perc(rs.getFloat("neutrophil_stick_perc"));
                a.setNeutrophil_sya_perc(rs.getFloat("neutrophil_sya_perc"));
                a.setPatientId(rs.getString("patientId"));
                list1.add(a);
            }
            Gson gson = new Gson();
            JsonElement element = gson.toJsonTree(list1, new TypeToken<List<Analysis>>() {
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
