require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "should return all posts in test DB" do
      user = User.create!(
        name: "ted dundy",
        email: "teddundy@gmail.com",
        password: "password"
      )

      Post.create!(
        title: "This is the title",
        body: "This is the body",
        image: "This is the image",
        user_id: user.id
      )

      get "/api/posts"
      posts = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(posts.length).to eq(1)
    end
  end

  describe "GET /posts" do
    it "should return all posts in test DB" do

      User.create!(
        name: "tedd ddundy",
        email: "teddddundy@gmail.com",
        password: "passwordd"
      )
      
      user = User.create!(
        name: "ted dundy",
        email: "teddundy@gmail.com",
        password: "password"
      )

      Post.create!(
        title: "This is the title",
        body: "This is the body",
        image: "This is the image",
        user_id: user.id
      )

      get "/api/posts"
      posts = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(posts.length).to eq(1)
      expect(posts.first["user_id"]).to eq(user.id)
    end
  end

  describe "GET /posts/:id" do
    it "should return the specified post from the DB" do

      user = User.create!(
        name: "ted dundy",
        email: "teddundy@gmail.com",
        password: "password"
      )

      new_post = Post.create!(
        title: "This is the title",
        body: "This is the body",
        image: "This is the image",
        user_id: user.id
      )

      get "/api/posts/#{new_post.id}"
      response_post = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response_post["title"]).to eq(new_post.title)
      expect(response_post["body"]).to eq(new_post.body)
      expect(response_post["user_id"]).to eq(new_post.user_id)
      expect(response_post["image"]).to eq(new_post.image)
    end
  end

  describe "POST /posts" do
    it "create a new post in the DB" do

      user = User.create!(
        name: "ted dundy",
        email: "teddunssasasadsdsddy@gmail.com",
        password: "password"
      )

      jwt = JWT.encode(
        {
          user: user.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        "random", # the secret key
        'HS256' # the encryption algorithm
      )

      post "/api/posts", params: {
        title: "Thissss is the title",
        body: "Thissss is the body",
        image: "Thissss is the image",
        user_id: user.id
      },
      headers: {"Authorization" => "Bearer #{jwt}"}

      possst = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(possst["title"]).to eq("Thissss is the title")
    end
  end
end
