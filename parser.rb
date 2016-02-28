require 'nokogiri'
require 'open-uri'

class Parser
  def initialize(url)
    charset = nil
    html = open(url) do |file|
      charset = file.charset
      file.read
    end
    @doc = Nokogiri::HTML.parse(html, nil, charset).freeze
  end

  def retrieve_as_text(xpath)
    @doc.xpath(xpath).text
  end

  def retrieve_attribute(xpath, attribute)
    @doc.xpath(xpath).attribute(attribute).value
  end

  def retrieve_with_post_processing(xpath, post_processing)
    post_processing.call(@doc.xpath(xpath))
  end
end
