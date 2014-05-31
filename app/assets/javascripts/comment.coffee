class @Comment

  constructor: (@comment = "comment") ->
    console.log @comment

  comment_tpl: (data) =>
    tpl = '<p class="text-right">' + data.comment + '</p>'
    tpl += '<p class="text-right">' + data.updated_at + '</p>'
    tpl += '<hr/>'
    return tpl

  answer_comment_form_binding: (idx, form, cmt_tpl) ->
    console.log cmt_tpl({})
    form.on("ajax:success", (e, data, status, xhr) =>
      $($('div[id="answer_comment_list"]')[idx]).append cmt_tpl(data)
      # for key, value of data
      #   console.log "key => " + key
      #   console.log "value => " + value
    ).on("ajax:error", (e, xhr, status, error) =>
      $($('div[id="answer_comment_list"]')[idx]).append "ERROR!"
      # console.log "error !!!!!!!!!!!!!!!!!!!!!!!!!!!" + error
    )

  answer_comment_list_binding: (acfb, cmt_tpl) ->
    $('form[id="comment_answer_form"]').each (idx, form) =>
      acfb idx, $(form), cmt_tpl # answer_comment_form_binding, comment_tpl

  question_comment_form_binding: (form) ->
    form.on("ajax:success", (e, data, status, xhr) =>
      console.log "success !!!!!!!!!!!!!!!!!!!!!!" + data
      $($('div[id="question_comment_list"]')).append this.comment_tpl(data)
      # $("#answer_list").append answer_tpl(xhr.responseText)
    ).on "ajax:error", (e, xhr, status, error) =>
      console.log "status : " + status
      console.log "error !!!!!!!!!!!!!!!!!!!!!!!!!!!" + error
      $($('div[id="question_comment_list"]')).append "ERROR!"

###
$(document).ready ->
  test = () ->
    alert("this is test function")

  comment_tpl = (data) ->

  $('form[id="comment_answer_form"]').each (idx, form) ->
    $(form).on("ajax:success", (e, data, status, xhr) ->
      $($('div[id="answer_comment_list"]')[idx]).append comment_tpl(data)
      # for key, value of data
      #   console.log "key => " + key
      #   console.log "value => " + value
    ).on("ajax:error", (e, xhr, status, error) ->
      $($('div[id="answer_comment_list"]')[idx]).append "ERROR!"
      # console.log "error !!!!!!!!!!!!!!!!!!!!!!!!!!!" + error
    )

  $("#comment_question_form").on("ajax:success", (e, data, status, xhr) ->
    console.log "success !!!!!!!!!!!!!!!!!!!!!!" + data
    $($('div[id="question_comment_list"]')).append comment_tpl(data)
    # $("#answer_list").append answer_tpl(xhr.responseText)
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log "status : " + status
    console.log "error !!!!!!!!!!!!!!!!!!!!!!!!!!!" + error
    $($('div[id="question_comment_list"]')).append "ERROR!"
###
