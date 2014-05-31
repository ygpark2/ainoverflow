$(document).ready ->
  comment = new Comment
  comment.answer_comment_list_binding comment.answer_comment_form_binding, comment.comment_tpl
  comment.question_comment_form_binding $("#comment_question_form")

  answer = new Answer(comment)
  answer.answer_form_binding $("#answer_form")
