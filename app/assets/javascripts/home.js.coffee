$.fn.scrollUp = (visibility) ->
  if !window.originalOffset?
    window.originalOffset = $(this).offset().top
  width = $(this).parent().width()
  height = $(window).height()
  if visibility == 'hide'
    top = $(this).offset().top
    $(this).css
      'position': 'absolute'
      'top': top
      'width': width
    $(this).animate
      'top': - height
      800
    , ->
      $(this).hide()
  else
    $(this).show()
    $(this).css
      'position': 'absolute'
      'top': height
      'width': width
    $(this).show()
    $(this).animate
      'top': originalOffset
      800

$.fn.scrollDown = (visibility) ->
  if !window.originalOffset?
    window.originalOffset = $(this).offset().top
  width = $(this).parent().width()
  height = $(window).height()
  if visibility == 'hide'
    top = $(this).offset().top
    $(this).css
      'position': 'absolute'
      'top': top
      'width': width
    $(this).animate
      'top': top + height
      800
    , ->
      $(this).hide()
  else
    $(this).css
      'position': 'absolute'
      'top': - height
      'width': width
    $(this).show()
    $(this).animate
      'top': originalOffset
      800

window.Home =
  init: ->
    @listenToLearnMore()

  listenToLearnMore: ->
    $(document).on 'click', 'a.learn-more', ->
      $('#welcome').scrollUp('hide')
      $('#learn-more').scrollUp()
    $(document).on 'click', 'a.back', ->
      $('#welcome').scrollDown()
      $('#learn-more').scrollDown('hide')


$ ->

  Home.init()

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


