<%@ page import="smda.models.Analysis" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello World Window</title>
    <link rel="stylesheet" type="text/css" href="resources/ext-3.4.1/resources/css/ext-all.css"/>
    <script type="text/javascript" src="resources/ext-3.4.1/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="resources/ext-3.4.1/ext-all.js"></script>
</head>

<body>
<script type="text/javascript">
    parameter_date = ''
    parameter_consider = ''
    parameter_record = ''

    function loadPage(dynamicPanel){
        var page = 'sheet.jsp?patient=' + parameter_record

        if (parameter_date != '') {
            page += '&date=' + parameter_date
        }
        if (parameter_consider != ''){
            page += '&consider=' + parameter_consider
        }
        dynamicPanel.src = page
        //document.getElementById("data_export_iframe").contentDocument.location.reload(true);
        document.getElementById("data_export_iframe").src = page;
    }

    Ext.onReady(function () {
        Ext.QuickTips.init();

        Ext.override(Ext.form.Field, {
            onKeyUp: function (e) {
                this.fireEvent('keyup', this, e);
            }
        });

        var proxy = new Ext.data.HttpProxy({
            url: 'get_patients',
            method: 'post'
        });

        var dstore = new Ext.data.JsonStore({
            //url: 'hello_example',
            proxy: proxy,
            fields: [ 'id', 'sex', 'age', 'diagnosis', 'name' ],
            totalProperty: 'totalCount'
            //root: 'patients'
        });

        dstore.load();

        console.trace(dstore.data);

        var grid = new Ext.grid.GridPanel({
            store: dstore,
//        columns: [
//            {id:'id', header: "Id", width: 60,  sortable: true, dataIndex: 'id'},
//            {id: 'data', header: "Data", width: 200, sortable: true, dataIndex: 'data'}
//        ],
//            listeners: {
//                select: function(selModel, record, index, eOpts) {
//                    console.debug(record.get('user'));
//                }
//            },
            listeners: {
                cellclick: function (grid, rowIndex, colIndex, e) {
                    var record = grid.getStore().getAt(rowIndex);
                    console.log(record.id);
                    parameter_record = record.id
                    loadPage(dynamicPanel)
                }
            },
            multiSelect: false,
            columns: [
                {id: 'id', header: "Id", dataIndex: 'id'},
                {id: 'sex', header: "Sex", dataIndex: 'sex'},
                {id: 'age', header: "Age", dataIndex: 'age'},
                {id: 'diagnosis', header: "Diagnosis", dataIndex: 'diagnosis'},
                {id: 'name', header: "Name", dataIndex: 'name'}
            ],
            stripeRows: true,
            autoExpandColumn: 'name',
            height: 350,
            width: 500,
            title: 'Demo Data',
            region: 'west'
//            collapsible: true,
//            collapsed: false
            //renderTo: Ext.getBody()
        });

//        grid.on('rowclick', function(grid, rowIndex, columnIndex, e) {
//            var selected = grid.getSelectedRowIndexes();
//            var rows = grid.getDataModel().getRows(selected);
//            console.log(rows[0][0]);

        var search = new Ext.Panel({
            labelWidth: 150,
            height: '5%',
            frame: true,
            title: 'Search Demo Data',
            bodyStyle: 'padding:5px 5px 0',
            width: 400,
            defaults: {width: 230},
            defaultType: 'textfield',
            region: 'north',
            layout: {
                type: 'hbox',
                align: 'left'
            },
            items: [
                {
                    xtype: 'label',
                    text: 'Search regular expression:',
                    margins: '0 0 0 0'
                },
                {
                    fieldLabel: 'Search regular expression',
                    name: 'pattern',
                    id: 'pattern'
                }

            ],
            buttons: [
                {
                    text: 'Search',
                    handler: function () {
                        dstore.load({
                            params: {
                                pattern: document.getElementById('pattern').value
                            }});

                    }
                }
            ]
            // renderTo: Ext.getBody()
        });

        var filter_date = new Ext.Panel({
            labelWidth: 150,
            height: '5%',
            frame: true,
            title: 'Date restriction',
            bodyStyle: 'padding:5px 5px 0',
            width: 400,
            defaults: {width: 100},
            defaultType: 'textfield',
            region: 'north',
            layout: {
                type: 'hbox',
                align: 'left'
            },
            items: [
                {
                    xtype: 'label',
                    text: 'Date restriction:',
                    margins: '0 0 0 0'
                },
                {
                    fieldLabel: 'date1',
                    name: 'date1',
                    id: 'date1'
                },
                {
                    fieldLabel: 'date2',
                    name: 'date2',
                    id: 'date2'
                }

            ],
            buttons: [
                {
                    text: 'Apply',
                    handler: function () {
                        parameter_date = document.getElementById('date1').value+','+document.getElementById('date2').value
                    }
                }
            ]
            // renderTo: Ext.getBody()
        });

        var filter_par = new Ext.Panel({
            labelWidth: 150,
            height: '5%',
            frame: true,
            title: 'Parameters to show',
            bodyStyle: 'padding:5px 5px 0',
            width: 900,
            defaults: {width: 230},
            defaultType: 'textfield',
            region: 'north',
            layout: {
                type: 'hbox',
                align: 'left'
            },
            items: [
                {
                    id:'myGroup',
                    xtype: 'checkboxgroup',
                    fieldLabel: 'Single Column',
                    itemCls: 'x-check-group-alt',
                    width: '100%',
                    // Put all controls in a single column with width 100%
                    columns: 5,
                    items: [
                        <% for(Analysis.Parameter p : Analysis.Parameter.values()){%>
                        {boxLabel: '<%=Analysis.getName(p)%>', id: 'cb_col_<%=p.name()%>', checked: true},
                        <% } %>
                    ]
                }
            ],
            buttons: [
                {
                    text: 'Apply',
                    handler: function () {
                        parameter_consider = ''
                        <% for(Analysis.Parameter p : Analysis.Parameter.values()){%>
                            var checked = Ext.getCmp('cb_col_<%=p.name()%>').checked
                            if(checked){
                                parameter_consider += '<%=p.name()%>,'
                            }
                        <% } %>
                        loadPage(dynamicPanel)
                    }
                }
            ]
            // renderTo: Ext.getBody()
        });

        var sheet = new Ext.Panel({
            region: 'center',
            loader: {
                url: '/',
                autoLoad: true,
                scripts: true
            }
        });

        var dynamicPanel = new Ext.Panel({
            autoEl: {
                autoload: true,
                tag: 'iframe',
                height: '95%',
                src: 'sheet.jsp?patient=10009/A14'
            },
            height: '95%',
            flex: 1,
            id: 'data_export_iframe',
            width: 600,
            region: 'center'
        });

        var panel = new Ext.Viewport({
            width: '100%',
            height: '100%',
            padding: 10,
            layout: 'border',
            items: [
                new Ext.Panel({
                    xtype: 'container',
                    height: 300,
                    layout: {
                        type: 'hbox',
                        align: 'left'
                    },
                    region: 'north',
                    items: [search, filter_date, filter_par]
                }),
                grid,
                dynamicPanel
            ],
            renderTo: Ext.getBody()
        });
    });


    //    search.renderTo(Ext.getBody()/*'search_form'*/);
    //    grid.renderTo(Ext.getBody()/*'search_results'*/);


</script>
</body>
</html>


