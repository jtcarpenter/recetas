console.log('test');
var AutoCom = {
  input: {},
  label: {},
  searchURL: '/tags',
  tagsUl: {},
  postTagsUl: {},
  form: {},
  deleteBtn: '<span class="delete">x</span>',

  initDOM: function (form) {
    AutoCom.input = $('#post_tag_list');
    AutoCom.label = $('#tags-label');
    AutoCom.tagsUl = $('<ul/>', {'id': 'tags'});
    AutoCom.postTagsUl = $('<ul/>', {'id': 'post-tags'});
    AutoCom.form = $(form);

    AutoCom.label.text(AutoCom.removeParenthesised(AutoCom.label.text()));

    AutoCom.tagsUl.insertAfter(AutoCom.input);
    AutoCom.postTagsUl.insertBefore(AutoCom.input);

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
      var tag = AutoCom.removeDeleteBtn(li);
      if (tag === '') return false;
      tagStr += tag;
      if (i !== (length - 1)) tagStr += ', ';
    });
    return tagStr;
  },

  removeParenthesised: function (text) {
    return text.replace(/\s*\([^\)]+\)\s*/, '');
  },

  removeDeleteBtn: function (li) {
    var str = '\\s*' + $(AutoCom.deleteBtn).text() + '\\s*',
        RE = new RegExp(str, 'i');
    return $(li).text().replace(RE, '');
  },

  tagExists: function(tag, ul) {
    var exists = false;
    ul.children().each(function (i, li) {
      if (AutoCom.removeDeleteBtn(li) === tag) exists = true ;
    });
    return exists;
  },

  objectsToList: function (objects) {
    var listItems = [],
        li = {};
    $(objects).each(function (i, object) {
      li = $('<li/>').text( $.trim(object.name) );
      var tag = $(li).text();
      if (AutoCom.tagExists(tag, AutoCom.postTagsUl)) {
        return;
      }
      li.click(function (event) {
        AutoCom.addTagToList(tag, AutoCom.postTagsUl);
        $(this).remove();
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
    if (tag === '') return;
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
          AutoCom.input.val('');
          if (!AutoCom.tagExists(tag, AutoCom.postTagsUl)) {
            AutoCom.addTagToList(tag, AutoCom.postTagsUl);
          }
        }
        AutoCom.searchTags(tag);
      }
    });
  }
};

$(document).ready(function () {
  "use strict"
  var form = $('.edit_post, .new_post')[0];
  if (form !== undefined) AutoCom.init(form);
});