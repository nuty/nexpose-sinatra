
module NexposeApi

  class Index < BaseHandlers

    get '/' do
      content_type :html
      erb :home
    end

    not_found do
      { status: 404, message: 'Not Found' }.to_json
    end

    error do
      'Sorry there was a nasty error - ' + env['sinatra.error'].message
    end

  end

end



