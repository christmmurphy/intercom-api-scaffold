require 'sinatra'
require 'intercom'

  # Default form page when you boot the app. Visit local:4567. Check out view/index.erb to make changes
  get '/' do
    erb :index
  end

  # This code runs when the form is submitted to /function
  post '/function' do
    # Storing the values entered to the form
    pat = params[:pat]
    field_1 = params[:field_1]
    field_2 = params[:field_2]

    # Set up Intercom Ruby SDK to make requests with
    @intercom = Intercom::Client.new(token: pat);

    # Return to the home page when it has completed!
    puts "COMPLETE"
    erb :index
  end


  # FUNCTIONS USED BY THE APP

  # Default rate limiting method
  def check_rate
    if not @intercom.rate_limit_details[:remaining].nil? and @intercom.rate_limit_details[:remaining] < 2
        sleep_time = @intercom.rate_limit_details[:reset_at].to_i - Time.now.to_i
        puts("Waiting for #{sleep_time} seconds to allow for rate limit to be reset")
        sleep sleep_time
      end
  end

  def example_function
    # Add function code here - don't forget you'll need to make these attributes globally available using: @example_attribute
    # If you are using a function to perform a loop, call the check_rate method to cool off.
      check_rate()
  end
