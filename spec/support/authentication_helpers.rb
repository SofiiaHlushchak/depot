# frozen_string_literal: true

module AuthenticationHelpers
  def login_as
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(FactoryBot.create(:user))
      allow_any_instance_of(ApplicationController).to receive(:authorize).and_return(true)
    end
  end
end
