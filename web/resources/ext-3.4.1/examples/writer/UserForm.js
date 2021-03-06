/*
This file is part of Ext JS 3.4

Copyright (c) 2011-2013 Sencha Inc

Contact:  http://www.sencha.com/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 3.0 as
published by the Free Software Foundation and appearing in the file LICENSE included in the
packaging of this file.

Please review the following information to ensure the GNU General Public License version 3.0
requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department
at http://www.sencha.com/contact.

Build date: 2013-04-03 15:07:25
*/
Ext.ns('App', 'App.user');
/**
 * @class App.user.FormPanel
 * A typical FormPanel extension
 */
App.user.Form = Ext.extend(Ext.form.FormPanel, {
    renderTo: 'user-form',
    iconCls: 'silk-user',
    frame: true,
    labelAlign: 'right',
    title: 'User -- All fields are required',
    frame: true,
    width: 500,
    defaultType: 'textfield',
    defaults: {
        anchor: '100%'
    },

    // private A pointer to the currently loaded record
    record : null,

    /**
     * initComponent
     * @protected
     */
    initComponent : function() {
        // build the form-fields.  Always a good idea to defer form-building to a method so that this class can
        // be over-ridden to provide different form-fields
        this.items = this.buildForm();

        // build form-buttons
        this.buttons = this.buildUI();

        // add a create event for convenience in our application-code.
        this.addEvents({
            /**
             * @event create
             * Fires when user clicks [create] button
             * @param {FormPanel} this
             * @param {Object} values, the Form's values object
             */
            create : true
        });

        // super
        App.user.Form.superclass.initComponent.call(this);
    },

    /**
     * buildform
     * @private
     */
    buildForm : function() {
        return [
            {fieldLabel: 'Email', name: 'email', allowBlank: false, vtype: 'email'},
            {fieldLabel: 'First', name: 'first', allowBlank: false},
            {fieldLabel: 'Last', name: 'last', allowBlank: false}
        ];
    },

    /**
     * buildUI
     * @private
     */
    buildUI: function(){
        return [{
            text: 'Save',
            iconCls: 'icon-save',
            handler: this.onUpdate,
            scope: this
        }, {
            text: 'Create',
            iconCls: 'silk-user-add',
            handler: this.onCreate,
            scope: this
        }, {
            text: 'Reset',
            handler: function(btn, ev){
                this.getForm().reset();
            },
            scope: this
        }];
    },

    /**
     * loadRecord
     * @param {Record} rec
     */
    loadRecord : function(rec) {
        this.record = rec;
        this.getForm().loadRecord(rec);
    },

    /**
     * onUpdate
     */
    onUpdate : function(btn, ev) {
        if (this.record == null) {
            return;
        }
        if (!this.getForm().isValid()) {
            App.setAlert(false, "Form is invalid.");
            return false;
        }
        this.getForm().updateRecord(this.record);
    },

    /**
     * onCreate
     */
    onCreate : function(btn, ev) {
        if (!this.getForm().isValid()) {
            App.setAlert(false, "Form is invalid");
            return false;
        }
        this.fireEvent('create', this, this.getForm().getValues());
        this.getForm().reset();
    },

    /**
     * onReset
     */
    onReset : function(btn, ev) {
        this.fireEvent('update', this, this.getForm().getValues());
        this.getForm().reset();
    }
});
