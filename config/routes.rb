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

    end

  end

end
