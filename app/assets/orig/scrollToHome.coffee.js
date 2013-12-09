jQuery.noConflict()
$ = jQuery
$ ->
  $("#navbar").on "click", "li a", ->
    $clickedAnchor = $(this)
	  $panelToScrollTo = $("#" + $clickedAnchor.data("loc"))
	  $panelToScrollTo.scrollTo()    