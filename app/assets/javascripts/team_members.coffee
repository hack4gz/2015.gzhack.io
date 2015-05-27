$ ->
  $membersList = $('#members-list')

  $membersList.on 'touchend', '.item', (event)->
    touchSameItem = $(this).hasClass('current')
    $previousItem = $membersList.find('.item.current')
    $previousItem.removeClass('current').find('.introduction-container, .name').hide()

    unless touchSameItem
      $(this).addClass('current').find('.introduction-container, .name').show()
    event.preventDefault()
