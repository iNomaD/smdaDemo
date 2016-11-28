<%@ page import="smda.models.Analysis" %>
<%@ page import="smda.models.Interval" %>
<%@ page import="smda.models.MeasurementList" %>
<%@ page import="smda.services.AnalysisService" %>
<%@ page import="smda.services.Interpolator" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>

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

    <%
        //init variables
        boolean isFunctionalPossible = true;
        Date[] dates = null;
        Map<Analysis.Parameter, Float[]> vals = new HashMap<>();
        Date[] fDates = null;
        Float[] f = null;

        //resolve request parameters
        String name = request.getParameter("patient");
        System.out.println("patient=" + name);
        String _dates = request.getParameter("date");
        System.out.println("date=" + _dates);
        String[] __dates = _dates != null ? _dates.split(",") : null;
        Date date1 = null;
        Date date2 = null;
        if (__dates != null && __dates.length == 2) {
            SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
            try {
                date1 = df.parse(__dates[0]);
                date2 = df.parse(__dates[1]);
            } catch (Exception e) {
            }
        }
        String _consider = request.getParameter("consider");
        System.out.println("consider=" + _consider);
        String[] consider = _consider != null ? _consider.split(",") : null;

        //load data
        MeasurementList ml = AnalysisService.getMeasurementList(name, consider, date1, date2);
        if (ml.size() < 4) {
            isFunctionalPossible = false;
        }
        Interpolator.interpolate(ml);
        List<Interval> itvs = AnalysisService.split(ml, 3);

        //calculate FUNCTIONAL
        int nIntervals = itvs.size();
        if (nIntervals > 0) {
            fDates = new Date[nIntervals];
            f = new Float[nIntervals];
            for (int i = 0; i < nIntervals; i++) {
                fDates[i] = itvs.get(i).getIntervalDate();
                f[i] = itvs.get(i).calculateF();
                System.out.println("f[" + i + "] = " + f[i] + "(size = " + itvs.get(i).size() + ")");
            }
        }

        //receive values
        dates = ml.getArrayDate();
        for (Analysis.Parameter p : ml.getConsiderable()) {
            vals.put(p, ml.getArray(p));
        }

        System.out.println();
    %>

</head>
<body style="background-color:#FFFFFF;">
<center>
    <a name="pagetop"></a>
    <h2>Боткинский лист: "<%=name%>"</h2>
    <% if (isFunctionalPossible) {%>
    <% if (f != null) { %>
    <h3>Функционал системы клеток крови</h3>
    <h6>Функционал системы клеток крови является системным параметром с позиций <a href="#bib">известных
        физиологов</a></h6>
    <div name="functional" id="functional" class="graph_container"></div>
    <%for (int i = 0; i < itvs.size(); i++) {%>
    <h3>Интервал <%=(i + 1)%>
    </h3>
    <table width="100%">
    <%
        Set params = itvs.get(i).getConsiderable();
        Analysis.Parameter p = null;
        Iterator iter = params.iterator();
        while (iter.hasNext()) {
            p = (Analysis.Parameter) iter.next();
    %>
    <tr>
        <td>Параметр <%=Analysis.getName(p)%>
        </td>
        <%
            for (int j = 0; j < itvs.get(i).getArray(p).length; j++) {
        %>
        <td><%=itvs.get(i).getArray(p)[j]%></td>
        <%
            }
        %>
    </tr>
    <%
        }
    %>
    </table>
    <%}%>
    <% } %>
    <%} else {%>
    <font color="#FF0000"><h3>Недостаточно данных дря расчёта функционала. Расчёт производиться не будет.
        Будет представлена динамика изменения отдельных показателей системы клеток крови.</h3></font>
    <%}%>
    <% for (Map.Entry<Analysis.Parameter, Float[]> p : vals.entrySet()) { %>
    <h3><%=Analysis.getName(p.getKey())%>
    </h3>
    <div name="parameter_<%=p.getKey().name()%>" id="parameter_<%=p.getKey().name()%>" class="graph_container"></div>
    <% } %>


    <script type="text/javascript">

        function setOptions(array) {
            return {
                height: '150px',
                start: array[0].x,
                end: array[array.length - 1].x,
                moveable: false
            }
        }


        <% if(isFunctionalPossible && f != null) { %>
        var containerF = document.getElementById('functional');
        var itemsF = [];
        <% for (int i=0; i<f.length; i++) { %>
        itemsF.push({x: "<%= fDates[i] %>", y: "<%= f[i] %>"});
        <% } %>
        var datasetF = new vis.DataSet(itemsF);
        var graph2dF = new vis.Graph2d(containerF, datasetF, setOptions(itemsF));
        <%} %>

        <% for(Map.Entry<Analysis.Parameter, Float[]> p : vals.entrySet()){
            Float[] array = p.getValue();
            if(array != null) { %>
        var container_<%=p.getKey().name()%> = document.getElementById('parameter_<%=p.getKey().name()%>');
        var items_<%=p.getKey().name()%> = [];
        <% for (int i=0; i<dates.length; i++) { %>
        items_<%=p.getKey().name()%>.push({x: "<%= dates[i] %>", y: "<%= array[i] %>"});
        <% } %>
        var dataset_<%=p.getKey().name()%> = new vis.DataSet(items_<%=p.getKey().name()%>);
        var graph2d_<%=p.getKey().name()%> = new vis.Graph2d(container_<%=p.getKey().name()%>, dataset_<%=p.getKey().name()%>, setOptions(items_<%=p.getKey().name()%>));
        <%}} %>

    </script>
</center>
<a name="bib"></a>
<ol>
    <li>П.К.Анохина и М. В. Фролова (1987) (Анохин П. К. Узловые вопросы теории функциональной системы. — М. : Наука,
        1980. — 196 с.,
    </li>
    <li>Фролов М. В. Контроль функционального состояния человека-оператора. — М. : Наука, 1987. — 200 с.).</li>
    <li>Куперштоха
        (Куперштох В. Л., Миркин Б. Г., Трофимов В. А. Сумма внутренних связей как показатель качества классификации //
        Автоматика и
        телемеханика. — 1976. — № 3. — С. 133-141.). То есть вот эти 3 ключевые литературные ссылки надо привести
        обязательно.
    </li>
</ol>
<p align="center"><a href="#pagetop">Наверх</a></p>
</body>
</html>
