<%@ page import="smda.models.Analysis" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Система семантического анализа медицинских данных</title>
    <link rel="stylesheet" type="text/css" href="resources/ext-3.4.1/resources/css/ext-all.css"/>
    <link rel="stylesheet" type="text/css" href="resources/ext-3.4.1/resources/css/xtheme-gray.css"/>
    <script type="text/javascript" src="resources/ext-3.4.1/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="resources/ext-3.4.1/ext-all.js"></script>
    <link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<script type="text/javascript">
    parameter_date = ''
    parameter_consider = ''
    parameter_record = '10009/A14'

    function loadPage(dynamicPanel) {
        var page = 'sheet.jsp?patient=' + parameter_record

        if (parameter_date != '') {
            page += '&date=' + parameter_date
        }
        if (parameter_consider != '') {
            page += '&consider=' + parameter_consider
        }
        dynamicPanel.src = page;
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
            fields: ['id', 'sex', 'age', 'diagnosis', 'name'],
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
                {id: 'id', header: "Рег.номер", dataIndex: 'id'},
                {id: 'sex', header: "Пол", dataIndex: 'sex'},
                {id: 'age', header: "Возраст", dataIndex: 'age'},
                {id: 'diagnosis', header: "Диагноз", dataIndex: 'diagnosis'},
                {id: 'name', header: "Ф.И.О.", dataIndex: 'name'}
            ],
            stripeRows: true,
            autoExpandColumn: 'name',
            height: 350,
            width: 500,
            title: 'Список пациентов, удовлетворяющих запросу',
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
            frame: true,
            title: 'Поиск по пациентам',
            bodyStyle: 'padding:5px 5px 0',
            width: 210,
            defaults: {width: 190},
            defaultType: 'textfield',
            layout: {
                type: 'vbox',
                align: 'middle'
            },
            items: [
                {
                    xtype: 'displayfield',
                    value: 'Для шаблонов используйте символы "%" и "_", "_" - любой символ, "%" - последовательность любых символов'
                },
                {
                    xtype: 'displayfield',
                    value: 'Введите регулярное выражение:',
                },
                {
                    emptyText: '%',
                    value: '%',
                    name: 'pattern',
                    id: 'pattern'
                }

            ],
            buttons: [
                {
                    text: 'Искать',
                    handler: function () {
                        dstore.load({
                            params: {
                                pattern: document.getElementById('pattern').value
                            }
                        });

                    }
                }
            ]
            // renderTo: Ext.getBody()
        });

        var filter_date = new Ext.Panel({
            labelWidth: 150,
            frame: true,
            title: 'Фильтрация по датам',
            bodyStyle: 'padding:5px 5px 0',
            width: 170,
            defaults: {width: 150},
            defaultType: 'textfield',
            layout: {
                type: 'vbox',
                align: 'middle'
            },
            items: [
                {
                    xtype: 'displayfield',
                    value: 'Дата начала периода'
                },
                {
                    fieldLabel: 'Начало',
                    name: 'date1',
                    id: 'date1',
                    emptyText: '01.01.2014'
                },
                {
                    xtype: 'displayfield',
                    value: 'Дата окончания периода'
                },
                {
                    fieldLabel: 'Окончание',
                    name: 'date2',
                    id: 'date2',
                    emptyText: '31.12.2014'
                }

            ],
            buttons: [
                {
                    text: 'Применить фильтр',
                    handler: function () {
                        parameter_date = document.getElementById('date1').value + ',' + document.getElementById('date2').value
                        loadPage(dynamicPanel)
                    }
                }
            ]
            // renderTo: Ext.getBody()
        });

        var filter_par = new Ext.Panel({
            labelWidth: 150,
            frame: true,
            title: 'Список параментров для отображения и расчета функционала',
            bodyStyle: 'padding:5px 5px 0',
            //width: 600,
            flex: 1,
            items: [
                {
                    id: 'myGroup',
                    xtype: 'checkboxgroup',
                    fieldLabel: 'Single Column',
                    itemCls: 'x-check-group-alt',
                    //width: '100%',
                    columns: 6,
                    items: [
                        <% for(Analysis.Parameter p : Analysis.Parameter.values()){%>
                        {boxLabel: '<%=Analysis.getName(p)%>', id: 'cb_col_<%=p.name()%>', checked: true},
                        <% } %>
                    ]
                }
            ],
            buttons: [
                {
                    text: 'Применить фильтр',
                    handler: function () {
                        parameter_consider = ''
                        <% for(Analysis.Parameter p : Analysis.Parameter.values()){%>
                        var checked = Ext.getCmp('cb_col_<%=p.name()%>').checked
                        if (checked) {
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
                src: ''
            },
            //height: '95%',
            flex: 1,
            id: 'data_export_iframe',
            width: 600,
            region: 'center'
        });

        var panel_botkin = new Ext.Panel({
            width: '100%',
            height: '100%',
            padding: 10,
            layout: 'border',
            items: [
                new Ext.Panel({
                    xtype: 'container',
                    height: 170,
                    layout: {
                        type: 'hbox',
                        align: 'stretch'
                    },
                    region: 'north',
                    items: [search, filter_date, filter_par]
                }),
                grid,
                dynamicPanel
            ],

        });

        var tabs = new Ext.TabPanel({
            defaults: {
                layout: 'fit'
            },
            region: 'center',
            activeTab: 0,
            items: [{
                title: 'Боткинский лист',
                items: [
                    panel_botkin
                ]
            }, {
                title: 'Функции уравляющего персонала',
                html: 'В настоящий момент вкладка находится в стадии разработки. Приносим извинения за доставленные неудобства.'
            }]
        });

        var header = new Ext.Panel( {
            region: 'north',
            height: '80px',
            html: '<div style="height: 80px; background-color: #DDDDDD;"><img src="resources/img/almazov.png" height="70px" align="left">' +
            '<p>&nbsp;</p><p align="center" class="header">Система семантического анализа медицинских данных для Центра им. Алмазова</p></div>'
        });

        var panel = new Ext.Viewport({
            width: '100%',
            height: '100%',
            padding: 10,
            layout: 'border',
            items:[
                    header, tabs
            ],
            renderTo: Ext.getBody()
        });

        loadPage(dynamicPanel)
    });


    //    search.renderTo(Ext.getBody()/*'search_form'*/);
    //    grid.renderTo(Ext.getBody()/*'search_results'*/);


</script>
</body>
</html>


