module NexposeApi

    class NexposeSDK

      attr_reader :sys
      attr_reader :sitesummary
      attr_reader :usersummary
      attr_reader :site
      attr_reader :scan
      attr_reader :silo
      attr_reader :siloprofile

      def initialize
        @site = Sites.new
        @sitesummary = SiteSummary.new
        @usersummary = UserSummary.new
        @scan = Scan.new
        @sys = SysInfo.new
        @siloprofile = SiloProfile.new
        @silo = Silo.new
      end
    end

end
