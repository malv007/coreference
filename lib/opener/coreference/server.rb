require 'sinatra/base'
require 'opener/webservice'
require 'httpclient'

module Opener
  class Ner
    ##
    # Coreference server powered by Sinatra.
    #
    class Server < Webservice
      set :views, File.expand_path('../views', __FILE__)
      text_processor Coreference
      accepted_params :input
    end # Server
  end # Ner
end # Opener

