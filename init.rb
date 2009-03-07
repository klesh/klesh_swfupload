# plugin init file for rails
# this file will be picked up by rails automatically and

require 'cookie_store_hack'
require 'swfupload_helper'

ActionView::Base.send(:include, SWFUploadHelper)
