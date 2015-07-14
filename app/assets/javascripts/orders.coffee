# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  #
  # Receive some response from the orders controller  and update the order items
  # table as appropriate.
  #
  updateOrderItemsFromRemote = (data)->
    if data.status == 'complete'
      if data.redirect?
        window.location.replace(data.redirect)
      else if data.items?
        $('table.orderItems').replaceWith(data.items)
        $('.dropdown .total_items').text(data.quantity)
    else if data.status == 'error'
      alert data.message

  # Show hide delivery address
  $delivery = $('.delivery')
  $checkbox = $('#order_separate_delivery_address')

  $checkbox.change ->
    if @checked then $delivery.show() else $delivery.hide()
    return
  #
  # Submit a link
  #
  ajaxLink = (successMethod)->
    $.ajax
      url: $(this).attr('href')
      type: $(this).data('method')
      dataType: 'json'
      success: successMethod
    false

  #
  # When clicking links in the order items table, submit them
  # using the ajaxLink helper
  #
  $('body').on 'click', 'table.orderItems tbody td a.ajax', -> ajaxLink.call(this, updateOrderItemsFromRemote)
