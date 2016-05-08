module NexposeApi

  class BaseHandlers < Sinatra::Application

    use Raven::Rack

    set :root, File.join(File.dirname(__FILE__), '..')

    set :views, Proc.new { File.join(root, "views") }

    helpers Sinatra::Param
    
    before do
      # we almost always want a JSON output
      content_type :json
    end
    
    not_found do
      { status: 404, message: 'Not Found' }.to_json
    end

    error do
      'Sorry there was a nasty error - ' + env['sinatra.error'].message
    end

  end

end
