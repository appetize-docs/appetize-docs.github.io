
module Jekyll

  class SwaggerTag < Liquid::Tag
    @spec = nil

    def initialize(tag_name, markup, tokens)
      super
      @spec = markup.strip
    end

    def render(context)
      spec = Liquid::Template.parse(@spec).render(context)
      %Q{<div id="swagger-ui"/><script>window.onload = () => {loadSwaggerUi("#{spec}", "swagger-ui")};</script>}
    end
  end
end

Liquid::Template.register_tag('swagger', Jekyll::SwaggerTag)
