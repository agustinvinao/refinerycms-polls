do_vote = (element) ->
  $(element).parents().find('form').submit()
jQuery ->
  $("input[type=radio][name=answer_id]").click ->
    do_vote(this)
    $(this).attr "disabled", true