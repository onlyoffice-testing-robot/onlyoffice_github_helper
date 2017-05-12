require 'octokit'
require 'yaml'
require_relative 'github_client/branches'

module OnlyofficeGithubHelper
  # Basic github client
  class GithubClient
    include Branches

    def initialize(config_file: 'config.yml')
      init_github_access(config_file)
      Octokit.configure do |c|
        c.login = @user_name
        c.password = @user_password
      end
    end

    private

    def init_github_access(config)
      @user_name = ENV['GITHUB_USER_NAME']
      @user_password = ENV['GITHUB_USER_PASSWORD']
      return unless File.exist?(config)
      @config = YAML.load_file(config)
      @user_name = @config['github_user']
      @user_password = @config['github_user_password']
    end
  end
end
