function do_vote(element) {
  $(element).parents().find('form').submit();
}
$(document).ready(function(){
  $("input[type=radio][name=answer_id]").click(function() {
    do_vote(this);
  });
})