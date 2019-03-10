describe "a Mongoid Document" do

  it "has new class methods :document_fields, :document_embeds, :document_relations" do
    expect(Gatekeeper::Model.respond_to? :document_fields).to be true
    expect(Gatekeeper::Model.respond_to? :document_embeds).to be true
    expect(Gatekeeper::Model.respond_to? :document_relations).to be true

    expect(Gatekeeper::Model.document_fields).to eq [ :string_field, :number_field, :date_field ]
    expect(Gatekeeper::Model.document_embeds).to eq [ :embedded_models ]
    expect(Gatekeeper::Model.document_relations).to eq [ :related_models ]
  end

  it "has new class method :allowed_info" do
    expect(Gatekeeper::Model.respond_to? :allowed_info).to be true
  end

end
