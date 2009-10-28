%w(config repository document).each do |file|
  require File.join(File.dirname(File.expand_path(__FILE__)), file)
end

class Hash
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end
end

module GL
  def self.repo_file(name)
    File.join(GL::Config.path, name + '.git')
  end
end
