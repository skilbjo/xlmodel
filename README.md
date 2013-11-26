##xlmodel

This is a side project I have been working on nights/weekends at my local coffeshop (twtr: @AnotherCafe) to learn web development. An unbelievable amount of technology goes into building a website! Below is a list of the technologies I used.


###Technologies

Terminal

Navigate your unix-like environment

	ls, cd, mkdir, cat, sudo, rm -rf
	
Git

Version control for your software

	$ git commit -am "finally got this working!"
	
	$ git checkout master
	
	$ git merge feature-branch
	
	$ git push origin master

Ruby 2

The programming language of the gods

	$ ruby -v
	
	ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-darwin12.3.0]

rvm: for managing different versions of Ruby on your local machine
	
    $ rvm -v
    	
	
Rails 4

	$ rails -v
	
	Rails 4.0.1
	
jQuery: the best javascript library; abstract away different browser implementations of javascript with a simple `$(element)` command!

    $(document).ready ->

Coffeescript

Why write verbose javascript?

	$("#new_user").submit (event) ->
      $form = $(this)
      $form.find("button").prop "disabled", true
      try
        Stripe.card.createToken $form, stripeResponseHandler
      catch e
        debugger


Enjoy!