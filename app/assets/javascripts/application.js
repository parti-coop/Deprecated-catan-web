//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require webui-popover
//= require_tree .

$(document).on('ready', function(e) {
  $('[data-toggle="webui-popover"]').webuiPopover();
});
