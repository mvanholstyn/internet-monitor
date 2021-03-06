# https://github.com/bjoernalbers/faxomat/tree/master/lib/capistrano/templates/launchd
namespace :launchd do
  def launchd_dir
    @launchd_dir ||= Pathname.new('~/Library/LaunchAgents')
  end

  def plist_for(service)
    launchd_dir.join("com.lotswholetime.#{service}.plist")
  end

  def template(from, to)
    template_path = File.expand_path("../../../launchd/#{from}.plist.erb", __FILE__)
    template = ERB.new(File.new(template_path).read).result(binding)
    upload! StringIO.new(template), to
  end

  desc 'Setup Launch Daemons'
  task :setup do
    on roles(:app) do
      fetch(:services).each do |service|
        tmp_dir = Pathname.new('/tmp')
        tmp_filename = tmp_dir.join(File.basename(plist_for(service)))
        template service, tmp_filename
        execute :mv, tmp_filename, plist_for(service)
      end
    end
  end

  desc 'Load Launch Daemons'
  task :load => :setup do
    on roles(:app) do
      fetch(:services).each do |service|
        execute :launchctl, 'load -w', plist_for(service)
      end
    end
  end

  desc 'Unload Launch Daemons'
  task :unload => :setup do
    on roles(:app) do
      fetch(:services).each do |service|
        execute :launchctl, 'unload -w', plist_for(service)
      end
    end
  end

  desc 'Reload Launch Daemons'
  task :reload do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'launchd:unload'
      invoke 'launchd:load'
    end
  end
end
