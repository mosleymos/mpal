class SessionsController < ApplicationController

  skip_before_action :authenticate

  def new
    session[:state] = Random::DEFAULT.rand.to_s
    client = OpenIDConnect::Client.new(
      identifier: ENV['OP_CLIENT_ID'],
      secret: ENV['OP_SECRET_KEY'],
      redirect_uri: 'http://localhost:5000/oidc_callback',
      host: 'fcp.integ01.dev-franceconnect.fr',
      authorization_endpoint: '/api/v1/authorize',
      token_endpoint: '/api/v1/token',
      userinfo_endpoint: '/api/v1/userinfo'
    )
    authorization_uri = client.authorization_uri(
      state: session[:state],
      nonce: 1,
      scope: [:profile, :email, :adresse]
    )
    redirect_to authorization_uri
  end

  def create
    client = OpenIDConnect::Client.new(
      identifier: ENV['OP_CLIENT_ID'],
      secret: ENV['OP_SECRET_KEY'],
      redirect_uri: 'http://localhost:5000/oidc_callback',
      host: 'fcp.integ01.dev-franceconnect.fr',
      authorization_endpoint: '/api/v1/authorize',
      token_endpoint: '/api/v1/token',
      userinfo_endpoint: '/api/v1/userinfo'
    )
    client.authorization_code = params[:code]
    token = client.access_token! (:acid)
    access_token = OpenIDConnect::AccessToken.new(
      access_token: token,
      client: client
    )
    session[:profile] = profile = access_token.userinfo!
    projet = ProjetEntrepot.par_numero_fiscal(profile.sub)
    puts "projet_by_sub:#{projet}"
    unless projet
      projet = Projet.new
      projet.usager = "#{profile.given_name} #{profile.family_name}"
      projet.numero_fiscal = profile.sub
      projet.reference_avis = profile.sub
      adresse = ApiBan.new.precise(profile.address)
      projet.longitude = adresse[:longitude]
      projet.latitude = adresse[:latitude]
      projet.departement = adresse[:departement]
      projet.adresse = adresse[:adresse]
      result = projet.save
      puts "projet_created:#{result}"
      notice = t('projets.messages.creation.corps')
      flash[:notice_titre] = t('projets.messages.creation.titre', usager: projet.usager)
    end
    puts "projet:#{projet},#{projet.id},#{projet.usager}"
    redirect_to "/projets/#{projet.id}", notice: notice
  end

  def create_old
    service = ApiParticulier.new
    contribuable = service.retrouve_contribuable(params[:numero_fiscal], params[:reference_avis])
    if contribuable
      session[:numero_fiscal] = params[:numero_fiscal]
      projet = ProjetEntrepot.par_numero_fiscal(params[:numero_fiscal])
      unless projet
        facade = ProjetFacade.new(service, ApiBan.new)
        projet = facade.initialise_projet(params[:numero_fiscal], params[:reference_avis])
        projet.save
        notice = t('projets.messages.creation.corps')
        flash[:notice_titre] = t('projets.messages.creation.titre', usager: projet.usager)
      end
      if projet
        redirect_to projet, notice: notice
      else
        redirect_to new_session_path, alert: t('sessions.erreur_generique')
      end
    else
      redirect_to new_session_path, alert: t('sessions.invalid_credentials')
    end
  end

end
