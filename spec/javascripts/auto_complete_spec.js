describe("AutoCom", function () {
  var CSVMock, emptyCSVMock, listMock, labelTextMock, objectsMock;

  beforeEach(function() {
    CSVMock = "first, second";
    emptyCSVMock = "";
    listMock = [$('<li/>').text('first'), $('<li/>').text('second')];
    labelTextMock = "Text (Text in parenthesis)";
    objectsMock = $.parseJSON('[{"id":1,"name":"tag1","count":1},{"id":2,"name":"tag2","count":2}]');
  });
  afterEach(function() {
    CSVMock = "";
    emptyCSVMock = "";
    listMock = [];
    labelMock = "";
    objectsMock = [];
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
  it("appends a li element to a ul",  function () {
    this.fail('NOT YET IMPLEMENTED');
  });
  it("deletes a 'tag' li from a ul",  function () {
    this.fail('NOT YET IMPLEMENTED');
  });
});