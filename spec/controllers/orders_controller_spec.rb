require 'rails_helper'

describe OrdersController do

  describe "POST payment" do
    it "redirects to checkout confirmation path" do
      post :payment, locale: :en
      expect(response).to redirect_to(checkout_confirmation_path)
    end
  end

  describe "GET checkout" do
    before(:each) do
      get :checkout, locale: :en
    end

    it "render checkout view " do
      expect(response).to render_template(:checkout)
    end

    it "assigns order" do
      assigns(:order).should_not be_nil
    end
  end
end
