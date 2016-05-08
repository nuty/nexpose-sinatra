module NexposeApi

    class SysInfo < NexposeBase
      def get_ver
        @nsc.console_command("ver")
      end
      
      def get_info
        @nsc.system_information
      end
    end

end
