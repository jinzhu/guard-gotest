require 'guard'
require 'guard/guard'
require 'guard/gotest/version'

module Guard
  class Gotest < Guard
    autoload :Runner, 'guard/gotest/runner'

    attr_accessor :runner

    def initialize(watchers = [], options = {})
      super
      @options = {
        :run_all => {}
      }.merge(options)

      @runner = Runner.new(@options)
    end

    def start
      UI.info "Guard::Gotest is running"
      run_all if @options[:all_on_start]
    end

    def stop
      @runner.stop
      UI.info "Stopping Guard::Gotest"
    end

    def run_all
      # TODO
    end

    def run_on_changes(paths)
      @runner.run(paths)
    end
  end
end
