module NexposeApi

    class Scan < NexposeBase

      def run(site_id)
        begin
          site = Nexpose::Site.load(@nsc, site_id)
        rescue Exception => e
          site = nil
        end
        if site != nil
          begin
            scan_rv = site.scan(@nsc)
            flag = true
          rescue Exception => e
            flag = false
          end
        else
          flag = false
        end
        if flag
          rv = scan_rv
        else
          rv = nil
        end
        rv
      end

      def activity
        rv = Array.new
        begin
          resources = @nsc.activity
        rescue Exception => e
          resources = nil
        end
        if resources != nil
          for resource in resources
            dict = Hash.new
            dict["site_id"] = resource.site_id
            dict["engine_id"] = resource.engine_id
            dict["scan_id"] = resource.scan_id
            dict["status"] = resource.status
            dict["start_time"] = resource.start_time
            dict["end_time"] = resource.end_time
            rv.push(dict)
          end
        end
        rv
      end

      def completed(site_id)
        rv = Array.new
        begin
          scans = @nsc.completed_scans(site_id)
        rescue Exception => e
          scans = nil
        end
        if !scans.nil?
          for scan in scans
            dict = Hash.new
            dict["id"] = scan.id
            dict["site_id"] = scan.site_id
            dict["status"] = scan.status
            dict["start_time"] = scan.start_time
            dict["end_time"] = scan.end_time
            dict["duration"] = scan.duration
            dict["vulns"] = scan.vulns
            dict["assets"] = scan.assets
            dict["risk_score"] = scan.risk_score
            dict["type"] = scan.type
            dict["engine_name"] = scan.engine_name
            rv.push(dict)
          end
        end
        rv
      end

      def status(scan_id)
        begin
          status = @nsc.scan_status(scan_id)
        rescue Exception => e
          status = nil
        end
        status
      end


  end
end
