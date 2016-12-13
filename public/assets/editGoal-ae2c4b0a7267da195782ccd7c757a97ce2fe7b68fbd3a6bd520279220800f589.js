$(function(){
  setSortable();
}

var setSortable = function(){
  $('.goallist').sortable({
                 connectWith: $('.goallist')
         });

}
;
