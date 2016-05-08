module NexposeApi

    class UserSummary < NexposeBase

      def list_users
        users = @nsc.list_users
        rv = Array.new
        for user in users
          dict = Hash.new
          dict["id"] = user.id
          dict["name"] = user.name
          dict["full_name"] = user.full_name
          dict["email"] = user.email
          dict["site_count"] = user.site_count
          dict["group_count"] = user.group_count
          dict["is_admin"] = user.is_admin
          dict["is_disabled"] = user.is_disabled
          dict["is_locked"] = user.is_locked
          dict["auth_source"] = user.auth_source
          dict["auth_module"] = user.auth_module
          rv.push(dict)
        end
        rv
      end
    end

    # class Users < NexposeBase
    #   def get_site(site_id)
    #     Nexpose::Site.load(@nsc, site_id).to_h
    #   end
    # end


end
