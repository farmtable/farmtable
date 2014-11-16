$(document).ready(function(){
  $('.add-item-link').click(function(){
    var item = $(this)[0].attributes.data.value;
    $.post("carts/add?community_id=1", {"item_id" : item}, function(data) {
      console.log(data);
    });
  });
});