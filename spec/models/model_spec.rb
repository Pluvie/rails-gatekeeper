describe "a Gatekeeped Model" do

  context "when it is not configured to bypass" do

    it "shows allowed info based on current user" do
      viewer_user = FactoryBot.create :user, role: :viewer
      editor_user = FactoryBot.create :user, role: :editor
      admin_user = FactoryBot.create :user, role: :admin
      model = FactoryBot.create :model

      expect(model.info(viewer_user).keys).to eq [ :id ]
      expect(model.info(editor_user).keys).to eq ([ :id ] | model.class.document_fields)
      expect(model.info(admin_user).keys).to eq [ :id ]
    end

  end

  context "when it is configured with a bypass on an admin user" do

    before :all do
      Gatekeeper.configure do |config|
        config.bypass_allowed_info = proc do |user|
          user.role == :admin
        end
      end
    end

    it "shows all field and emebed info to an admin user" do
      admin_user = FactoryBot.create :user, role: :admin
      model = FactoryBot.create :model

      expect(model.info(admin_user).keys).to eq ([ :id ] |  model.class.document_fields | model.class.document_embeds)
    end

    context "when it is asked to include a relation" do

      it "shows all info to an admin user" do
        admin_user = FactoryBot.create :user, role: :admin
        model = FactoryBot.create :model

        expect(model.info(admin_user, include: :related_models).keys).to eq ([ :id ] |  model.class.document_all_info)
      end

    end

  end

end
