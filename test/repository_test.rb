require 'test_helper'

context 'Repositories' do
  setup { @app = Sinatra::Application; @repo_id = '1' }

  context 'create' do
    setup { post '/repositories', { :repository => { :id => @repo_id } } }
    asserts_response_status 200
  end

  context 'Documents' do
    setup { @document_id = '1'; @data = 'this is a test' }

    context 'create' do
      setup { post "/repositories/#{@repo_id}/documents",
                   :document => { :id => @document_id, :data => @data } }
      asserts_response_status 200
    end

    context 'find' do
      setup { get "/repositories/#{@repo_id}/documents/#{@document_id}" }
      asserts_response_equals 'this is a test'
    end

    context 'delete' do
      setup { delete "/repositories/#{@repo_id}/documents/#{@document_id}" }
      asserts_response_status 200
    end

    context 'find after delete' do
      setup { get "/repositories/#{@repo_id}/documents/#{@document_id}" }
      asserts_response_equals ''
    end

    context 'get the first version' do
      setup { get "/repositories/#{@repo_id}/documents/#{@document_id}/version/0" }
      asserts_response_equals 'this is a test'
    end

    context 'get the version count' do
      setup { get "/repositories/#{@repo_id}/documents/#{@document_id}/versions" }
      asserts_response_equals '2'
    end

    # Note: This should change when delete actually deletes
    context 'get the updated version' do
      setup { get "/repositories/#{@repo_id}/documents/#{@document_id}/version/1" }
      asserts_response_equals ''
    end

    context 'revert' do
      setup { get "/repositories/#{@repo_id}/documents/#{@document_id}/revert/0" }
      asserts_response_status 200
    end

    context 'find after revert' do
      setup { get "/repositories/#{@repo_id}/documents/#{@document_id}" }
      asserts_response_equals 'this is a test'
    end
  end

  context 'delete' do
    setup { delete "/repositories/#{@repo_id}" }
    asserts_response_status 200
  end
end
