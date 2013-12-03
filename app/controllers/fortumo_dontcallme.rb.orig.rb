
"""
# Hash[*s.split(/=|&/)] => {"a"=>"b", "c"=>"d"}
# should i use CGI parser to parse HTTP params?
FORTUMO_IPS = ['79.125.125.1', '79.125.5.205', '79.125.5.95']

def index
  # receive various information about the HTTP GET
  incoming_url = request.referer # this catch the incoming url, including its params <-- not request referer; mess around in testing; something on the request object request.host??
  request.remote_ip
  remote_ip = request.env["HTTP_X_FORWARDED_FOR"] # find something else eg not enviornment variable
  secret = ENV['FORTUMO_SECRET_KEY']  
  if not FORTUMO_IPS.include? request.remote_ip
    return abort('FORTUMO_IPS: Unknown IP')
  end

  if not valid_signature?(params, secret) 
    return abort('Error: get_signature')
  end

  @user = User.new(user_params)
  @user.name = incoming_url_params['sender']  # use twilio API for payment link ??
  @user.email = incoming_url_params['sender'] # use twilio API for payment link ??
  @user.product = 'xltest' 
  if @user.save && user.valid?
    flash.now[:success] = "Thank you for payment!"
  end
end

def receive_fortumo
  if (!in_array(remote_ip))  # verify get comes from Fortumo server
    header('HTTP/1.0 403 Forbidden')
    abort('Error: Unknown IP')
  end

  if (secret.isempty?) || !check_signature( incoming_url_params , secret)  # verify signature
    header('HTTP/1.0 403 Forbidden')
    abort('Error: Unknown IP')
  end
end

def valid_signature?( incoming_url_params, secret )
  # parsing params 
  sender = incoming_url_params['sender']
  amount = incoming_url_params['amount']
  cuid = incoming_url_params['cuid']
  payment_id = incoming_url_params['payment_id']
  test = incoming_url_params['test'] # only present during test mode

  # check signature
  incoming_url_params.keys.sort # sort key value pairs
  str = ''
  for incoming_url_params.keys.sort.each do |key|  #< -- this correct
    if key != 'sig'  # <-- this correct?
      str << #{key}=#{value}
    end
  end
  str << secret
  return secret == Digest::MD5.hexdigest(str)


  # # check if test
  # if (test)
  #   puts "test OK"
  # else
  #   puts "OK"
  # end

  # # check payment status
  # if (/failed/.match(incoming_url_params['status']))
  #   # logic for failed payment
  #   puts payment failed
  # else
  #   # logic for successful payment (callback to controller)
  # end
end


{ 1: {:2 {:3 {4: nil, 5: nil} } 6: nil} }

# do depth-first search & breadth-first search
def find(x)

end

find(:2) 

"""
