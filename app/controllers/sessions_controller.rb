class SessionsController < ApplicationController
  skip_before_action :authenticate
  def new
    
  end

  def create
    projet = ProjetEntrepot.par_numero_fiscal(params[:adresse_mail])
    if projet
      render "invited"
      return
    else
      projet = Projet.new
      projet.usager = "#{params[:prenom]} #{params[:nom]}"
      projet.numero_fiscal = params[:adresse_mail]
      projet.reference_avis = params[:adresse_mail]
      adresse = ApiBan.new.precise(params[:adresse_postale])
      projet.longitude = adresse[:longitude]
      projet.latitude = adresse[:latitude]
      projet.departement = adresse[:departement]
      projet.adresse = adresse[:adresse]
      result = projet.save
      puts "projet_created:#{result}"
      notice = t('projets.messages.creation.corps')
      flash[:notice_titre] = t('projets.messages.creation.titre', usager: projet.usager)
    end
    session[:projet] = projet
    puts "projet:#{projet},#{projet.id},#{projet.usager}"
    redirect_to "/projets/#{projet.id}", notice: notice
  end

end
