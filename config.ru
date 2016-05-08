$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'nexpose_api'
# sets the view directory correctly

map('/') { run NexposeApi::Index }
map('/sys') { run NexposeApi::SysHandlers }
map('/site') { run NexposeApi::SiteHandlers }
map('/user') { run NexposeApi::UserHandlers }
map('/scan') { run NexposeApi::ScanHandlers }
map('/silo') { run NexposeApi::SiloHandlers }