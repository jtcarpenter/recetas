/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
(function(){function e(e,t,n){var r=e.join(" ");r=r.replace(/(,|>|\+|~)/g," "),r=r.replace(/\[[^\]]*/g,""),r=r.replace(/#[^\s]*/g,""),r=r.replace(/\:{1,2}[^\s]*/g,""),r=r.replace(/\s+/g," ");var i=r.split(" "),s=[];for(var o=0;o<i.length;o++){var u=i[o];n.test(u)&&!t.test(u)&&CKEDITOR.tools.indexOf(s,u)==-1&&s.push(u)}return s}function t(t,n,r){var i=[],s=[],o;for(o=0;o<t.styleSheets.length;o++){var u=t.styleSheets[o],f=u.ownerNode||u.owningElement;if(f.getAttribute("data-cke-temp"))continue;if(u.href&&u.href.substr(0,9)=="chrome://")continue;var l=u.cssRules||u.rules;for(var c=0;c<l.length;c++)s.push(l[c].selectorText)}var h=e(s,n,r);for(o=0;o<h.length;o++){var p=h[o].split("."),d=p[0].toLowerCase(),v=p[1];i.push({name:d+"."+v,element:d,attributes:{"class":v}})}return i}CKEDITOR.plugins.add("stylesheetparser",{requires:["styles"],onLoad:function(){var e=CKEDITOR.editor.prototype;e.getStylesSet=CKEDITOR.tools.override(e.getStylesSet,function(e){return function(n){var r=this;e.call(this,function(e){var i=r.config.stylesheetParser_skipSelectors||/(^body\.|^\.)/i,s=r.config.stylesheetParser_validSelectors||/\w+\.\w+/;n(r._.stylesDefinitions=e.concat(t(r.document.$,i,s)))})}})}})})();