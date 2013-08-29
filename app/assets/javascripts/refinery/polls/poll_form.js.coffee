do_vote = (element) ->
  $(element).closest('form').submit()
jQuery ->
  $("input[type=radio][name=answer_id]").click ->
    do_vote(this)
    $(this).attr "disabled", true
