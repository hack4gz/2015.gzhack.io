$ ->
  $membersList = $('#members-list')

  $membersList.on 'touchend', '.item', (event)->
    currentClass = 'current'
    touchSameItem = $(this).hasClass(currentClass)
    $previousItem = $membersList.find(".item.#{currentClass}")
    $previousItem.removeClass(currentClass).find('.introduction-container, .name').hide()

    unless touchSameItem
      $(this).addClass(currentClass).find('.introduction-container, .name').show()
    event.preventDefault()
