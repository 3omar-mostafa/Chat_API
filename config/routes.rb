Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope "api/v1", defaults: {format: :json} do

    scope "applications" do

      get "/" => "chat_applications#index"
      post "/" => "chat_applications#create"
      get "/:token" => "chat_applications#show"
      put "/:token" => "chat_applications#update"
      patch "/:token" => "chat_applications#update"
      delete "/:token" => "chat_applications#destroy"

      scope "/:token/chats" do

        get "/" => "chats#index"
        post "/" => "chats#create"
        get "/:chat_id" => "chats#show"
        put "/:chat_id" => "chats#update"
        patch "/:chat_id" => "chats#update"
        delete "/:chat_id" => "chats#destroy"

        scope "/:chat_id/messages" do
          get "/" => "messages#index"
          post "/" => "messages#create"
          get "/:message_id" => "messages#show"
          put "/:message_id" => "messages#update"
          patch "/:message_id" => "messages#update"
          delete "/:message_id" => "messages#destroy"
        end

      end
    end

  end

end
