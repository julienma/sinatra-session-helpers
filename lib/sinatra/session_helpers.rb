require 'sinatra/base'
require "sinatra/session_helpers/version"

module Sinatra
  module SessionHelpers

    module Helpers
      # After this method is called, calls to #session? will return +true+.
      def session_start!
        session[:authorized] = true
      end

      # After this method is called, calls to #session? will return +false+. If you want to keep the old session data around in the cookie for some reason, set +destroy+ to +false+.
      def session_end!(destroy=true)
        if destroy
          session.clear
        else
          session[:authorized] = false
        end
      end

      # Returns +true+ if the current session is valid, +false+ otherwise.
      def session?
        !! session[:authorized]
      end

      # Redirects the client to the URL given in the +session_fail+ setting if #session? returns +false+.
      def session!
        redirect(settings.session_fail) unless session? || settings.session_fail == request.path_info
      end
    end

    def self.registered(app)
      app.helpers SessionHelpers::Helpers

      # This should be set to the redirect URL the client will be sent to if the session is not valid.
      app.set :session_fail, '/login'
    end
  end

  register SessionHelpers
end
