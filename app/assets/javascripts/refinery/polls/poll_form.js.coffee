do_vote = (element, url) ->
  $(element).parents().find('form').submit()
jQuery ->
  url = $("input[type=radio][name=answer_id]").parents().find('form').attr("action")
  $("input[type=radio][name=answer_id]").click ->
    do_vote(this, url)
    $(this).attr "disabled", true