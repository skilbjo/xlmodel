$(document).ready ->
  stripeResponseHandler = (status, response) ->
    $form = $("#new_user")
    if response.error
      
      # Show the errors on the form
      $form.find(".payment-errors").text response.error.message
      $form.find("button").prop "disabled", false
    else
      
      # token contains id, last4, and card type
      token = response.id
      
      # Insert the token into the form so it gets submitted to the server
      $form.append $('<input type="hidden" name="user[ptoken]" />').val(token)
      
      # and submit
      $form.get(0).submit()

  Stripe.setPublishableKey $("meta[name=\"stripe-key\"]").attr("content")
  $("#new_user").submit (event) ->
    $form = $(this)
    
    # Disable the submit button to prevent repeated clicks
    $form.find("button").prop "disabled", true
    try
      Stripe.card.createToken $form, stripeResponseHandler
    catch e
      debugger
    
    # Prevent the form from submitting with the default action
    false

