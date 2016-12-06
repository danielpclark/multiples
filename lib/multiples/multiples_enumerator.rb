module Multiples
  module MultiplesEnumGenerator
    class << self
      def new a, b
        @a, @b = (a..Float::INFINITY).step(a), (b..Float::INFINITY).step(b)
        @palindrome_length = a + b - 1
        @stack = [[@a.peek, @b.peek].min.to_i]
        send :build_palindrome
        return MultiplesEnumerator.new(@stack)
      end

      private
      def build_palindrome
        until @stack.length == @palindrome_length
          value = step

          # Palindrome completed! Even numbers used!
          break if value.zero? 

          @stack << value
        end
      end

      def step
        val = [@a.peek, @b.peek].max - [@a.peek, @b.peek].min
        if val > @stack[0]
          val = @stack[0]
        end
        h = {@a.peek => @a, @b.peek => @b}
        h[h.keys.min].next
        val.to_i
      end
    end
  end

  class MultiplesEnumerator
    attr_reader :palindrome, :phase
    def initialize palindrome
      @base = 0
      @palindrome = palindrome
      @phase = 0
    end

    def current
      @base
    end

    def reset!
      @base = 0
      @phase = 0
    end

    def each
      loop do
        send :next
        yield @base
      end
    end

    def lazy
      Enumerator::Lazy.new(self) do |yielder, *vals|
        yielder.<<(*vals)
      end
    end

    def next
      @base += progress_phase
    end

    def prev
      @base -= regress_phase
    end

    private
    def progress_phase
      val = @palindrome[@phase]
      @phase += 1
      @phase = 0 if @phase > @palindrome.length - 1
      val
    end

    def regress_phase
      @phase -= 1
      @phase = @palindrome.length - 1 if @phase < 0
      @palindrome[@phase]
    end
  end
end
