<%@ page import="smda.models.Analysis" %>
<%@ page import="smda.models.Interval" %>
<%@ page import="smda.models.MeasurementList" %>
<%@ page import="smda.services.AnalysisService" %>
<%@ page import="smda.services.Interpolator" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
    Date[] dates = null;
    Float[] hct = null;
    Float[] hgb = null;
    Float[] wbc = null;
    Float[] limpho_perc = null;
    Float[] neutrophil_perc = null;
    Float[] neutrophil_stick_perc = null;
    Float[] neutrophil_sya_perc = null;
    Date[] fDates = null;
    Float[] f = null;

    String name = request.getParameter("patient");
    String _dates = request.getParameter("date");
    String[] __dates = _dates != null ? _dates.split(",") : null;
    Date date1 = null;
    Date date2 = null;
    if(__dates != null && __dates.length == 2){
        SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
        date1 = df.parse(__dates[0]);
        date2 = df.parse(__dates[1]);
    }
    String _consider = request.getParameter("consider");
    String[] consider = _consider != null ? _consider.split(",") : null;

    MeasurementList ml = AnalysisService.getMeasurementList(name, consider, date1, date2);
    Interpolator.interpolate(ml);
    List<Interval> itvs = AnalysisService.split(ml, 3);

    int nIntervals = itvs.size();
    if(nIntervals > 0) {
        fDates = new Date[nIntervals];
        f = new Float[nIntervals];
        for (int i = 0; i < nIntervals; i++) {
            fDates[i] = itvs.get(i).getIntervalDate();
            f[i] = itvs.get(i).calculateF();
            System.out.println("f[" + i + "] = " + f[i] + "(size = " + itvs.get(i).size() + ")");
        }
    }

    dates = ml.getArrayDate();
    hct = ml.getArray(Analysis.Parameter.hct);
    hgb = ml.getArray(Analysis.Parameter.hgb);
    wbc = ml.getArray(Analysis.Parameter.wbc);
    limpho_perc = ml.getArray(Analysis.Parameter.limpho_perc);
    neutrophil_perc = ml.getArray(Analysis.Parameter.neutrophil_perc);
    neutrophil_stick_perc = ml.getArray(Analysis.Parameter.neutrophil_stick_perc);
    neutrophil_sya_perc = ml.getArray(Analysis.Parameter.neutrophil_sya_perc);

    System.out.println();
%>

</head>
<body style="background-color:#FFFFFF;">
<center>
 <h2>Боткинский лист: "<%=name%>"</h2>

<% if(hct != null){ %>
    <h3>Гематокрит</h3><div name="hct" id="hct" class="graph_container"></div>
<% } %>

<% if(hgb != null){ %>
    <h3>Гемоглобин</h3> <div name="hgb" id="hgb" class="graph_container"> </div>
<% } %>

<% if(wbc != null){ %>
    <h3>Лейкоциты</h3><div name="wbc" id="wbc" class="graph_container"></div>
<% } %>

<% if(limpho_perc != null){ %>
    <h3>Лимфоциты, %</h3><div name="limpho_perc" id="limpho_perc" class="graph_container"></div>
<% } %>

<% if(neutrophil_perc != null){ %>
    <h3>Нейтрофилы, %</h3><div name="neutrophil_perc" id="neutrophil_perc" class="graph_container"></div>
<% } %>

<% if(neutrophil_stick_perc != null){ %>
    <h3>Нейтрофилы палочкоядерные, %</h3><div name="neutrophil_stick_perc" id="neutrophil_stick_perc" class="graph_container"></div>
<% } %>

<% if(neutrophil_sya_perc != null){ %>
    <h3>Нейтрофилы сегментоядерные, %</h3><div name="neutrophil_sya_perc" id="neutrophil_sya_perc" class="graph_container"></div>
<% } %>

<% if(f != null){ %>
<h3>Функционал</h3><div name="functional" id="functional" class="graph_container"></div>
<% } %>

<script type="text/javascript">

    function setOptions(array) {
        return {
            height: '150px',
            start: array[0].x,
            end: array[array.length - 1].x
        }
    }

    <% if(hct != null) { %>
        var container1 = document.getElementById('hct');
        var items1 = [];
        <% for (int i=0; i<dates.length; i++) { %>
            items1.push({x: "<%= dates[i] %>", y: "<%= hct[i] %>"});
        <% } %>
        var dataset1 = new vis.DataSet(items1);
        var graph2d1 = new vis.Graph2d(container1, dataset1, setOptions(items1));
    <%} %>

    <% if(hgb != null) { %>
        var container2 = document.getElementById('hgb');
        var items2 = [];
        <% for (int i=0; i<dates.length; i++) { %>
            items2.push({x: "<%= dates[i] %>", y: "<%= hgb[i] %>"});
        <% } %>
        var dataset2 = new vis.DataSet(items2);
        var graph2d2 = new vis.Graph2d(container2, dataset2, setOptions(items2));
    <%} %>

    <% if(wbc != null) { %>
        var container3 = document.getElementById('wbc');
        var items3 = [];
        <% for (int i=0; i<dates.length; i++) { %>
            items3.push({x: "<%= dates[i] %>", y: "<%= wbc[i] %>"});
        <% } %>
        var dataset3 = new vis.DataSet(items3);
        var graph2d3 = new vis.Graph2d(container3, dataset3, setOptions(items3));
    <%} %>

    <% if(limpho_perc != null) { %>
        var container4 = document.getElementById('limpho_perc');
        var items4 = [];
        <% for (int i=0; i<dates.length; i++) { %>
            items4.push({x: "<%= dates[i] %>", y: "<%= limpho_perc[i] %>"});
        <% } %>
        var dataset4 = new vis.DataSet(items4);
        var graph2d4 = new vis.Graph2d(container4, dataset4, setOptions(items4));
    <%} %>

    <% if(neutrophil_perc != null) { %>
        var container5 = document.getElementById('neutrophil_perc');
        var items5 = [];
        <% for (int i=0; i<dates.length; i++) { %>
            items5.push({x: "<%= dates[i] %>", y: "<%= neutrophil_perc[i] %>"});
        <% } %>
        var dataset5 = new vis.DataSet(items5);
        var graph2d5 = new vis.Graph2d(container5, dataset5, setOptions(items5));
    <%} %>

    <% if(neutrophil_stick_perc != null) { %>
        var container6 = document.getElementById('neutrophil_stick_perc');
        var items6 = [];
        <% for (int i=0; i<dates.length; i++) { %>
            items6.push({x: "<%= dates[i] %>", y: "<%= neutrophil_stick_perc[i] %>"});
        <% } %>
        var dataset6 = new vis.DataSet(items6);
        var graph2d6 = new vis.Graph2d(container6, dataset6, setOptions(items6));
    <%} %>

    <% if(neutrophil_sya_perc != null) { %>
        var container7 = document.getElementById('neutrophil_sya_perc');
        var items7 = [];
        <% for (int i=0; i<dates.length; i++) { %>
            items7.push({x: "<%= dates[i] %>", y: "<%= neutrophil_sya_perc[i] %>"});
        <% } %>
        var dataset7 = new vis.DataSet(items7);
        var graph2d7 = new vis.Graph2d(container7, dataset7, setOptions(items7));
    <%} %>

    <% if(f != null) { %>
        var containerF = document.getElementById('functional');
        var itemsF = [];
        <% for (int i=0; i<f.length; i++) { %>
            itemsF.push({x: "<%= fDates[i] %>", y: "<%= f[i] %>"});
        <% } %>
        var datasetF = new vis.DataSet(itemsF);
        var graph2dF = new vis.Graph2d(containerF, datasetF, setOptions(itemsF));
    <%} %>

</script>
</center>
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
</body>
</html>
