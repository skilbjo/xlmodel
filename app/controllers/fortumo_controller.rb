"""
  in the controller
def index
  incoming_url = request.referer # this catch the incoming url, including its params
  incoming_url_params = URI(incoming_url).query # this returns an string with the incoming url params
       => URI(http://foo/bar/baz?search=FooBar).query #=> search=FooBar
  new_url = do_something_with_the_url_and_its_params_internally(incoming_url, incoming_url_params)
  redirect_to new_url
end
"""

# Hash[*s.split(/=|&/)] => {"a"=>"b", "c"=>"d"}


def index
  incoming_url = request.referer # this catch the incoming url, including its params
  incoming_url_params = URI(incoming_url).query # this returns an string with the incoming url params
  incoming_url_params_hash = Hash[*incoming_url_params.split(/\=/)]
  if receive_fortumo
    if check_signature(incoming_url_params,secret)
    end
  end
end

def receive_fortumo
  in_array('79.125.125.1', '79.125.5.205', '79.125.5.95')
  secret = ENV['FORTUMO_SECRET_KEY']  
  incoming_url = request.referer
  incoming_url_params = URI(incoming_url).query
  request.remote_ip
  remote_ip = request.env["HTTP_X_FORWARDED_FOR"]

  if (!in_array(remote_ip))  # verify get comes from Fortumo server
    header('HTTP/1.0 403 Forbidden')
    abort('Error: Unknown IP')
  end

  if (secret.isempty?) || !check_signature(GET, secret)  # verify signature
    header('HTTP/1.0 403 Forbidden')
    abort('Error: Unknown IP')
  end
end

  def check_signature( incoming_url_params , secret)
    incoming_url_params.keys.sort # sort key value pairs
    str = ''
    for incoming_url_params.each do |key, value|  #< -- this correct
      if key != 'sig'  # <-- this correct?
        str << "#{key}=#{value}"
      end
      str
    end
      str << secret
      signature = Digest::MD5.hexdigest(str)

      incoming_url_params['sig'] == signature
  end

  sender = incoming_url_params['sender']
  amount = incoming_url_params['amount']
  cuid = incoming_url_params['cuid']
  payment_id = incoming_url_params['payment_id']
  test = incoming_url_params['test'] # only present during test mode

  if (test)
    puts "test OK"
  else
    puts "OK"
  end

  if ("/failed/".match(incoming_url_params['status']))
    # logic for failed payment
    puts "payment failed"
  else
    # logic for successful payment (callback to controller)
  end
end
