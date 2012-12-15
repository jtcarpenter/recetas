describe("AutoCom", function () {
  var CSVMock, emptyCSVMock, listMock, labelTextMock, objectsMock, ulMock, tagArray;

  beforeEach(function() {
    AutoCom.postTagsUl = $('<ul/>', {'id': 'post-tags'});
    CSVMock = "first, second";
    emptyCSVMock = "";
    listMock = [$('<li/>').text('first'), $('<li/>').text('second')];
    labelTextMock = "Text (Text in parenthesis)";
    objectsMock = $.parseJSON('[{"id":1,"name":"tag1","count":1},{"id":2,"name":"tag2","count":2}]');
    ulMock = $('<ul/>');
    tagArrayMock = $('<ul/>').append([$('<li/>').html('tag1 <span>x</span>'),$('<li/>').html('tag2<span>x</span>')]);
    postTagMock = $('<li/>').html('tag ' + AutoCom.deleteBtn);
  });

  afterEach(function() {
    AutoCom.postTagsUl = {};
    CSVMock = "";
    emptyCSVMock = "";
    listMock = [];
    labelMock = "";
    objectsMock = [];
    ulMock = {};
    tagArrayMock = [];
    postTagMock = {};
  });

  it("converts CSV to and an array of li elements",  function () {
    var list = AutoCom.CSVToList(CSVMock);
    expect(list.length).toEqual(2);
    expect(list[0].text()).toEqual('first');
  });
  it("does not empty elements in CSV to array of li elements", function () {
    var emptyList = AutoCom.CSVToList(emptyCSVMock);
    expect(emptyList.length).toEqual(0);
  });
  it("converts an array of li elements to CSV",  function () {
    var csv = AutoCom.listToCSV(listMock);
    expect(csv).toEqual("first, second");
  });
  it("removes portion of text enclosed by parenthesis",  function () {
    var modifiedText = AutoCom.removeParenthesised(labelTextMock);
    expect(modifiedText).toEqual("Text");
  });
  it("converts an array of objects into li elements ",  function () {
    var list = AutoCom.objectsToList(objectsMock);
    expect(list.length).toEqual(2);
    expect(list[0].text()).toEqual('tag1');
  });
  it("appends a string to a ul as a li element",  function () {
    var tag = "new tag";
    AutoCom.addTagToList(tag, ulMock);
    expect($(ulMock).children().length).toEqual(1);
  });
  it("removes the delet button from a post tag", function () {
    expect(AutoCom.removeDeleteBtn(postTagMock)).toEqual('tag');
  });
  it("determines if a new tag not in array of tags", function () {
    expect(AutoCom.tagExists('tag1', tagArrayMock)).toEqual(true);
    expect(AutoCom.tagExists('tag3', tagArrayMock)).not.toEqual(true);
  });
});