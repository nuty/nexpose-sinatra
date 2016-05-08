module NexposeApi

  class UserHandlers < Sinatra::Application

    nexpose_sdk = NexposeSDK.new

    get '/' do
      json(nexpose_sdk.usersummary.list_users)
    end

    not_found do
      { status: 404, message: 'Not Found' }.to_json
    end

    error do
      'Sorry there was a nasty error - ' + env['sinatra.error'].message
    end


  end

end
