$(document).ready ->
  answer_tpl = (body) ->
    tpl = '<div class="col-md-12 text-right">'
    tpl += '<p>' + body + '</p>'
    tpl += '<hr/>'
    tpl += '</div>'
    return tpl
  $("#answer_form").on("ajax:success", (e, data, status, xhr) ->
    console.log "success !!!!!!!!!!!!!!!!!!!!!!" + data
    console.log "body : " + data.body
    $("#answer_list").append answer_tpl(xhr.responseText)
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log "status : " + status
    console.log "error !!!!!!!!!!!!!!!!!!!!!!!!!!!" + error
    $("#answer_list").append answer_tpl("ERROR")
