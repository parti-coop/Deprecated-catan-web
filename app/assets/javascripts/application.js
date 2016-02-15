//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require webui-popover
//= require bootstrap-typeahead
//= require_tree .

$(document).on('ready', function(e) {
  $('[data-toggle="webui-popover"]').webuiPopover();
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="catan-opinion-respond"]').on('click', function(e) {
    e.preventDefault();
    var source_id = $(e.currentTarget).data('source-id');
    var nickname = $(e.currentTarget).data('source-user-nickname');
    var $form = $($(e.currentTarget).data('form'));

    $form.find('#opinion_source_id').val(source_id);
    $form.find('#opinion_body').val('@' + nickname + ' ');
    $form.find('#opinion_body').focus();

    $form.find('.help-block-opinion-choice').addClass('hidden');

    $form.find('.help-block-opinion-source').removeClass('hidden');
    $form.find('.help-block-opinion-source .nickname').html(nickname);

    $(window).scrollTop($form.offset().top - 100);
  });
  $('[data-toggle="catan-opinion-cancel-to-respond"]').on('click', function(e) {
    e.preventDefault();
    var $form = $(e.currentTarget).closest('form');

    $form.find('#opinion_source_id').val(null);
    $form.find('#opinion_body').val(null);

    $form.find('.help-block-opinion-choice').removeClass('hidden');

    $form.find('.help-block-opinion-source').addClass('hidden')
    $form.find('.help-block-opinion-source .nickname').html('')
  });

  var typeaheadSource = [{ id: 1, name: 'John', year: '1977'}, { id: 2, name: 'Alex'}, { id: 3, name: 'Terry'}];

  $('input.typeahead').typeahead({
    onSelect: function(item, typeahead) {
      $target = $(typeahead.$element.data('typeahead-target'));
      if($target) {
        console.log( item.value );
        $target.val( item.value );
      }
    },
    ajax: {
      url: "/issues/autocomplete",
      timeout: 500,
      displayField: "title",
      triggerLength: 1,
      method: "get",
      preProcess: function (data, typeahead) {
        console.log(  );
        $target = $(typeahead.$element.data('typeahead-target'));
        if( $target && data.issues.length <= 0 ) {
          $target.val('');
        }
        return data.issues;
      }
    }
  });
});
