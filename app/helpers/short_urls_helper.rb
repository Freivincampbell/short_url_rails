# frozen_string_literal: true

# Short Urls Helper using https://gist.github.com/zumbojo/1073996#file-bijective-rb
module ShortUrlsHelper
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  def self.url_encode(idx)
    return CHARACTERS[0] if idx.zero?

    str = ''
    base = CHARACTERS.length

    while idx.positive?
      str << CHARACTERS[idx.modulo(base)]
      idx /= base
    end

    str.reverse
  end

  def self.url_decode(str)
    i = 0
    base = CHARACTERS.length
    str.each_char { |c| i = i * base + CHARACTERS.index(c) }
    i
  end
end
