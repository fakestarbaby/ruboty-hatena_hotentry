require "nokogiri"
require "open-uri"

module Ruboty
  module HatenaHotentry
    class Client
      URL_FOR_ALL = "http://b.hatena.ne.jp/hotentry?mode=rss&sort=popular"
      URL_FOR_CATEGORY = "http://b.hatena.ne.jp/hotentry/%{category}.rss&sort=popular"

      NAMESPACES = {
        "rss" => "http://purl.org/rss/1.0/",
        "rdf" => "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "content" => "http://purl.org/rss/1.0/modules/content/",
        "dc" => "http://purl.org/dc/elements/1.1/",
        "feedburner" => "http://rssnamespace.org/feedburner/ext/1.0",
        "hatena" => "http://www.hatena.ne.jp/info/xmlns#"
      }

      attr_reader :options

      def initialize(options)
        @options = options
      end

      def get
        begin
          url = url(@options[:category])
          parse(open(url).read)
        rescue => exception
          Ruboty.logger.error("Error: #{self}##{__method__} - #{exception}")
          nil
        end
      end

      private

      def url(category)
        category == "all" ? URL_FOR_ALL : sprintf(URL_FOR_CATEGORY, category: category)
      end

      def namespaces
        NAMESPACES
      end

      def parse(doc)
        [].tap do |arr|
          Nokogiri::XML(doc).xpath('//xmlns:item').each do |node|
            arr << {
              title: node.xpath('rss:title', namespaces).text,
              link: node.xpath('rss:link', namespaces).text,
              bookmarkcount: node.xpath('hatena:bookmarkcount', namespaces).text
            }
          end
        end
      end
    end
  end
end
