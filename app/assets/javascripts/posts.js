$(document).ready(function () {
  $('#token-input').tokenInput('/tags', {
    theme: 'facebook',
    crossDomain: false,
    prePopulate: $("#tag_list").data("pre"),
    preventDuplicates: true,
    allowCustomEntry: true,
    noResultsText: 'No result, hit space to create a new tag'
  });
});

/*
Write custom auto 
search /tags?q=***
put result in text field
return adds to list 
new entry return adds to list 
on submit convert list to comma separated 
in vew output comma separate as before 

AutoComplete = {
  input : $(),
  ul : $(),
  submit : $(),

  CSVToList : function () {
    //
  },
  
  listToCSV : function () {
  
  },

  searchTags : function () {
  
  },

  addToList : function () {
  
  },

  deleteTag : function () {
  
  },

  init : function () {
  
  }
}