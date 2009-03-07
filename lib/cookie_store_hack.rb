class CGI::Session::CookieStore
  alias original_read_cookie read_cookie

  def read_cookie
    # use the real cookie if we can
    env = @session.cgi.env_table
    cookie = original_read_cookie
    unless cookie
      m = /&?#{@cookie_options["name"]}=([^&$]+)/.match(env['QUERY_STRING'])
      cookie = m[1] unless m.nil?
    end
    cookie
  end
end
