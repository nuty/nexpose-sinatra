
module NexposeApi
  # Sinatra app to give basic film showing details.

  class SysHandlers < BaseHandlers

    nexpose_sdk = NexposeSDK.new

    get '/ver' do
      # 获得软件版本信息
      json(nexpose_sdk.sys.get_ver.split("\n"))
    end

    get '/info' do
      # 获取系统信息
      json(nexpose_sdk.sys.get_info)
    end

  end


end



