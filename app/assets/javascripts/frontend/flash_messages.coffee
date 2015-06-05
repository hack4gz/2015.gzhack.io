$ ->
  $flashMessages = $('#flash-messages')
  if $flashMessages.length
    setTimeout ->
      $flashMessages.slideUp()
    , 5000
