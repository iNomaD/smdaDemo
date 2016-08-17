<%@ page import="smda.models.Analysis" %>
<%@ page import="smda.models.Interval" %>
<%@ page import="smda.models.MeasurementList" %>
<%@ page import="smda.services.AnalysisService" %>
<%@ page import="smda.services.Interpolator" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

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
    Date[] dates = null;
    Map<Analysis.Parameter, Float[]> vals= new HashMap<>();
    Date[] fDates = null;
    Float[] f = null;

    //resolve request parameters
    String name = request.getParameter("patient");
    System.out.println("patient="+name);
    String _dates = request.getParameter("date");
    System.out.println("date="+_dates);
    String[] __dates = _dates != null ? _dates.split(",") : null;
    Date date1 = null;
    Date date2 = null;
    if(__dates != null && __dates.length == 2){
        SimpleDateFormat df = new SimpleDateFormat("dd.MM.yyyy");
        try {
            date1 = df.parse(__dates[0]);
            date2 = df.parse(__dates[1]);
        }catch (Exception e){}
    }
    String _consider = request.getParameter("consider");
    System.out.println("consider="+_consider);
    String[] consider = _consider != null ? _consider.split(",") : null;

    //load data
    MeasurementList ml = AnalysisService.getMeasurementList(name, consider, date1, date2);
    Interpolator.interpolate(ml);
    List<Interval> itvs = AnalysisService.split(ml, 3);

    //calculate FUNCTIONAL
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

    //receive values
    dates = ml.getArrayDate();
    for(Analysis.Parameter p : ml.getConsiderable()){
        vals.put(p, ml.getArray(p));
    }

    System.out.println();
%>

</head>
<body style="background-color:#FFFFFF;">
<center>
 <h2>Боткинский лист: "<%=name%>"</h2>

    <% if(f != null){ %>
    <h3>Функционал</h3><div name="functional" id="functional" class="graph_container"></div>
    <% } %>

    <% for(Map.Entry<Analysis.Parameter, Float[]> p : vals.entrySet()){ %>
    <h3><%=Analysis.getName(p.getKey())%></h3><div name="parameter_<%=p.getKey().name()%>" id="parameter_<%=p.getKey().name()%>" class="graph_container"></div>
    <% } %>


<script type="text/javascript">

    function setOptions(array) {
        return {
            height: '150px',
            start: array[0].x,
            end: array[array.length - 1].x
        }
    }

    <% if(f != null) { %>
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
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
</body>
</html>
