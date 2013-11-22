$(document).ready(function(){
  var stripeResponseHandler = function(status, response) {
  var $form = $('#payment-form');

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message);
    $form.find('button').prop('disabled', false);
  } else {
    // token contains id, last4, and card type
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    // and submit
    $form.get(0).submit();
  }
};

  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  $('#payment-form').submit(function(event) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    try {
      Stripe.card.createToken($form, stripeResponseHandler);
    } catch(e) {
      debugger;
    }

    // Prevent the form from submitting with the default action
    return false;
  });
});
  
