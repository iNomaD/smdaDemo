<html>
<head>
    <title>Hello World Window</title>
    <link rel="stylesheet" type="text/css" href="resources/ext-3.4.1/resources/css/ext-all.css"/>
    <script type="text/javascript" src="resources/ext-3.4.1/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="resources/ext-3.4.1/ext-all.js"></script>
</head>

<body>
<script type="text/javascript">

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

                    var page = 'sheet.jsp?patient=' + record.id+'&date=10.01.2014,15.02.2015'+"&consider=hct,limpho_perc,neutrophil_perc"
                    dynamicPanel.src = page
                    //document.getElementById("data_export_iframe").contentDocument.location.reload(true);
                    document.getElementById("data_export_iframe").src = page;
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
//        }, this);

        var search = new Ext.Panel({
            labelWidth: 150,
            height: '5%',
            frame: true,
            title: 'Search Demo Data',
            bodyStyle: 'padding:5px 5px 0',
            width: 500,
            defaults: {width: 230},
            defaultType: 'textfield',
            region: 'north',
            items: [
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
                search, grid, dynamicPanel
            ],
            renderTo: Ext.getBody()
        });
    });


    //    search.renderTo(Ext.getBody()/*'search_form'*/);
    //    grid.renderTo(Ext.getBody()/*'search_results'*/);


</script>
</body>
</html>


