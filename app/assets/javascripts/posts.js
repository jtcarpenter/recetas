var AutoCom = {
  input: {},
  label: {},
  searchURL: '/tags',
  tagsUl: {},
  postTagsUl: {},
  form: {},

  initDOM: function (form) {
    AutoCom.input = $('#tags-input');
    AutoCom.label = $('#tags-label');
    AutoCom.tagsUl = $('<ul/>', {'id': 'tags'});
    AutoCom.postTagsUl = $('<ul/>', {'id': 'post-tags'});
    AutoCom.form = $(form);

    AutoCom.label.text(AutoCom.removeParenthesised(AutoCom.label.text()));

    AutoCom.tagsUl.insertBefore(AutoCom.label);
    AutoCom.postTagsUl.insertAfter(AutoCom.input);

    AutoCom.postTagsUl.append(AutoCom.CSVToList(AutoCom.input.val()));
    AutoCom.input.val('');
  },

  CSVToList: function (csv) {
    var tags = csv.split(','),
        listItems = [];
    $(tags).each(function (i, tag) {
      tag = $.trim(tag);
      if (tag !== '') listItems.push( $('<li/>').text( tag ) );
    });
    return listItems;
  },

  listToCSV: function (list) {
    var tagStr = '',
        length = list.length;
    $(list).each(function (i, li) {
      if ($(li).text() === '') return false;
      tagStr += $(li).text();
      if (i !== (length - 1)) tagStr += ', ';
    });
    return tagStr;
  },

  removeParenthesised: function (text) {
    return text.replace(/\s*\([^\)]+\)\s*/, '');
  },

  objectsToList: function (objects) {
    var listItems = [];
    $(objects).each(function (i, object) {
      listItems.push( $('<li/>').text( $.trim(object.name) ) );
    });
    return listItems;
  },

  searchTags: function (q) {
    $.getJSON(AutoCom.searchURL, q, function (data, textStatus, jqXHR) {
      $(AutoCom.tagsUl).append(AutoCom.objectsToList(data));
    });
  },

  submitForm: function () {
    var list = AutoCom.postTagsUl.children();
    AutoCom.input.val(AutoCom.listToCSV(list));
  },

  init: function (form) {
    AutoCom.initDOM(form);
    AutoCom.form.submit(AutoCom.submitForm);

    //attach event for input key presses
    //on key press do search
    //return search to another list
    //attach ul
    //on choose li add to post tags list
  }
};

$(document).ready(function () {
  "use strict"
  var form = $('.edit_post')[0];
  if (form !== undefined) AutoCom.init(form);
});