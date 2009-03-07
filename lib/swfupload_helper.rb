module SWFUploadHelper
  def swfupload(name, upload_url, options=nil)
    raise ArgumentError, "expect upload_url for url_for method" unless upload_url.is_a? Hash
    options = {
      :button_placeholder_id => "#{name}_place_holder",
      :file_dialog_complete_handler => 'function(file_count){if (file_count) this.startUpload();}'
    }.merge!(options)
    options[:upload_url] = url_for(upload_url.merge(
      request.session_options[:session_key] => session.session_id,
      :escape => false
    ))
    options[:post_params] = options[:post_params] === Hash ? options[:post_params].dup : {}
    options[:post_params].merge!(request_forgery_protection_token => form_authenticity_token)
    options[:flash_url] = url_for('/swfs/swfupload.swf')
    @template.content_tag(:span, nil, :id => options[:button_placeholder_id]) <<
    @template.content_tag(:script, "var #{name} = new SWFUpload(#{swfupload_convert_to_json(options)})", :type => 'text/javascript')
  end

  def swfupload_convert_to_json(data)
    case data
    when Hash
      items = []
      for key, val in data
        key = key.to_s
        val = key =~ /_handler$/ ? val.to_s : swfupload_convert_to_json(val)
        items << "#{key.inspect} : #{val}"
      end
      "{#{items.join(',')}}"
    when Array
      items = []
      for item in data
        items << swfupload_convert_to_json(item)
      end
      "[#{items.join(',')}]"
    else
      data.inspect
    end
  end
end
