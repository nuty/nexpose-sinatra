module NexposeApi

  class SiteHandlers < BaseHandlers

    nexpose_sdk = NexposeSDK.new

    get '/summary' do
      json(nexpose_sdk.sitesummary.list_sites_summary)
    end

    get '/summary/:site_id' do
      json(nexpose_sdk.sitesummary.list_sites_summary.select { |summary| summary['id']== params['site_id'].to_i })
    end

    get '/:site_id' do
      site = nexpose_sdk.site.get_site(params['site_id'].to_i)
      json(site.to_h)
    end

    post '/' do
      begin
        include_addresses = params["include_addresses"].split(";")
        name = params["name"]
      rescue IndexError => e
        raise
      end
      begin
        include_asset_groups = params["include_asset_groups"].split(";")
      rescue IndexError => e
        include_asset_groups = []
      end
      included_scan_targets = { addresses: include_addresses, asset_groups: include_asset_groups }
      begin
        site_save_rv = nexpose_sdk.site.create(name=name, included_scan_targets)
        rv = { code: 200, ok: true, site_id: site_save_rv }.to_json
      rescue Exception => e
        rv = { code: 200, ok: false, site_id: nil}.to_json
      end
      rv
    end

    delete '/:site_id' do
      def_rv =  { code: 200, ok: 'false' }.to_json
      site = nexpose_sdk.site.get_site(params['site_id'].to_i)
      if site != nil
        del_rv = nexpose_sdk.site.delete(site.id)
        if del_rv
          rv = { code: 200, ok: 'true' }.to_json
        else
          rv = def_rv
        end
      else
        rv = def_rv
      end
      rv
    end

  end

end
