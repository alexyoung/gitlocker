%w(config repository document).each do |file|
  require File.join(File.dirname(File.expand_path(__FILE__)), file)
end

module GL
  def self.repo_file(name)
    File.join(GL::Config.path, name + '.git')
  end
end
