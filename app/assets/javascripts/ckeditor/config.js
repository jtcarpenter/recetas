CKEDITOR.editorConfig = function( config )
{
  lang = $('html').attr('lang');

  config.toolbar = 'MyToolbar';
  config.defaultLanguage = lang;
  config.height = 500;
  config.format_tags = 'p;h1;h2;h3;h4;h5;h6';
  config.forcePasteAsPlainText = true;

  config.toolbar_MyToolbar =
  [
    { name: 'document', items : [ 'Maximize', '-', 'NewPage','Preview' ] },
    { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteFromWord','-','Undo','Redo' ] },
    { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','Scayt', '-', 'SpecialChar' ] },
    { name: 'styles', items : [ 'Format', 'Bold','Italic','Strike','-','RemoveFormat' ] },
    { name: 'types', items : [ 'NumberedList','BulletedList', '-', 'Link', 'Unlink' ] }
  ];
};