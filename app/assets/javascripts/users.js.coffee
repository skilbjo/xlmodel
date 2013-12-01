jQuery.noConflict()
$ = jQuery
$ ->
  jQuery(document).ready ($) ->
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
    $("user_email").click ->
      alert("hello")


    $("#new_user").submit (event) ->

      $form = $(this)
      
      # Disable the submit button to prevent repeated clicks
      $form.find("button").prop "disabled", true
      try
        Stripe.card.createToken $form, stripeResponseHandler
      catch e
        alert(e)
       
      # Prevent the form from submitting with the default action
      false


$ ->
  $(".processor-div").on "change", ->
    if $(this).val() is "stripe"
      $("#stripe-div").show()
      $("#fortumo-div").hide()
    if $(this).val() is "fortumo"
      $("#stripe-div").hide()
      $("#fortumo-div").show()

