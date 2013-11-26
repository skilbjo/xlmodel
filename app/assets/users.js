jQuery.noConflict();
(function( $ ) {
  	$(document).ready(function() {
	    var stripeResponseHandler;
	    stripeResponseHandler = function(status, response) {
	      var $form, token;
	      $form = $("#new_user");
	      if (response.error) {
	        $form.find(".payment-errors").text(response.error.message);
	        return $form.find("button").prop("disabled", false);
	      } else {
	        token = response.id;
	        $form.append($('<input type="hidden" name="user[ptoken]" />').val(token));
	        return $form.get(0).submit();
	      }
	    };
	    Stripe.setPublishableKey($("meta[name=\"stripe-key\"]").attr("content"));
	    $("user_email").click(function() {
	      return alert("hello");
	    });
	    return $("#new_user").submit(function(event) {
	      var $form;
	      $form = $(this);
	      $form.find("button").prop("disabled", true);
	      try {
	        Stripe.card.createToken($form, stripeResponseHandler);
	      } catch (e) {
	        alert(e);
	      }
	      return false;
	    });
    });
})(jQuery);