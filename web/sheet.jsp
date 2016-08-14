<%@ page import="smda.models.Analysis" %>
<%@ page import="smda.models.Interval" %>
<%@ page import="smda.models.MeasurementList" %>
<%@ page import="smda.services.AnalysisService" %>
<%@ page import="smda.services.Interpolator" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>

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
    Float[] hct = null;
    Float[] hgb = null;
    Float[] wbc = null;
    Float[] limpho_perc = null;
    Float[] neutrophil_perc = null;
    Float[] neutrophil_stick_perc = null;
    Float[] neutrophil_sya_perc = null;
    private List<Interval> itvs;
%>
<%
    String name = request.getParameter("patient");

    MeasurementList ml = AnalysisService.getMeasurementList(name);
    Interpolator.interpolate(ml);

    dates = ml.getArrayDate();
    hct = ml.getArray(Analysis.Parameter.hct);
    hgb = ml.getArray(Analysis.Parameter.hgb);
    wbc = ml.getArray(Analysis.Parameter.wbc);
    limpho_perc = ml.getArray(Analysis.Parameter.limpho_perc);
    neutrophil_perc = ml.getArray(Analysis.Parameter.neutrophil_perc);
    neutrophil_stick_perc = ml.getArray(Analysis.Parameter.neutrophil_stick_perc);
    neutrophil_sya_perc = ml.getArray(Analysis.Parameter.neutrophil_sya_perc);

    itvs = AnalysisService.split(ml, 3);
    int nIntervals = itvs.size();

    Date[] fDates = new Date[nIntervals];
    Float[] f = new Float[nIntervals];
    for (int i = 0; i < nIntervals; i++) {
        fDates[i] = itvs.get(i).getIntervalDate();
        f[i] = itvs.get(i).calculateF();
    }

    System.out.println();
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
