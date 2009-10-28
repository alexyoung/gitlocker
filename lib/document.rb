class GL::Document
  include Grit

  attr_accessor :attributes

  def initialize(attributes)
    @attributes = attributes.symbolize_keys
    @repo = GL::Repository.find @attributes[:repo_id]
  end

  def save
    index = @repo.index
    last_commit = @repo.log.first rescue nil
    tree_id = last_commit.tree.id rescue nil
    last_commit_id = last_commit.id if last_commit
    
    index.read_tree(tree_id) if tree_id

    index.add @attributes[:id], @attributes[:data]
    index.commit "new version of #{@attributes[:id]}", last_commit_id 
  end

  def data
    @repo.tree('master', [@attributes[:id]]).contents.first.data
  end

  def versions
    @repo.log('master', @attributes[:id]).size
  end

  def data_for_version
    version = @attributes[:version]
    path = @attributes[:id]
    version_count = versions
    if version_count == 0
      data
    elsif version
      version = version.to_i
      version_index = version_count - version.to_i - 1
      version_index = 0 if version_index < 0
      @repo.log('master', path)[version_index].
        tree('master').
        contents.find { |b| b.name == path }.data
    end
  end

  # FIXME: I don't know how to remove files from indexes
  #        without removing all of them
  def destroy
    @attributes[:data] = ''
    save
  end

  def self.create(attributes)
    document = new(attributes)
    document.save
  end

  def self.update(attributes)
    document = new(attributes)
    document.save
  end

  def self.find(attributes)
    document = new(attributes)
    document.data
  end

  def self.version(attributes)
    document = new(attributes)
    document.data_for_version
  end

  def self.revert(attributes)
    document = new(attributes)
    document.attributes[:data] = document.data_for_version
    document.save
  end

  def self.delete(attributes)
    document = new(attributes)
    document.destroy
  end
end
