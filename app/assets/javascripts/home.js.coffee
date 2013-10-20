$(window).on "ready page:change", ->
  alertTimeout = null

  hideAlert = ->
    $('.alert-box').slideUp()
    window.clearTimeout(alertTimeout)

  initAlertTimeout = ->
    alertTimeout = window.setTimeout(hideAlert, 5000)

  initAlertTimeout()


  $('textarea').on "keyup", ->
    len = $(this).val().length
    remain = 140-len
    $('#letters-remaining').text(remain)
    if remain < 0
      $('#letters-remaining').addClass('over')
    else
      $('#letters-remaining').removeClass('over')


