runfunction = function(id){
  console.log(id);
  console.log($('[task-id='+id+']'));
  if($('[check-id='+id+']').prop('checked')){
    $('[task-id='+id+']').attr('class','completed');
  } else{
    $('[task-id='+id+']').attr('class','');
  }
}

$(function(){
  $('li').on('change','.checkbox', function(){
    var id = $(this).attr('check-id');
    runfunction(id)
  });
});
