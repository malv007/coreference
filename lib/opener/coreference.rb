require 'optparse'
require 'opener/coreferences/base'
require 'nokogiri'

require_relative 'coreference/version'
require_relative 'coreference/cli'
require_relative 'coreference/error_layer'

module Opener
  class Coreference
    attr_reader :options

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args     => [],
    }.freeze

    ##
    # @param [Hash] options
    #
    # @option options [Array] :args Collection of arbitrary arguments to pass
    #  to the underlying kernels.
    # @option options [String] :language The language to use.
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Processes the input and returns an array containing the output of STDOUT,
    # STDERR and an object containing process information.
    #
    # @param [String] input
    # @return [Array]
    #
    def run(input)
      begin
        language = language_from_kaf(input)
        args = options[:args].dup

        if language_constant_defined?(language)
          kernel = language.new(:args => args)
        else
          kernel = Coreferences::Base.new(:args => args, :language => language)
        end
        stdout, stderr, process = kernel.run(input)
        raise stderr unless process.success?
        return stdout
        
      rescue Exception => error
        return ErrorLayer.new(input, error.message, self.class).add
      end
    end

    protected

    ##
    # Returns `true` if the current language has a dedicated kernel class.
    #
    # @return [TrueClass|FalseClass]
    #
    def language_constant_defined?(language)
      return Coreferences.const_defined?(language.upcase)
    end

    ##
    # @return [Class]
    #
    def language_constant
      return Coreferences.const_get(language_constant_name)
    end

    def language_from_kaf(input)
      reader = Nokogiri::XML::Reader(input)

      return reader.read.lang
    end
  end
end
