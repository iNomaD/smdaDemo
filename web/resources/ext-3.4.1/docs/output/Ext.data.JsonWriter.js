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
Ext.data.JsonP.Ext_data_JsonWriter({"alternateClassNames":[],"aliases":{},"enum":null,"parentMixins":[],"tagname":"class","subclasses":[],"extends":"Ext.data.DataWriter","uses":[],"html":"<div><pre class=\"hierarchy\"><h4>Hierarchy</h4><div class='subclass first-child'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='docClass'>Ext.data.DataWriter</a><div class='subclass '><strong>Ext.data.JsonWriter</strong></div></div><h4>Files</h4><div class='dependency'><a href='source/JsonWriter.html#Ext-data-JsonWriter' target='_blank'>JsonWriter.js</a></div></pre><div class='doc-contents'><p>DataWriter extension for writing an array or single <a href=\"#!/api/Ext.data.Record\" rel=\"Ext.data.Record\" class=\"docClass\">Ext.data.Record</a> object(s) in preparation for executing a remote CRUD action.</p>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-cfg'>Config options</h3><div class='subsection'><div id='cfg-createRecord' class='member first-child inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='defined-in docClass'>Ext.data.DataWriter</a><br/><a href='source/DataWriter.html#Ext-data-DataWriter-cfg-createRecord' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.DataWriter-cfg-createRecord' class='name not-expandable'>createRecord</a><span> : <a href=\"#!/api/Function\" rel=\"Function\" class=\"docClass\">Function</a></span></div><div class='description'><div class='short'><p>Abstract method that should be implemented in all subclasses\n(e.g.: <a href=\"#!/api/Ext.data.JsonWriter-method-createRecord\" rel=\"Ext.data.JsonWriter-method-createRecord\" class=\"docClass\">JsonWriter.createRecord</a>)</p>\n</div><div class='long'><p>Abstract method that should be implemented in all subclasses\n(e.g.: <a href=\"#!/api/Ext.data.JsonWriter-method-createRecord\" rel=\"Ext.data.JsonWriter-method-createRecord\" class=\"docClass\">JsonWriter.createRecord</a>)</p>\n</div></div></div><div id='cfg-destroyRecord' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='defined-in docClass'>Ext.data.DataWriter</a><br/><a href='source/DataWriter.html#Ext-data-DataWriter-cfg-destroyRecord' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.DataWriter-cfg-destroyRecord' class='name not-expandable'>destroyRecord</a><span> : <a href=\"#!/api/Function\" rel=\"Function\" class=\"docClass\">Function</a></span></div><div class='description'><div class='short'><p>Abstract method that should be implemented in all subclasses\n(e.g.: <a href=\"#!/api/Ext.data.JsonWriter-cfg-destroyRecord\" rel=\"Ext.data.JsonWriter-cfg-destroyRecord\" class=\"docClass\">JsonWriter.destroyRecord</a>)</p>\n</div><div class='long'><p>Abstract method that should be implemented in all subclasses\n(e.g.: <a href=\"#!/api/Ext.data.JsonWriter-cfg-destroyRecord\" rel=\"Ext.data.JsonWriter-cfg-destroyRecord\" class=\"docClass\">JsonWriter.destroyRecord</a>)</p>\n</div></div></div><div id='cfg-encode' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.data.JsonWriter'>Ext.data.JsonWriter</span><br/><a href='source/JsonWriter.html#Ext-data-JsonWriter-cfg-encode' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.JsonWriter-cfg-encode' class='name expandable'>encode</a><span> : Boolean</span></div><div class='description'><div class='short'>true to JSON encode the\nhashed data into a standard HTTP parameter named after this\nReader's meta.root property which...</div><div class='long'><p><tt>true</tt> to <a href=\"#!/api/Ext.util.JSON-method-encode\" rel=\"Ext.util.JSON-method-encode\" class=\"docClass\">JSON encode</a> the\n<a href=\"#!/api/Ext.data.DataWriter-method-toHash\" rel=\"Ext.data.DataWriter-method-toHash\" class=\"docClass\">hashed data</a> into a standard HTTP parameter named after this\nReader's <code>meta.root</code> property which, by default is imported from the associated Reader. Defaults to <tt>true</tt>.</p>\n\n\n<p>If set to <code>false</code>, the hashed data is <a href=\"#!/api/Ext.util.JSON-method-encode\" rel=\"Ext.util.JSON-method-encode\" class=\"docClass\">JSON encoded</a>, along with\nthe associated <a href=\"#!/api/Ext.data.Store\" rel=\"Ext.data.Store\" class=\"docClass\">Ext.data.Store</a>'s <a href=\"#!/api/Ext.data.Store-property-baseParams\" rel=\"Ext.data.Store-property-baseParams\" class=\"docClass\">baseParams</a>, into the POST body.</p>\n\n\n<p>When using <a href=\"#!/api/Ext.data.DirectProxy\" rel=\"Ext.data.DirectProxy\" class=\"docClass\">Ext.data.DirectProxy</a>, set this to <tt>false</tt> since Ext.Direct.JsonProvider will perform\nits own json-encoding.  In addition, if you're using <a href=\"#!/api/Ext.data.HttpProxy\" rel=\"Ext.data.HttpProxy\" class=\"docClass\">Ext.data.HttpProxy</a>, setting to <tt>false</tt>\nwill cause HttpProxy to transmit data using the <b>jsonData</b> configuration-params of <a href=\"#!/api/Ext.Ajax-method-request\" rel=\"Ext.Ajax-method-request\" class=\"docClass\">Ext.Ajax.request</a>\ninstead of <b>params</b>.</p>\n\n\n<p>When using a <a href=\"#!/api/Ext.data.Store-cfg-restful\" rel=\"Ext.data.Store-cfg-restful\" class=\"docClass\">Ext.data.Store.restful</a> Store, some serverside frameworks are\ntuned to expect data through the jsonData mechanism.  In those cases, one will want to set <b>encode: <tt>false</tt></b>, as in\nlet the lower-level connection object (eg: <a href=\"#!/api/Ext.Ajax\" rel=\"Ext.Ajax\" class=\"docClass\">Ext.Ajax</a>) do the encoding.</p>\n\n<p>Defaults to: <code>true</code></p></div></div></div><div id='cfg-encodeDelete' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.data.JsonWriter'>Ext.data.JsonWriter</span><br/><a href='source/JsonWriter.html#Ext-data-JsonWriter-cfg-encodeDelete' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.JsonWriter-cfg-encodeDelete' class='name expandable'>encodeDelete</a><span> : Boolean</span></div><div class='description'><div class='short'>False to send only the id to the server on delete, true to encode it in an object\nliteral, eg:\n\n{id: 1}\n\n\n\n Defaults ...</div><div class='long'><p>False to send only the id to the server on delete, true to encode it in an object\nliteral, eg:</p>\n\n<pre><code>{id: 1}\n</code></pre>\n\n\n<p> Defaults to <tt>false</tt></p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='cfg-listful' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='defined-in docClass'>Ext.data.DataWriter</a><br/><a href='source/DataWriter.html#Ext-data-DataWriter-cfg-listful' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.DataWriter-cfg-listful' class='name expandable'>listful</a><span> : Boolean</span></div><div class='description'><div class='short'>false by default. ...</div><div class='long'><p><tt>false</tt> by default.  Set <tt>true</tt> to have the DataWriter <b>always</b> write HTTP params as a list,\neven when acting upon a single record.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='cfg-updateRecord' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='defined-in docClass'>Ext.data.DataWriter</a><br/><a href='source/DataWriter.html#Ext-data-DataWriter-cfg-updateRecord' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.DataWriter-cfg-updateRecord' class='name not-expandable'>updateRecord</a><span> : <a href=\"#!/api/Function\" rel=\"Function\" class=\"docClass\">Function</a></span></div><div class='description'><div class='short'><p>Abstract method that should be implemented in all subclasses\n(e.g.: <a href=\"#!/api/Ext.data.JsonWriter-cfg-updateRecord\" rel=\"Ext.data.JsonWriter-cfg-updateRecord\" class=\"docClass\">JsonWriter.updateRecord</a></p>\n</div><div class='long'><p>Abstract method that should be implemented in all subclasses\n(e.g.: <a href=\"#!/api/Ext.data.JsonWriter-cfg-updateRecord\" rel=\"Ext.data.JsonWriter-cfg-updateRecord\" class=\"docClass\">JsonWriter.updateRecord</a></p>\n</div></div></div><div id='cfg-writeAllFields' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='defined-in docClass'>Ext.data.DataWriter</a><br/><a href='source/DataWriter.html#Ext-data-DataWriter-cfg-writeAllFields' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.DataWriter-cfg-writeAllFields' class='name expandable'>writeAllFields</a><span> : Boolean</span></div><div class='description'><div class='short'>false by default. ...</div><div class='long'><p><tt>false</tt> by default.  Set <tt>true</tt> to have DataWriter return ALL fields of a modified\nrecord -- not just those that changed.\n<tt>false</tt> to have DataWriter only request modified fields from a record.</p>\n<p>Defaults to: <code>false</code></p></div></div></div></div></div><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-method'>Methods</h3><div class='subsection'><div id='method-constructor' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.data.JsonWriter'>Ext.data.JsonWriter</span><br/><a href='source/JsonWriter.html#Ext-data-JsonWriter-method-constructor' target='_blank' class='view-source'>view source</a></div><strong class='new-keyword'>new</strong><a href='#!/api/Ext.data.JsonWriter-method-constructor' class='name expandable'>Ext.data.JsonWriter</a>( <span class='pre'>meta, recordType</span> ) : <a href=\"#!/api/Ext.data.JsonWriter\" rel=\"Ext.data.JsonWriter\" class=\"docClass\">Ext.data.JsonWriter</a></div><div class='description'><div class='short'>Create a new DataWriter ...</div><div class='long'><p>Create a new DataWriter</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>meta</span> : Object<div class='sub-desc'><p>Metadata configuration options (implementation-specific)</p>\n</div></li><li><span class='pre'>recordType</span> : Object<div class='sub-desc'><p>Either an Array of field definition objects as specified\nin <a href=\"#!/api/Ext.data.Record-static-method-create\" rel=\"Ext.data.Record-static-method-create\" class=\"docClass\">Ext.data.Record.create</a>, or an <a href=\"#!/api/Ext.data.Record\" rel=\"Ext.data.Record\" class=\"docClass\">Ext.data.Record</a> object created\nusing <a href=\"#!/api/Ext.data.Record-static-method-create\" rel=\"Ext.data.Record-static-method-create\" class=\"docClass\">Ext.data.Record.create</a>.</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'><a href=\"#!/api/Ext.data.JsonWriter\" rel=\"Ext.data.JsonWriter\" class=\"docClass\">Ext.data.JsonWriter</a></span><div class='sub-desc'>\n</div></li></ul><p>Overrides: <a href='#!/api/Ext.data.DataWriter-method-constructor' rel='Ext.data.DataWriter-method-constructor' class='docClass'>Ext.data.DataWriter.constructor</a></p></div></div></div><div id='method-apply' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='defined-in docClass'>Ext.data.DataWriter</a><br/><a href='source/DataWriter.html#Ext-data-DataWriter-method-apply' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.DataWriter-method-apply' class='name expandable'>apply</a>( <span class='pre'>params, baseParams, action, rs</span> )</div><div class='description'><div class='short'>Compiles a Store recordset into a data-format defined by an extension such as Ext.data.JsonWriter or Ext.data.XmlWrit...</div><div class='long'><p>Compiles a Store recordset into a data-format defined by an extension such as <a href=\"#!/api/Ext.data.JsonWriter\" rel=\"Ext.data.JsonWriter\" class=\"docClass\">Ext.data.JsonWriter</a> or <a href=\"#!/api/Ext.data.XmlWriter\" rel=\"Ext.data.XmlWriter\" class=\"docClass\">Ext.data.XmlWriter</a> in preparation for a <a href=\"#!/api/Ext.data.Api-property-actions\" rel=\"Ext.data.Api-property-actions\" class=\"docClass\">server-write action</a>.  The first two params are similar similar in nature to <a href=\"#!/api/Ext-method-apply\" rel=\"Ext-method-apply\" class=\"docClass\">Ext.apply</a>,\nWhere the first parameter is the <i>receiver</i> of paramaters and the second, baseParams, <i>the source</i>.</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>params</span> : Object<div class='sub-desc'><p>The request-params receiver.</p>\n</div></li><li><span class='pre'>baseParams</span> : Object<div class='sub-desc'><p>as defined by <a href=\"#!/api/Ext.data.Store-property-baseParams\" rel=\"Ext.data.Store-property-baseParams\" class=\"docClass\">Ext.data.Store.baseParams</a>.  The baseParms must be encoded by the extending class, eg: <a href=\"#!/api/Ext.data.JsonWriter\" rel=\"Ext.data.JsonWriter\" class=\"docClass\">Ext.data.JsonWriter</a>, <a href=\"#!/api/Ext.data.XmlWriter\" rel=\"Ext.data.XmlWriter\" class=\"docClass\">Ext.data.XmlWriter</a>.</p>\n</div></li><li><span class='pre'>action</span> : <a href=\"#!/api/String\" rel=\"String\" class=\"docClass\">String</a><div class='sub-desc'><p>[<a href=\"#!/api/Ext.data.Api-property-actions\" rel=\"Ext.data.Api-property-actions\" class=\"docClass\">create|update|destroy</a>]</p>\n</div></li><li><span class='pre'>rs</span> : Record/Record[]<div class='sub-desc'><p>The recordset to write, the subject(s) of the write action.</p>\n</div></li></ul></div></div></div><div id='method-createRecord' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.data.JsonWriter'>Ext.data.JsonWriter</span><br/><a href='source/JsonWriter.html#Ext-data-JsonWriter-method-createRecord' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.JsonWriter-method-createRecord' class='name expandable'>createRecord</a>( <span class='pre'>rec</span> ) : Object<strong class='protected signature' >protected</strong></div><div class='description'><div class='short'>Implements abstract Ext.data.DataWriter.createRecord ...</div><div class='long'><p>Implements abstract <a href=\"#!/api/Ext.data.DataWriter-cfg-createRecord\" rel=\"Ext.data.DataWriter-cfg-createRecord\" class=\"docClass\">Ext.data.DataWriter.createRecord</a></p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>rec</span> : <a href=\"#!/api/Ext.data.Record\" rel=\"Ext.data.Record\" class=\"docClass\">Ext.data.Record</a><div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-destroyRecord' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.data.JsonWriter'>Ext.data.JsonWriter</span><br/><a href='source/JsonWriter.html#Ext-data-JsonWriter-method-destroyRecord' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.JsonWriter-method-destroyRecord' class='name expandable'>destroyRecord</a>( <span class='pre'>rec</span> ) : Object<strong class='protected signature' >protected</strong></div><div class='description'><div class='short'>Implements abstract Ext.data.DataWriter.destroyRecord ...</div><div class='long'><p>Implements abstract <a href=\"#!/api/Ext.data.DataWriter-cfg-destroyRecord\" rel=\"Ext.data.DataWriter-cfg-destroyRecord\" class=\"docClass\">Ext.data.DataWriter.destroyRecord</a></p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>rec</span> : <a href=\"#!/api/Ext.data.Record\" rel=\"Ext.data.Record\" class=\"docClass\">Ext.data.Record</a><div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-render' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.data.JsonWriter'>Ext.data.JsonWriter</span><br/><a href='source/JsonWriter.html#Ext-data-JsonWriter-method-render' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.JsonWriter-method-render' class='name expandable'>render</a>( <span class='pre'>Ajax, baseParams, data</span> )</div><div class='description'><div class='short'>This method should not need to be called by application code, however it may be useful on occasion to\noverride it, or...</div><div class='long'><p>This method should not need to be called by application code, however it may be useful on occasion to\noverride it, or augment it with an <a href=\"#!/api/Function-method-createInterceptor\" rel=\"Function-method-createInterceptor\" class=\"docClass\">interceptor</a> or <a href=\"#!/api/Function-method-createSequence\" rel=\"Function-method-createSequence\" class=\"docClass\">sequence</a>.</p>\n\n\n<p>The provided implementation encodes the serialized data representing the Store's modified Records into the Ajax request's\n<code>params</code> according to the <code><a href=\"#!/api/Ext.data.JsonWriter-cfg-encode\" rel=\"Ext.data.JsonWriter-cfg-encode\" class=\"docClass\">encode</a></code> setting.</p>\n\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>Ajax</span> : Object<div class='sub-desc'><p>request params object to write into.</p>\n</div></li><li><span class='pre'>baseParams</span> : Object<div class='sub-desc'><p>as defined by <a href=\"#!/api/Ext.data.Store-property-baseParams\" rel=\"Ext.data.Store-property-baseParams\" class=\"docClass\">Ext.data.Store.baseParams</a>.  The baseParms must be encoded by the extending class, eg: <a href=\"#!/api/Ext.data.JsonWriter\" rel=\"Ext.data.JsonWriter\" class=\"docClass\">Ext.data.JsonWriter</a>, <a href=\"#!/api/Ext.data.XmlWriter\" rel=\"Ext.data.XmlWriter\" class=\"docClass\">Ext.data.XmlWriter</a>.</p>\n</div></li><li><span class='pre'>data</span> : Object/Object[]<div class='sub-desc'><p>Data object representing the serialized modified records from the Store. May be either a single object,\nor an Array of objects - user implementations must handle both cases.</p>\n</div></li></ul><p>Overrides: <a href='#!/api/Ext.data.DataWriter-method-render' rel='Ext.data.DataWriter-method-render' class='docClass'>Ext.data.DataWriter.render</a></p></div></div></div><div id='method-toArray' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='defined-in docClass'>Ext.data.DataWriter</a><br/><a href='source/DataWriter.html#Ext-data-DataWriter-method-toArray' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.DataWriter-method-toArray' class='name expandable'>toArray</a>( <span class='pre'>data</span> ) : Object[]<strong class='protected signature' >protected</strong></div><div class='description'><div class='short'>Converts a Hashed Ext.data.Record to fields-array array suitable\nfor encoding to xml via XTemplate, eg:\n\n\n&lt;tpl for...</div><div class='long'><p>Converts a <a href=\"#!/api/Ext.data.DataWriter-method-toHash\" rel=\"Ext.data.DataWriter-method-toHash\" class=\"docClass\">Hashed</a> <a href=\"#!/api/Ext.data.Record\" rel=\"Ext.data.Record\" class=\"docClass\">Ext.data.Record</a> to fields-array array suitable\nfor encoding to xml via XTemplate, eg:\n<code></p>\n\n<pre>&lt;tpl for=\".\">&lt;{name}>{value}&lt;/{name}&lt;/tpl></pre>\n\n\n<p></code>\neg, <b>non-phantom</b>:\n<code></p>\n\n<pre>{id: 1, first: 'foo', last: 'bar'} --> [{name: 'id', value: 1}, {name: 'first', value: 'foo'}, {name: 'last', value: 'bar'}]</pre>\n\n\n<p></code>\n<a href=\"#!/api/Ext.data.Record-property-phantom\" rel=\"Ext.data.Record-property-phantom\" class=\"docClass\">Phantom</a> records will have had their idProperty omitted in <a href=\"#!/api/Ext.data.DataWriter-method-toHash\" rel=\"Ext.data.DataWriter-method-toHash\" class=\"docClass\">toHash</a> if determined to be auto-generated.\nNon AUTOINCREMENT pks should have been protected.</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>data</span> : Hash<div class='sub-desc'><p>Hashed by <a href=\"#!/api/Ext.data.DataWriter-method-toHash\" rel=\"Ext.data.DataWriter-method-toHash\" class=\"docClass\">Ext.data.DataWriter.toHash</a></p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object[]</span><div class='sub-desc'><p>Array of attribute-objects.</p>\n</div></li></ul></div></div></div><div id='method-toHash' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Ext.data.DataWriter' rel='Ext.data.DataWriter' class='defined-in docClass'>Ext.data.DataWriter</a><br/><a href='source/DataWriter.html#Ext-data-DataWriter-method-toHash' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.DataWriter-method-toHash' class='name expandable'>toHash</a>( <span class='pre'>rec, config</span> ) : Object<strong class='protected signature' >protected</strong></div><div class='description'><div class='short'>Converts a Record to a hash, taking into account the state of the Ext.data.Record along with configuration properties...</div><div class='long'><p>Converts a Record to a hash, taking into account the state of the <a href=\"#!/api/Ext.data.Record\" rel=\"Ext.data.Record\" class=\"docClass\">Ext.data.Record</a> along with configuration properties\nrelated to its rendering, such as <a href=\"#!/api/Ext.data.DataWriter-cfg-writeAllFields\" rel=\"Ext.data.DataWriter-cfg-writeAllFields\" class=\"docClass\">writeAllFields</a>, <a href=\"#!/api/Ext.data.Record-property-phantom\" rel=\"Ext.data.Record-property-phantom\" class=\"docClass\">phantom</a>, <a href=\"#!/api/Ext.data.Record-method-getChanges\" rel=\"Ext.data.Record-method-getChanges\" class=\"docClass\">getChanges</a> and\nidProperty</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>rec</span> : <a href=\"#!/api/Ext.data.Record\" rel=\"Ext.data.Record\" class=\"docClass\">Ext.data.Record</a><div class='sub-desc'><p>The Record from which to create a hash.</p>\n</div></li><li><span class='pre'>config</span> : Object<div class='sub-desc'><p><b>NOT YET IMPLEMENTED</b>.  Will implement an exlude/only configuration for fine-control over which fields do/don't get rendered.</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>TODO Implement excludes/only configuration with 2nd param?</p>\n</div></li></ul></div></div></div><div id='method-updateRecord' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.data.JsonWriter'>Ext.data.JsonWriter</span><br/><a href='source/JsonWriter.html#Ext-data-JsonWriter-method-updateRecord' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.data.JsonWriter-method-updateRecord' class='name expandable'>updateRecord</a>( <span class='pre'>rec</span> ) : Object<strong class='protected signature' >protected</strong></div><div class='description'><div class='short'>Implements abstract Ext.data.DataWriter.updateRecord ...</div><div class='long'><p>Implements abstract <a href=\"#!/api/Ext.data.DataWriter-cfg-updateRecord\" rel=\"Ext.data.DataWriter-cfg-updateRecord\" class=\"docClass\">Ext.data.DataWriter.updateRecord</a></p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>rec</span> : <a href=\"#!/api/Ext.data.Record\" rel=\"Ext.data.Record\" class=\"docClass\">Ext.data.Record</a><div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'>\n</div></li></ul></div></div></div></div></div></div></div>","superclasses":["Ext.data.DataWriter"],"meta":{},"requires":[],"html_meta":{},"statics":{"property":[],"cfg":[],"css_var":[],"method":[],"event":[],"css_mixin":[]},"files":[{"href":"JsonWriter.html#Ext-data-JsonWriter","filename":"JsonWriter.js"}],"linenr":1,"members":{"property":[],"cfg":[{"tagname":"cfg","owner":"Ext.data.DataWriter","meta":{},"name":"createRecord","id":"cfg-createRecord"},{"tagname":"cfg","owner":"Ext.data.DataWriter","meta":{},"name":"destroyRecord","id":"cfg-destroyRecord"},{"tagname":"cfg","owner":"Ext.data.JsonWriter","meta":{},"name":"encode","id":"cfg-encode"},{"tagname":"cfg","owner":"Ext.data.JsonWriter","meta":{},"name":"encodeDelete","id":"cfg-encodeDelete"},{"tagname":"cfg","owner":"Ext.data.DataWriter","meta":{},"name":"listful","id":"cfg-listful"},{"tagname":"cfg","owner":"Ext.data.DataWriter","meta":{},"name":"updateRecord","id":"cfg-updateRecord"},{"tagname":"cfg","owner":"Ext.data.DataWriter","meta":{},"name":"writeAllFields","id":"cfg-writeAllFields"}],"css_var":[],"method":[{"tagname":"method","owner":"Ext.data.JsonWriter","meta":{},"name":"constructor","id":"method-constructor"},{"tagname":"method","owner":"Ext.data.DataWriter","meta":{},"name":"apply","id":"method-apply"},{"tagname":"method","owner":"Ext.data.JsonWriter","meta":{"protected":true},"name":"createRecord","id":"method-createRecord"},{"tagname":"method","owner":"Ext.data.JsonWriter","meta":{"protected":true},"name":"destroyRecord","id":"method-destroyRecord"},{"tagname":"method","owner":"Ext.data.JsonWriter","meta":{},"name":"render","id":"method-render"},{"tagname":"method","owner":"Ext.data.DataWriter","meta":{"protected":true},"name":"toArray","id":"method-toArray"},{"tagname":"method","owner":"Ext.data.DataWriter","meta":{"protected":true},"name":"toHash","id":"method-toHash"},{"tagname":"method","owner":"Ext.data.JsonWriter","meta":{"protected":true},"name":"updateRecord","id":"method-updateRecord"}],"event":[],"css_mixin":[]},"inheritable":null,"private":null,"component":false,"name":"Ext.data.JsonWriter","singleton":false,"override":null,"inheritdoc":null,"id":"class-Ext.data.JsonWriter","mixins":[],"mixedInto":[]});