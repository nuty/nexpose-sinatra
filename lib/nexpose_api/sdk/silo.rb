module NexposeApi

    class SiloProfile < NexposeBase

      def list
        silo_profiles = @nsc.silo_profiles
        rv = Array.new
        for silo_profile in silo_profiles
          dict = Hash.new
          dict["id"] = silo_profile.id
          dict["name"] = silo_profile.name
          dict["description"] = silo_profile.description
          dict["global_scan_engine_count"] = silo_profile.global_scan_engine_count
          dict["global_report_template_count"] = silo_profile.global_report_template_count
          dict["global_scan_template_count"] = silo_profile.global_scan_template_count
          dict["licensed_module_count"] = silo_profile.licensed_module_count
          dict["restricted_report_section_count"] = silo_profile.restricted_report_section_count
          dict["all_licensed_modules"] = silo_profile.all_licensed_modules
          dict["all_global_engines"] = silo_profile.all_global_engines
          dict["all_global_report_templates"] = silo_profile.all_global_report_templates
          dict["all_global_scan_templates"] = silo_profile.all_global_scan_templates
          rv.push(dict)
        end
        rv
      end

      def create(silo_profile_id, name, description=" ")
          begin
            profile = Nexpose::SiloProfile.new
            profile.id = silo_profile_id
            profile.name = name
            profile.description = description
            profile.all_licensed_modules = true
            profile.all_global_engines = true
            profile.all_global_report_templates = true
            profile.all_global_scan_templates = true
            save_rv = profile.save(@nsc)
          rescue Exception => e
            save_rv = nil
          end
          save_rv
      end

      # def delete(id)
      #   begin
      #     @nsc.delete_silo_profile(id)
      #   rescue Exception => e
          
      #   end
      # end

  end

    class Silo < NexposeBase

      def list
        silos = @nsc.silos
        rv = Array.new
        for silo in silos
          dict = Hash.new
          dict["id"] = silo.id
          dict["name"] = silo.name
          dict["description"] = silo.description
          dict["profile_id"] = silo.profile_id
          dict["assets"] = silo.assets
          dict["max_assets"] = silo.max_assets
          dict["max_hosted_assets"] = silo.max_hosted_assets
          dict["users"] = silo.users
          dict["max_users"] = silo.max_users
          rv.push(dict)
        end
        rv
      end

      def create(silo_id, name, profile_id, description=" ")
        begin
          silo = Nexpose::Silo.new
          silo.id = silo_id
          silo.name = name
          silo.profile_id = profile_id
          silo.max_assets = 10000
          silo.max_users = 5
          silo.description = description
          _silo = silo.save(@nsc)
        rescue Exception => e
          _silo = nil
        end
        _silo
      end


    end


end
