<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonElement" %>
<%@ page import="com.google.gson.reflect.TypeToken" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>

<%--
  Created by IntelliJ IDEA.
  User: m.lapaev
  Date: 27.07.16
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title></title>
<script src="resources/vis/dist/vis.js"></script>
<link href="resources/vis/dist/vis.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet" type="text/css">

<%!
    Date[] dates = null;
    float[] hct = null;
    float[] hgb = null;
    float[] wbc = null;
    float[] limpho_perc = null;
    float[] neutrophil_perc = null;
    float[] neutrophil_stick_perc = null;
    float[] neutrophil_sya_perc = null;
    private List<Interval> itvs;
%>
<%
    String name = request.getParameter("patient");
    Connection conn = null;
    try {
        Class.forName("org.postgresql.Driver").newInstance();
        conn =
                DriverManager.getConnection("jdbc:postgresql://localhost:5432/botkin?" +
                        "user=postgres&password=12345");
        Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_UPDATABLE);
        String sql = "select analysis.* from analysis " + (name.equals("") ? " " : " where pat_id = '" + request.getParameter("patient") + "' ORDER BY date ASC");
        ResultSet rs = st.executeQuery(sql);
        int count = 0;
        if (rs.last()) {
            count = rs.getRow();
            rs.beforeFirst();
        }
        Date[] tmp = new Date[count];
        count = 0;
        while (rs.next()) {
            tmp[count] = rs.getDate("date");
            count++;
        }
        rs.beforeFirst();
        Date d1 = tmp[0];
        Date d2 = tmp[tmp.length - 1];
        int days = (int) ((d2.getTime() - d1.getTime()) / (1000 * 60 * 60 * 24)) + 2;

        dates = new Date[days];
        Calendar c = Calendar.getInstance();
        c.setTime(d1);
        for (int i = 0; i < dates.length; i++) {
            c.add(Calendar.DATE, 1);
            dates[i] = new java.sql.Date(c.getTime().getTime());
        }
        hct = new float[days];
        hgb = new float[days];
        wbc = new float[days];
        limpho_perc = new float[days];
        neutrophil_perc = new float[days];
        neutrophil_stick_perc = new float[days];
        neutrophil_sya_perc = new float[days];
        for (int i = 0; i < days; i++) {
            hct[i] = -1;
            hgb[i] = -1;
            wbc[i] = -1;
            limpho_perc[i] = -1;
            neutrophil_perc[i] = -1;
            neutrophil_stick_perc[i] = -1;
            neutrophil_sya_perc[i] = -1;
        }
        int index;

        while (rs.next()) {
            index = find(dates, rs.getDate("date"));
            if (index > -1) {
                hct[index] = rs.getFloat("hct");
                hgb[index] = rs.getFloat("hgb");
                wbc[index] = rs.getFloat("wbc");
                limpho_perc[index] = rs.getFloat("limpho_perc");
                neutrophil_perc[index] = rs.getFloat("neutrophil_perc");
                neutrophil_stick_perc[index] = rs.getFloat("neutrophil_stick_perc");
                neutrophil_sya_perc[index] = rs.getFloat("neutrophil_sya_perc");
            }
        }

    } catch (IllegalAccessException e) {
        e.printStackTrace();
    } catch (InstantiationException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    interpolate(hct);
    interpolate(hgb);
    interpolate(wbc);
    interpolate(limpho_perc);
    interpolate(neutrophil_perc);
    interpolate(neutrophil_stick_perc);
    interpolate(neutrophil_sya_perc);

    itvs = new ArrayList<Interval>();
    int nIntervals = hct.length % 3 == 0 ? hct.length / 3 : hct.length / 3 + 1;
    int lastSize = hct.length % 3 == 0 ? 3 : hct.length - (nIntervals - 1) * 3;
    int s = 0;
    Interval interval = null;
    int cursor = 0;
    for (int i = 0; i < nIntervals; i++) {
        s = i == nIntervals - 1 ? lastSize : 3;
        itvs.add(interval = new Interval(s, 7));
        System.arraycopy(hct, cursor, interval.getInterval()[0], 0, s);
        System.arraycopy(hgb, cursor, interval.getInterval()[1], 0, s);
        System.arraycopy(wbc, cursor, interval.getInterval()[2], 0, s);
        System.arraycopy(limpho_perc, cursor, interval.getInterval()[3], 0, s);
        System.arraycopy(neutrophil_perc, cursor, interval.getInterval()[4], 0, s);
        System.arraycopy(neutrophil_stick_perc, cursor, interval.getInterval()[5], 0, s);
        System.arraycopy(neutrophil_sya_perc, cursor, interval.getInterval()[6], 0, s);
        cursor += 3;
    }

    Date[] fDates = new Date[nIntervals];
    int j = 0;
    for (int i = 0; i < dates.length; i++) {
        if (i % 3 == 1) {
            fDates[j] = dates[i];
            j++;
        }
    }
    float[] f = new float[nIntervals];
    for (int i = 0; i < nIntervals; i++) {
        itvs.get(i).calculateF();
        f[i] = itvs.get(i).getF();
    }

    System.out.println();
%>

<%!
    public static void interpolate(float[] arr) {
        for (int i = 0; i < arr.length; ++i) {
            if (arr[i] == -1) {
                int j = i + 1;
                while (j < arr.length && arr[j] == -1) {
                    ++j;
                }
                if (j == arr.length) {
                    if (i == 0) {
                        System.err.println("EMPTY PARAMETER");
                    } else {
                        arr[i] = arr[i - 1];
                    }
                } else {
                    if (i == 0) {
                        arr[i] = arr[j];
                    } else {
                        arr[i] = (arr[i - 1] + arr[j]) / 2;
                    }
                }
            }
        }
    }
%>

<%!
    public static int find(Date[] array, Date date) {
        for (int i = 0; i < array.length; i++) {

            if (array[i].equals(date)) {
                return i;
            }
        }
        return -1;
    }
%>


<%!
    public class Interval {
        private static final float NaN = 666f;
        private static final float a = 0.0f;
        private float mF;
        float[][] interval;
        private final int params;

        public Interval(int size, int params) {
            interval = new float[params][size];
            this.params = params;
        }

        public float[][] getInterval() {
            return interval;
        }

        public void calculateF() {
            mF = 0;
            for (int i = 0; i < params; ++i) {
                for (int j = 0; j < i; ++j) {
                    float corMat_ij = correlation(i, j);
                    if (corMat_ij != NaN) {
                        mF += (corMat_ij) - a;
                    }
                }
            }
            mF = Math.abs(mF);
        }

        private float correlation(int a, int b) {
            int n = interval[0].length;
            float x_mean = 0, y_mean = 0;
            float sum_xx = 0, sum_yy = 0, sum_xy = 0;
            for (int i = 0; i < n; ++i) {
                x_mean += interval[a][i];
                y_mean += interval[b][i];
            }
            x_mean /= n;
            y_mean /= n;
            for (int i = 0; i < n; ++i) {
                sum_xy += (interval[a][i] - x_mean) * (interval[b][i] - y_mean);
                sum_xx += (interval[a][i] - x_mean) * (interval[a][i] - x_mean);
                sum_yy += (interval[b][i] - y_mean) * (interval[b][i] - y_mean);
            }
            if (sum_xx * sum_yy == 0) {
                return NaN;
            } else {
                return sum_xy / (float) Math.sqrt(sum_xx * sum_yy);
            }
        }

        public float getF() {
            return mF;
        }
    }
%>

</head>
<body style="background-color:#FFFFFF;">
<center>
 <h2>Боткинский лист: "<%=name%>"</h2>
<h3>Гематокрит</h3>

<div name="hct" id="hct" class="graph_container">

</div>

<h3>Гемоглобин</h3>

<div name="hgb" id="hgb" class="graph_container">

</div>

<h3>Лейкоциты</h3>

<div name="wbc" id="wbc" class="graph_container">

</div>

<h3>Лимфоциты, %</h3>

<div name="limpho_perc" id="limpho_perc" class="graph_container">

</div>

<h3>Нейтрофилы, %</h3>

<div name="neutrophil_perc" id="neutrophil_perc" class="graph_container">

</div>

<h3>Нейтрофилы палочкоядерные, %</h3>

<div name="neutrophil_stick_perc" id="neutrophil_stick_perc" class="graph_container">

</div>

<h3>Нейтрофилы сегментоядерные, %</h3>

<div name="neutrophil_sya_perc" id="neutrophil_sya_perc" class="graph_container">

</div>

<h3>Функционал</h3>

<div name="functional" id="functional" class="graph_container">

</div>

<script type="text/javascript">
    var container1 = document.getElementById('hct');
    var container2 = document.getElementById('hgb');
    var container3 = document.getElementById('wbc');
    var container4 = document.getElementById('limpho_perc');
    var container5 = document.getElementById('neutrophil_perc');
    var container6 = document.getElementById('neutrophil_stick_perc');
    var container7 = document.getElementById('neutrophil_sya_perc');
    var containerF = document.getElementById('functional');
    var items1 = [

    ];
    var items2 = [

    ];
    var items3 = [

    ];
    var items4 = [

    ];
    var items5 = [

    ];
    var items6 = [

    ];
    var items7 = [

    ];

    var itemsF = [

    ];

    var count = "<%=dates.length%>"
    <% for (int i=0; i<dates.length; i++) { %>
    items1.push({x: "<%= dates[i] %>", y: "<%= hct[i] %>"});
    <% } %>

    <% for (int i=0; i<dates.length; i++) { %>
    items2.push({x: "<%= dates[i] %>", y: "<%= hgb[i] %>"});
    <% } %>

    <% for (int i=0; i<dates.length; i++) { %>
    items3.push({x: "<%= dates[i] %>", y: "<%= wbc[i] %>"});
    <% } %>

    <% for (int i=0; i<dates.length; i++) { %>
    items4.push({x: "<%= dates[i] %>", y: "<%= limpho_perc[i] %>"});
    <% } %>

    <% for (int i=0; i<dates.length; i++) { %>
    items5.push({x: "<%= dates[i] %>", y: "<%= neutrophil_perc[i] %>"});
    <% } %>

    <% for (int i=0; i<dates.length; i++) { %>
    items6.push({x: "<%= dates[i] %>", y: "<%= neutrophil_stick_perc[i] %>"});
    <% } %>

    <% for (int i=0; i<dates.length; i++) { %>
    items7.push({x: "<%= dates[i] %>", y: "<%= neutrophil_sya_perc[i] %>"});
    <% } %>

    var fCount = "<%=f.length%>"
    <% for (int i=0; i<f.length; i++) { %>
    itemsF.push({x: "<%= fDates[i] %>", y: "<%= f[i] %>"});
    <% } %>

    var dataset1 = new vis.DataSet(items1);
    var dataset2 = new vis.DataSet(items2);
    var dataset3 = new vis.DataSet(items3);
    var dataset4 = new vis.DataSet(items4);
    var dataset5 = new vis.DataSet(items5);
    var dataset6 = new vis.DataSet(items6);
    var dataset7 = new vis.DataSet(items7);
    var datasetF = new vis.DataSet(itemsF);

    var options = {
        height: '150px',
        start: items1[0].x,
        end: items1[count - 1].x
    };
    var graph2d1 = new vis.Graph2d(container1, dataset1, options);
    var graph2d2 = new vis.Graph2d(container2, dataset2, options);
    var graph2d3 = new vis.Graph2d(container3, dataset3, options);
    var graph2d4 = new vis.Graph2d(container4, dataset4, options);
    var graph2d5 = new vis.Graph2d(container5, dataset5, options);
    var graph2d6 = new vis.Graph2d(container6, dataset6, options);
    var graph2d7 = new vis.Graph2d(container7, dataset7, options);
    var graph2dF = new vis.Graph2d(containerF, datasetF, options);

</script>
</center>
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
</body>
</html>
