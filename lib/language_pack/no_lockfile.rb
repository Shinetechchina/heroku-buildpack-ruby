require "language_pack"
require "language_pack/base"

class LanguagePack::NoLockfile < LanguagePack::Base
  def self.use?
    if !File.exists?("Gemfile.lock")
      choose_app
    end
    !File.exists?("Gemfile.lock")
  end

  def self.choose_app
    site_root =  ENV['WEBSITE_ROOT'] || LanguagePack::ShellHelpers.user_env_hash['WEBSITE_ROOT']
    site_root_path = "#{ARGV[0]}/#{site_root}"
    if site_root.to_s.size > 0 && File.exists?(site_root_path)
      puts "Choose #{site_root} ..."
      `mv #{site_root_path}/* #{build_path}`
    else
      raise StandardError, "Please set heroku config 'WEBSITE_ROOT' or WEBSITE_ROOT is error"
    end
  end

  def name
    "Ruby/NoLockfile"
  end

  def compile
    error "Gemfile.lock required. Please check it in."
  end
end
