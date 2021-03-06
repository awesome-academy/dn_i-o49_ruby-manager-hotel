require "rails_helper"

RSpec.describe "Users", type: :request do
  include Devise::TestHelpers
  describe "ACTION INDEX" do
    context "GET /users" do
      let (:users) { create_list(:user, Settings.digit.length_4) }
      before { get "/users" }

      it "render index" do 
        expect(response).to render_template(:index)
      end

      it "return users" do
        expect(assigns(:users)).to match_array(users)
      end
    end
  end

  describe "ACTION SHOW" do
    context "GET /users/:valid_id" do 
      let (:user) { create(:user) }

      before { get "/users/%{id}" % { id: user.id } }

      it "render show" do
        expect(response).to render_template(:show)
      end

      it "return user" do
        expect(assigns(:user)).to eq(user)
      end
    end

    context "GET /users/:invalid_id" do
      before { get "/users/-1" } 

      it "redirect new_user" do
        expect(response).to redirect_to(new_user_session_path)
      end

      it "flash warning" do
        content = I18n.t("controllers.users_controller.user_not_found")
        expect(flash[:warning]).to eq(content)
      end
    end
  end
end
