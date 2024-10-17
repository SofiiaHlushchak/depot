# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "callbacks" do
    context "when deleting users" do
      let!(:user1) { create(:user) }

      it "raises an error if the last user is being deleted" do
        expect { user1.destroy }.to raise_error(User::Error, "Can't delete last user")
      end

      it "allows deletion if there are other users" do
        user2 = create(:user)
        expect { user2.destroy }.to change { User.count }.by(-1)
      end

      it "does not raise an error when deleting multiple users" do
        user2 = create(:user)
        create(:user)

        expect { user2.destroy }.to change { User.count }.by(-1)  # Should succeed
        expect { user1.destroy }.to change { User.count }.by(-1)  # Should succeed now that user1 has been removed
      end
    end
  end
end
