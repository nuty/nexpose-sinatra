module NexposeApi

  class SiloHandlers < BaseHandlers

    nexpose_sdk = NexposeSDK.new

    get '/profiles' do
      json(nexpose_sdk.siloprofile.list)
    end

    get '/silos' do
      json(nexpose_sdk.silo.list)
    end

    post '/profile' do
      begin
        id = params["id"]
        name = params["name"]
      rescue Exception => e
        id = name = nil
      end
      if id.nil? or name.nil?
        rv = {code: 200, message: 'args error', ok: false}
      else
        silo_profile = nexpose_sdk.siloprofile.create(id, name)
        if silo_profile.nil?
          rv = {code: 500, message: 'create error', ok: false}
        else
          rv = {code: 200, message: '', ok: true, silo_profile_id: silo_profile}
        end
      end
      rv.to_json
    end

    post '/silo' do
      begin
        id = params["id"]
        name = params["name"]
        profile_id = params["profile_id"]
      rescue Exception => e
        id = name = profile_id = nil
      end
      if id.nil? or name.nil? or profile_id.nil?
        rv = {code: 500, message: 'args error', ok: false}
      else
        silo = nexpose_sdk.silo.create(id, name, profile_id)
        if silo.nil?
          rv = {code: 500, message: 'create error', ok: false}
        else
          rv = {code: 500, message: '', ok: true, silo_id: silo}
        end
      end
     rv.to_json
    end

    delete '/profile/:profile_id' do
    
    end
    
    delete '/silo/:silo_id' do
    
    end

  end

end
