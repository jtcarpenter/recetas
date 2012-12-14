var AutoCompleter = {
  inputs: $('#tags-input'),
  url: '/tags',
  tagsUl: $('<ul/>', {'id': 'tags'}),
  postTagsUl: $('<ul/>', {'id': 'post-tags'}),
  submit: $('#submit'),

  init: function () {

  }
};

$(document).ready(function () {
  AutoCompleter.init();
});

// Write custom auto 
// search /tags?q=***
// put result in text field
// return adds to list 
// new entry return adds to list 
// on submit convert list to comma separated 
// in vew output comma separate as before 