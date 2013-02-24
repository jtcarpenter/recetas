$(document).ready(function() {
  Print.init();
});

var Print = {
  printBtn: {},
  print: function() {
    window.print();
  },
  init: function() {
    this.printBtn = $('#print').bind('click', this.print);
  }
};