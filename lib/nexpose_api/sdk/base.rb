module NexposeApi

    class Settings < Settingslogic
      source File.expand_path('../../../config.yaml', File.dirname(__FILE__))
    end

    class NexposeBase

      def initialize
        begin
            @nsc = Nexpose::Connection.new(Settings.host.to_s, Settings.user.to_s, Settings.pass.to_s)
            @nsc.login
        rescue ::Nexpose::APIError => e
            $stderr.puts ("Connection failed: #{e.reason}")
            exit(1)
        end
      end

    end

end
