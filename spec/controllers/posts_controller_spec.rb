require 'rails_helper'
require 'pg'

RSpec.describe PostsController, type: :controller do
  before(:each) do
    user_password = '1234567890'
    unless User.find_by(email: 'john@forster.com')
      User.create(
        name: 'John', email: 'john@forster.com',
        password: user_password, password_confirmation: user_password
      )
    end
    @controller = SessionsController.new
    post :create, params: {
      session: { email: 'john@forster.com', password: user_password }
    }
    @controller = PostsController.new
  end

  describe "GET /new " do
    it "responds with 200" do
      get :new
      expect(response).to have_http_status(200)
    end

    it 'calls Post.new' do
      expect(Post).to receive(:new)
      get :new
    end
  end

  describe "POST /" do
    it "responds with 200" do
      post :create, params: { post: { message: "Hello, world!" } }
      expect(response).to redirect_to(posts_url)
    end

    it "creates a post" do
      expect(Post).to receive(:create)
      post :create, params: { post: { message: "Hello, world!" } }
    end
  end

  describe "GET /" do
    it "responds with 200" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
