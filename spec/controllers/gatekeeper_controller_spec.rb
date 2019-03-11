describe "a gatekeeped Controller" do

  before :all do
    @controller = GatekeeperController.new
  end

  it "responds with HTML view if called with browser" do
    get :index
    expect(response).to render_template 'gatekeeper/index.html'

    get :show, params: { id: 'model' }
    expect(response).to render_template 'gatekeeper/show.html'

    get :new
    expect(response).to render_template 'gatekeeper/new.html'

    post :create
    expect(response).to redirect_to model_index_path

    get :edit, params: { id: 'model' }
    expect(response).to render_template 'gatekeeper/edit.html'

    patch :update, params: { id: 'model' }
    expect(response).to redirect_to model_index_path

    delete :destroy, params: { id: 'model' }
    expect(response).to redirect_to model_index_path
  end

  it "responds with JS view if called with a remote true form" do
    get :index, xhr: true, format: :js
    expect(response).to render_template 'gatekeeper/index.js'

    get :show, xhr: true, format: :js, params: { id: 'model' }
    expect(response).to render_template 'gatekeeper/show.js'

    get :new, xhr: true, format: :js
    expect(response).to render_template 'gatekeeper/new.js'

    post :create, xhr: true, format: :js
    expect(response).to render_template 'gatekeeper/create.js'

    get :edit, xhr: true, format: :js, params: { id: 'model' }
    expect(response).to render_template 'gatekeeper/edit.js'

    patch :update, xhr: true, format: :js, params: { id: 'model' }
    expect(response).to render_template 'gatekeeper/update.js'

    delete :destroy, xhr: true, format: :js, params: { id: 'model' }
    expect(response).to render_template 'gatekeeper/destroy.js'
  end

  it "responds with JSON if called with format JSON" do
    get :index, xhr: true, format: :json
    expect(response.header['Content-Type']).to include 'application/json'

    get :show, xhr: true, format: :json, params: { id: 'model' }
    expect(response.header['Content-Type']).to include 'application/json'

    get :new, xhr: true, format: :json
    expect(response.header['Content-Type']).to include 'application/json'

    post :create, xhr: true, format: :json
    expect(response.header['Content-Type']).to include 'application/json'

    get :edit, xhr: true, format: :json, params: { id: 'model' }
    expect(response.header['Content-Type']).to include 'application/json'

    patch :update, xhr: true, format: :json, params: { id: 'model' }
    expect(response.header['Content-Type']).to include 'application/json'

    delete :destroy, xhr: true, format: :json, params: { id: 'model' }
    expect(response.header['Content-Type']).to include 'application/json'
  end

end
