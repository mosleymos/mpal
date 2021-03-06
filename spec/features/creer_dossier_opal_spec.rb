require 'rails_helper'
require 'support/mpal_helper'
require 'support/opal_helper'

feature "creer dossier dans opal" do
  scenario "depuis la page projet" do
    pending
    instructeur = FactoryGirl.create(:intervenant, :instructeur)
    invitation = FactoryGirl.create(:invitation, intervenant: instructeur)
    projet = invitation.projet
    projet.statut = :transmis_pour_instruction
    projet.save

    visit projet_path(projet, jeton: invitation.token)
    click_button I18n.t('projets.visualisation.creer_dossier_opal')
    expect(page).to have_content(I18n.t("projets.creation_opal.messages.succes", id_opal: "09500840"))

    visit projets_path(jeton: invitation.token)
    within "#projet_#{projet.id}" do
      expect(page).to have_content(I18n.t("projets.statut.en_cours_d_instruction"))
      expect(page).to have_content("09500840")
    end
  end

  scenario "lorsque je suis instructeur je vois le bouton me permettant de créer un dossier dans Opal" do
    pending
    instructeur = FactoryGirl.create(:intervenant, :instructeur)
    invitation = FactoryGirl.create(:invitation, intervenant: instructeur)
    projet = invitation.projet
    visit projet_path(invitation.projet, jeton: invitation.token)
    expect(page).to have_content(I18n.t('projets.creation_opal.titre_creation_opal'))
  end



end
