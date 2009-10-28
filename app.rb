require 'rubygems'
require 'sinatra'
require 'ostruct'
require 'grit'
require 'lib/init'

class Hash
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end
end

enable :logging, :dump_errors

error Grit::NoSuchPathError do
  not_found
end

helpers do
  def create_repo_if_required(repo_id)
    unless GL::Repository.exists? repo_id
      GL::Repository.create :id => repo_id
    end
  end
end

# repositories
post '/repositories' do
  GL::Repository.create params[:repository]
end

delete '/repositories/:id' do
  GL::Repository.delete params[:id]
end

# documents

# pass an ID for the document in the document hash
post '/repositories/:repo_id/documents' do
  create_repo_if_required params[:repo_id]
  GL::Document.create params[:document].merge({ :repo_id => params[:repo_id] })
end

get '/repositories/:repo_id/documents/:id' do
  GL::Document.find(params)
end

get '/repositories/:repo_id/documents/:id/version/:version' do
  GL::Document.version(params)
end

get '/repositories/:repo_id/documents/:id/revert/:version' do
  # replace the newest version with an old one
  GL::Document.revert(params)  
end

get '/repositories/:repo_id/documents/:id/versions' do
  doc = GL::Document.new(params)
  doc.versions.to_s
end

put '/repositories/:repo_id/documents/:id' do
  GL::Document.update(params.merge(params[:document]))
end

delete '/repositories/:repo_id/documents/:id' do
  GL::Document.delete(params)
end

