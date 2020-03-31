require 'opener/coreferences/base'
require 'slop'
require 'nokogiri'

require_relative 'coreference/version'
require_relative 'coreference/cli'

module Opener
  class Coreference
    attr_reader :options

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args => [],
    }.freeze

    ##
    # @param [Hash] options
    #
    # @option options [Array] :args Collection of arbitrary arguments to pass
    #  to the underlying kernels.
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Processes the input KAF document and returns a new KAF document containing
    # the results.
    #
    # @param [String] input
    # @return [String]
    #
    def run(input)
      language = language_from_kaf(input)
      args     = options[:args].dup

      if language and language_constant_defined?(language)
        kernel = language.new(:args => args)
      else
        kernel = Coreferences::Base.new(:args => args, :language => language)
      end

      stdout, stderr, process = kernel.run(input)

      raise stderr unless process.success?

      return stdout
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

    ##
    # @param [String] input
    # @return [String]
    #
    def language_from_kaf(input)
      document = Nokogiri::XML(input)
      language = document.xpath('NAF/@xml:lang')[0]

      return language ? language.to_s : nil
    end
  end # Coreference
end # Opener
