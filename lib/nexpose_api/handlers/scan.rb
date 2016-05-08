module NexposeApi

  class ScanHandlers < BaseHandlers

    nexpose_sdk = NexposeSDK.new

    get '/activity' do
      json(nexpose_sdk.scan.activity)
    end

    get '/completed/:site_id' do
      site_id = params['site_id']
      if !site_id.nil?
        if site_id.to_i.is_a? Integer
          rv = json(nexpose_sdk.scan.completed(site_id.to_i))
        else
          rv = json([])
        end
      else
        rv = json([])
      end
      rv
    end

    get '/status/:scan_id' do
      scan_id = params['scan_id']
      if !scan_id.nil?
        if scan_id.to_i.is_a? Integer
          status = nexpose_sdk.scan.status(scan_id.to_i)
          rv = { code: 200, ok: true, status: status }.to_json
        else
          status = nil
          rv = { code: 200, ok: true, status: status }.to_json
        end
      end
      rv
    end


    get '/:site_id' do
      site_id = params['site_id']
      def_ret = { code: 200, ok: false, scan_id: nil }.to_json
      if !site_id.nil?
        if site_id.to_i.is_a? Integer
          scan_rv = nexpose_sdk.scan.run(site_id.to_i)
          if !scan_rv.nil?
            ret = { code: 200, ok: true, scan_id: scan_rv.id }.to_json
          else
            ret = def_ret
          end
        else
          ret = def_ret
        end
      else
        ret = def_ret
      end
      ret
    end


  end

end
