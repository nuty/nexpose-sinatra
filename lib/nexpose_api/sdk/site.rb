module NexposeApi

    class SiteSummary < NexposeBase

      def list_sites_summary
        sites = @nsc.sites
        rv = Array.new
        for site in sites
          dict = Hash.new
          dict["id"] = site.id
          dict["name"] = site.name
          dict["risk_factor"] = site.risk_factor
          dict["risk_score"] = site.risk_score
          dict["description"] = site.description
          rv.push(dict)
        end
        rv
      end
    end

    class Sites < NexposeBase

      def get_site(site_id)
        begin
          rv = Nexpose::Site.load(@nsc, site_id)
        rescue Exception => e
          rv = nil
        end
        rv
      end

      def create(name,
               included_scan_targets,
               scan_template_id = 'full-audit-without-web-spider',
               description = " ",
               risk_factor = 1.0,
               config_version = 3,
               schedules = [],
               blackouts = [],
               excluded_scan_targets = { addresses: [], asset_groups: [] },
               site_credentials = [],
               shared_credentials = [],
               web_credentials = [],
               alerts = [],
               users = [],
               tags = []
              )
          site = Nexpose::Site.new(name, scan_template_id)
          site.description = description
          site.risk_factor = risk_factor
          site.config_version = config_version
          site.schedules = schedules
          site.blackouts = blackouts
          site.included_scan_targets = included_scan_targets
          site.excluded_scan_targets = excluded_scan_targets
          site.site_credentials = site_credentials
          site.shared_credentials = shared_credentials
          site.web_credentials = web_credentials
          site.alerts = alerts
          site.users = users
          site.tags = tags
          site.save(@nsc)
          site.id
      end

      def delete(site_id)
        site = get_site(site_id)
        if site != nil
          begin
            site.delete(@nsc)
            rv = true
          rescue Exception => e
            rv = false
          end
        end
        rv
      end

  end
end
