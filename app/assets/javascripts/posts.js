$(document).ready(function () {
  $('#token-input').tokenInput('/tags.json', {
    theme : 'facebook',
    crossDomain: false,
    prePopulate: $("#tag_list").data("pre"),
    preventDuplicates: true
  });
});