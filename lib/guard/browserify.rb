require "guard"
require "guard/guard"
require "guard/browserify/version"

module Guard

  class Browserify < Guard

    @@pattern = /\/(vendor|lib)\//

    def start
      UI.info "Guard::Browserify: starting up"
      run_all
    end

    def fetch_paths
      patterns = watchers.map { |w| w.pattern }
      files = Dir.glob('**/*.*')
      paths = []
      files.each do |file|
        patterns.each do |pattern|
          paths << file if file.match(Regexp.new(pattern))
        end
      end
      paths.delete_if {|p| @@pattern.match p }
    end

    def run_all
      UI.info "Guard::Browserify: compiling all files"
      run(fetch_paths)
    end

    def from_lib(paths)
      !paths.grep(@@pattern).empty?
    end

    def run_on_changes(paths)
      if from_lib(paths)
        run_all
      else
        run(paths)
      end
    end

    def run(paths)
      paths.each {|p|
        dest = p.gsub(/^assets\/scripts(.+\.js)/, 'public/js\1')
        if p == dest
          UI.info "Guard::Less: Skipping #{p} since the output would overwrite the original file"
        else
          UI.info "Guard::Browserify: #{p} -> #{dest}"
          FileUtils.mkdir_p(File.expand_path(dest.split('/')[0..-2].join('/')))
          IO.popen("browserify #{p} -o #{dest}") {|io|
            unless io.read.empty?
              UI.error "Guard::Browserify: #{io.read}"
            end
          }
        end
      }
    end

  end

end
