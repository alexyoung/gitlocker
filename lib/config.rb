module GL
  UserConfig = YAML.load(File.read('config.yml')) rescue {}
  Config     = OpenStruct.new({
    :path => UserConfig['path'] || 'tmp/'
  })
end
