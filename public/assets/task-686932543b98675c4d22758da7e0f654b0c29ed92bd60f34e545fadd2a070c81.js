runfunction = function(id){
  console.log(id);
  console.log($('[task-id='+id+']'));
  if($('[check-id='+id+']').prop('checked')){
    if($('[task-id='+id+']').hasClass('flagged')){
      $('[task-id='+id+']').attr('flag',true);
    }
    $('[task-id='+id+']').attr('class','completed');
  } else{
    if($('[task-id='+id+']').attr('flag')){
      $('[task-id='+id+']').attr('class','flagged');
    }else{
      $('[task-id='+id+']').attr('class','');
    }
  }
}

$(function(){
  $('li').on('change','.checkbox', function(){
    var id = $(this).attr('check-id');
    runfunction(id)
  });
});
