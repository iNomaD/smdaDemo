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
Ext.data.JsonP.Ext_Loader({"alternateClassNames":[],"aliases":{},"enum":null,"parentMixins":[],"tagname":"class","subclasses":[],"extends":null,"uses":[],"html":"<div><pre class=\"hierarchy\"><h4>Files</h4><div class='dependency'><a href='source/Loader.html#Ext-Loader' target='_blank'>Loader.js</a></div></pre><div class='doc-contents'><p>Simple class to help load JavaScript files on demand</p>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-method'>Methods</h3><div class='subsection'><div id='method-buildScriptTag' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.Loader'>Ext.Loader</span><br/><a href='source/Loader.html#Ext-Loader-method-buildScriptTag' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.Loader-method-buildScriptTag' class='name expandable'>buildScriptTag</a>( <span class='pre'>filename, callback</span> ) : Element<strong class='private signature' >private</strong></div><div class='description'><div class='short'>Creates and returns a script tag, but does not place it into the document. ...</div><div class='long'><p>Creates and returns a script tag, but does not place it into the document. If a callback function\nis passed, this is called when the script has been loaded</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>filename</span> : <a href=\"#!/api/String\" rel=\"String\" class=\"docClass\">String</a><div class='sub-desc'><p>The name of the file to create a script tag for</p>\n</div></li><li><span class='pre'>callback</span> : <a href=\"#!/api/Function\" rel=\"Function\" class=\"docClass\">Function</a><div class='sub-desc'><p>Optional callback, which is called when the script has been loaded</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Element</span><div class='sub-desc'><p>The new script ta</p>\n</div></li></ul></div></div></div><div id='method-load' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.Loader'>Ext.Loader</span><br/><a href='source/Loader.html#Ext-Loader-method-load' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.Loader-method-load' class='name expandable'>load</a>( <span class='pre'>fileList, callback, scope, preserveOrder</span> )</div><div class='description'><div class='short'>Loads a given set of .js files. ...</div><div class='long'><p>Loads a given set of .js files. Calls the callback function when all files have been loaded\nSet preserveOrder to true to ensure non-parallel loading of files if load order is important</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>fileList</span> : <a href=\"#!/api/Array\" rel=\"Array\" class=\"docClass\">Array</a><div class='sub-desc'><p>Array of all files to load</p>\n</div></li><li><span class='pre'>callback</span> : <a href=\"#!/api/Function\" rel=\"Function\" class=\"docClass\">Function</a><div class='sub-desc'><p>Callback to call after all files have been loaded</p>\n</div></li><li><span class='pre'>scope</span> : Object<div class='sub-desc'><p>The scope to call the callback in</p>\n</div></li><li><span class='pre'>preserveOrder</span> : Boolean<div class='sub-desc'><p>True to make files load in serial, one after the other (defaults to false)</p>\n</div></li></ul></div></div></div><div id='method-loadFileIndex' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.Loader'>Ext.Loader</span><br/><a href='source/Loader.html#Ext-Loader-method-loadFileIndex' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.Loader-method-loadFileIndex' class='name expandable'>loadFileIndex</a>( <span class='pre'>index</span> )</div><div class='description'><div class='short'>Loads a particular file from the fileList by index. ...</div><div class='long'><p>Loads a particular file from the fileList by index. This is used when preserving order</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>index</span> : Object<div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-onFileLoaded' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Ext.Loader'>Ext.Loader</span><br/><a href='source/Loader.html#Ext-Loader-method-onFileLoaded' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Ext.Loader-method-onFileLoaded' class='name expandable'>onFileLoaded</a>( <span class='pre'></span> )</div><div class='description'><div class='short'>Callback function which is called after each file has been loaded. ...</div><div class='long'><p>Callback function which is called after each file has been loaded. This calls the callback\npassed to load once the final file in the fileList has been loaded</p>\n</div></div></div></div></div></div></div>","superclasses":[],"meta":{},"requires":[],"html_meta":{},"statics":{"property":[],"cfg":[],"css_var":[],"method":[],"event":[],"css_mixin":[]},"files":[{"href":"Loader.html#Ext-Loader","filename":"Loader.js"}],"linenr":1,"members":{"property":[],"cfg":[],"css_var":[],"method":[{"tagname":"method","owner":"Ext.Loader","meta":{"private":true},"name":"buildScriptTag","id":"method-buildScriptTag"},{"tagname":"method","owner":"Ext.Loader","meta":{},"name":"load","id":"method-load"},{"tagname":"method","owner":"Ext.Loader","meta":{},"name":"loadFileIndex","id":"method-loadFileIndex"},{"tagname":"method","owner":"Ext.Loader","meta":{},"name":"onFileLoaded","id":"method-onFileLoaded"}],"event":[],"css_mixin":[]},"inheritable":null,"private":null,"component":false,"name":"Ext.Loader","singleton":true,"override":null,"inheritdoc":null,"id":"class-Ext.Loader","mixins":[],"mixedInto":[]});