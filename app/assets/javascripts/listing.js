window.ST = window.ST || {};

window.ST.listing = function() {
  $('#add-to-updates-email').on('click', function() {
    var text = $(this).find('#add-to-updates-email-text');
    var actionLoading = text.data('action-loading');
    var actionSuccess = text.data('action-success');
    var actionError = text.data('action-error');
    var url = $(this).attr('href');

    text.html(actionLoading);

    $.ajax({
      url: url,
      type: "PUT",
    }).done(function() {
      text.html(actionSuccess);
    }).fail(function() {
      text.html(actionError);
    });
  });
};

$(document).ready(function(){
  $('.add-item-link').click(function(){
    var item = $(this)[0].attributes.data.value;
    $.post("carts/add?community_id=1", {"item_id" : item}, function(data) {
      console.log(data);
    });
  });
});