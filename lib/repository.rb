class GL::Repository
  include Grit

  def self.create(attributes)
    Repo.init_bare GL.repo_file(attributes[:id])
  end

  def self.delete(id)
    FileUtils.rm_r GL.repo_file(id)
  end

  def self.find(id)
    Repo.new GL.repo_file(id)
  end

  def self.exists?(id)
    File.exists? GL.repo_file(id)
  end
end
