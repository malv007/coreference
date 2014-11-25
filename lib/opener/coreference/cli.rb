module Opener
  class Coreference
    ##
    # CLI wrapper around {Opener::Coreference} using Slop.
    #
    # @!attribute [r] parser
    #  @return [Slop]
    #
    class CLI
      attr_reader :parser

      def initialize
        @parser = configure_slop
      end

      ##
      # @param [Array] argv
      #
      def run(argv = ARGV)
        parser.parse(argv)
      end

      ##
      # @return [Slop]
      #
      def configure_slop
        return Slop.new(:strict => false, :indent => 2, :help => true) do
          banner 'Usage: coreference [OPTIONS]'

          separator <<-EOF.chomp

About:

    Coreference resolution for various languages such as Dutch and English.
    This command reads input from STDIN.

Example:

    cat some_file.kaf | coreference
          EOF

          separator "\nOptions:\n"

          on :v, :version, 'Shows the current version' do
            abort "coreference v#{VERSION} on #{RUBY_DESCRIPTION}"
          end

          run do |opts, args|
            coref = Coreference.new(:args => args)

            input = STDIN.tty? ? nil : STDIN.read

            puts coref.run(input)
          end
        end
      end
    end # CLI
  end # Coreference
end # Opener
