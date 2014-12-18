module Ruboty
  module Handlers
    class HatenaHotentry < Base
      ARTICLE_FORMAT = "%{title} (%{bookmarkcount}ブクマ)\n%{link}\n"

      on /hotentry( me)? (?<keyword>all|social|economics|life|knowledge|it|fun|entertainment|game)/,
      name: "hotentry",
      description: "Reference Hotentry from HatenaBookmark"

      def hotentry(message)
        hotentry = ref(message[:keyword])
        message.reply(layout(hotentry)) unless hotentry.nil?
      end

      private

      def ref(category)
        Ruboty::HatenaHotentry::Client.new(category: category).get
      end

      def layout(hotentry)
        String.new.tap do |s|
          s << "```\n"
          s << hotentry.collect { |v| sprintf(ARTICLE_FORMAT, v) }.join("\n")
          s << "```"
        end
      end
    end
  end
end
