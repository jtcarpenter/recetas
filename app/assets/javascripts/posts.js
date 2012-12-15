var AutoCom = {
  input: {},
  label: {},
  searchURL: '/tags',
  tagsUl: {},
  postTagsUl: {},
  form: {},
  deleteBtn: '<span class="delete">x</span>',

  initDOM: function (form) {
    AutoCom.input = $('#tags-input');
    AutoCom.label = $('#tags-label');
    AutoCom.tagsUl = $('<ul/>', {'id': 'tags'});
    AutoCom.postTagsUl = $('<ul/>', {'id': 'post-tags'});
    AutoCom.form = $(form);
    //AutoCom.deleteBtn = $('<span/>', {'class': 'delete'}).text('x');

    AutoCom.label.text(AutoCom.removeParenthesised(AutoCom.label.text()));

    AutoCom.tagsUl.insertAfter(AutoCom.input);
    AutoCom.postTagsUl.insertBefore(AutoCom.label);

    AutoCom.postTagsUl.append(AutoCom.CSVToList(AutoCom.input.val(), true));
    AutoCom.input.val('');
  },

  CSVToList: function (csv, deletable) {
    var tags = csv.split(','),
        listItems = [],
        li = {},
        del = {};

    $(tags).each(function (i, tag) {
      tag = $.trim(tag);
      li = $('<li/>').text( tag );
      if (deletable) {
        del = $(AutoCom.deleteBtn).click(AutoCom.deleteTag);
        li.append(del);
      }
      if (tag !== '') listItems.push(li);
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
    var listItems = [],
        li = {};
    $(objects).each(function (i, object) {
      li = $('<li/>').text( $.trim(object.name) );
      li.click(function (event) {
        AutoCom.addTagToList($(this).text(), AutoCom.postTagsUl);
      });
      listItems.push( li );
    });
    return listItems;
  },

  searchTags: function (q) {
    $(AutoCom.tagsUl).children().remove();
    $.getJSON(AutoCom.searchURL + '?q=' + q, function (data, textStatus, jqXHR) {
      $(AutoCom.tagsUl).append(AutoCom.objectsToList(data));
    });
  },

  submitForm: function () {
    var list = AutoCom.postTagsUl.children();
    AutoCom.input.val(AutoCom.listToCSV(list));
  },

  addTagToList: function (tag, ul) {
    var li = $('<li/>').text(tag);
    var del = $(AutoCom.deleteBtn).click(AutoCom.deleteTag);
    li.append(del);
    ul.append(li);
  },

  deleteTag: function (event) {
    $(this).parent().remove();
  },

  init: function (form) {
    AutoCom.initDOM(form);
    AutoCom.form.submit(AutoCom.submitForm);
    AutoCom.input.bind({
      keydown: function(event){
        if (event.keyCode === 9 || event.keyCode === 16 || event.keyCode === 27) {
          return;
        }
        var tag = AutoCom.input.val();
        if (event.keyCode === 13) {
          event.preventDefault();
          AutoCom.addTagToList(tag, AutoCom.postTagsUl);
        }
        AutoCom.searchTags(tag);
      }
    });
    //on key press do search
    //return search to another list
    //attach ul
    //on choose from serached tags add lo list
  }
};

$(document).ready(function () {
  "use strict"
  var form = $('.edit_post')[0];
  if (form !== undefined) AutoCom.init(form);
});