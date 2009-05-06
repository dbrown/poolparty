module PoolParty    
  class GitResource
    
    plugin :git do
      def loaded(*args)
        has_package(:name => "git-core")
      end
    end
    
    plugin :git_repo do
      default_options(
        :dir => nil,
        :owner => nil,
        :creates_dir => nil
      )
      
      def loaded(opts={}, &block)
        raise(StandardError.new("You must include a directory for the git repos set by to")) unless dir?
        # opts.has_key?(:at) ? at(opts.delete(:at)) : raise(Exception.new("You must include a directory for the git repos set by :at"))
        # opts.has_key?(:source) ? git_repos(opts.delete(:source) || opts[:name]) : raise(Exception.new("You must include the git source set by :source"))
        puts "name in loaded git_repos: #{name}"
        has_package("git-core")
        has_git_repository
      end

      def has_git_repository
        
        has_directory(::File.dirname(dir))
        has_directory(:name => "#{dir}", :requires => get_directory("#{::File.dirname(dir)}"))
        
        has_exec(:name => "git-#{name}", :requires => [get_directory("#{dir}"), get_package("git-core")], :creates => creates_dir ) do
          # Cloud, GitRepos, Exec
          command parent.requires_user? ? "git clone #{requires_user}@#{name} #{dir}" : "cd #{dir} && git clone #{name}"
          cwd "#{dir if dir}"          
        end
        has_exec(:name => "update-#{name}", :cwd => ::File.dirname( creates_dir )) do          
          command "git pull"
        end
        
        if owner?
          has_exec(:name => "chown-#{name}", :cwd => ::File.dirname( creates_dir )) do
            command "chown #{owner} * -R"
          end
        end
        
        if deploy_key?
          raise Exception.new("Cannot find the git deploy key: #{deploy_key}") unless ::File.file?(::File.expand_path(deploy_key))
          ::Suitcase::Zipper.add(::File.expand_path(deploy_key), "keys")
          PoolParty::Provision::DrConfigure.class_commands << "cp -f /var/poolparty/dr_configure/keys/* ~/.ssh"
        end
        
      end
      
      def to(dir)
        dsl_option :dir, dir
      end
      
      def creates_dir
        puts "name in creates_dir: #{name}"
        "#{::File.join( dir, ::File.basename(name, ::File.extname(name)) )}/.git"
      end
      
    end
    
  end
end