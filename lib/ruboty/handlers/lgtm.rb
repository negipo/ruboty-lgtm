module Ruboty
  module Handlers
    class Lgtm < Base
      on /lgtm( me)? ?(?<keyword>.+)?/, name: 'lgtm', description: 'Generate lgtm image matching with the keyword'

      def lgtm(message = {})
        keyword = message[:keyword] || 'lgtm'
        url = generate(keyword)

        if url
          message.reply(url)
        end
      end

      private

      def generate(query)
        Ruboty::Lgtm::Client.new(query: query).generate
      end
    end
  end
end
