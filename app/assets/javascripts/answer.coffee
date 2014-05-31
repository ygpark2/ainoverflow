class @Answer
  constructor: (@comment) ->
    console.log @comment

  answer_form_binding: (form) ->
    form.on("ajax:success", (e, data, status, xhr) =>
      $("#answer_list").append data
      idx = $('form[id="comment_answer_form"]').size() - 1
      form = $('form[id="comment_answer_form"]')[idx]
      @comment.answer_comment_form_binding idx, $(form), @comment.comment_tpl
      # $('form[id="comment_answer_form"]')
    ).on "ajax:error", (e, xhr, status, error) =>
      console.log "status : " + status
      console.log "error : " + error
      $("#answer_list").append "ERROR!!!"
