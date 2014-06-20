module Ruboty
  module Handlers
    class Lgtm < Base
      on /lgtm( me)? ?(?<keyword>.+)?/, name: 'lgtm', description: 'Generate lgtm image matching with the keyword'

      env :LGTM_ENDPOINT, "LGTM server endpoint (default: http://lgtm.herokuapp.com)", optional: true

      def lgtm(message = {})
        keyword = message[:keyword] || 'lgtm'
        url = generate(keyword)

        if url
          message.reply(url)
        end
      end

      private

      def generate(query)
        Ruboty::Lgtm::Client.new(query: query, endpoint: ENV["LGTM_ENDPOINT"]).generate
      end
    end
  end
end
