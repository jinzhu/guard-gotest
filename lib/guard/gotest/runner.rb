module Guard
  class Gotest
    class Runner
      attr_accessor :options

      def initialize(options = {})
        @options = {
          :env          => nil,
          :notification => true,
          :sleep_time   => 1
        }.merge(options)
      end

      def run(paths, options = {})
        return false if paths.empty?

        message = options[:message] || "Running: #{paths.join(' ')}"
        UI.info(message, :reset => true)

        options = @options.merge(options)

        puts gotest_command(paths, options)
        success = system(gotest_command(paths, options))

        if @options[:notification] && !success
          Notifier.notify('Failed', :title => 'Gotest results', :image => :failed, :priority => 2)
        end

        success
      end

      def stop
        ps_go_pid.each do |pid|
          system %{kill -KILL #{pid}}
        end
        while ps_go_pid.count > 0
          sleep @options[:sleep_time].to_f || 1
        end
      end

      private

      def ps_go_pid
        `ps aux | awk '/a.out/&&!/awk/{print $2;}'`.split("\n").map { |pid| pid.to_i }
      end

      def gotest_command(paths, options)
        cmd_parts = []
        dirs = paths.map{ |path| File.dirname(path) }.uniq
        dirs.each do |dir|
          cmd_parts << "cd #{dir}"
          cmd_parts << '&&'
          cmd_parts << environment_variables
          cmd_parts << gotest_executable
          cmd_parts << ';'
        end
        cmd_parts.compact.join(' ')
      end

      def gotest_executable
        'go test'
      end

      def environment_variables
        return if @options[:env].nil?
        'export ' + @options[:env].map {|key, value| "#{key}=#{value}"}.join(' ') + ';'
      end
    end
  end
end
