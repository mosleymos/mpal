# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161221134656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string   "username",                       null: false
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "nom"
    t.string   "prenom"
    t.integer  "intervenant_id"
  end

  add_index "agents", ["intervenant_id"], name: "index_agents_on_intervenant_id", using: :btree
  add_index "agents", ["username"], name: "index_agents_on_username", unique: true, using: :btree

  create_table "aides", force: :cascade do |t|
    t.string  "libelle"
    t.integer "type_aide_id"
  end

  create_table "avis_impositions", force: :cascade do |t|
    t.string   "numero_fiscal"
    t.string   "reference_avis"
    t.integer  "annee"
    t.integer  "revenu_fiscal_reference"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "projet_id"
    t.string   "declarant_1"
    t.string   "declarant_2"
    t.integer  "nombre_personnes_charge"
  end

  add_index "avis_impositions", ["projet_id"], name: "index_avis_impositions_on_projet_id", using: :btree

  create_table "cad_references", force: :cascade do |t|
    t.integer "opal_id"
    t.string  "code"
    t.text    "libelle"
  end

  create_table "commentaires", force: :cascade do |t|
    t.integer  "projet_id"
    t.integer  "auteur_id"
    t.string   "auteur_type"
    t.text     "corps_message"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "commentaires", ["auteur_type", "auteur_id"], name: "index_commentaires_on_auteur_type_and_auteur_id", using: :btree
  add_index "commentaires", ["projet_id"], name: "index_commentaires_on_projet_id", using: :btree

  create_table "demandes", force: :cascade do |t|
    t.integer "projet_id"
    t.boolean "froid"
    t.boolean "probleme_deplacement"
    t.boolean "changement_chauffage"
    t.boolean "adaptation_salle_de_bain"
    t.boolean "accessibilite"
    t.boolean "ptz"
    t.string  "annee_construction"
    t.text    "complement"
    t.text    "autre"
    t.boolean "hospitalisation"
    t.boolean "travaux_fenetres"
    t.boolean "travaux_isolation"
    t.boolean "travaux_chauffage"
    t.boolean "travaux_adaptation_sdb"
    t.boolean "travaux_monte_escalier"
    t.boolean "travaux_amenagement_ext"
    t.text    "travaux_autres"
    t.boolean "date_achevement_15_ans"
  end

  add_index "demandes", ["projet_id"], name: "index_demandes_on_projet_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "label"
    t.string   "fichier"
    t.integer  "projet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "documents", ["projet_id"], name: "index_documents_on_projet_id", using: :btree

  create_table "engagements", force: :cascade do |t|
    t.string   "nom"
    t.boolean  "valeur"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evenements", force: :cascade do |t|
    t.integer  "projet_id"
    t.string   "label"
    t.datetime "quand"
    t.integer  "producteur_id"
    t.string   "producteur_type"
  end

  add_index "evenements", ["producteur_type", "producteur_id"], name: "index_evenements_on_producteur_type_and_producteur_id", using: :btree
  add_index "evenements", ["projet_id"], name: "index_evenements_on_projet_id", using: :btree

  create_table "intervenants", force: :cascade do |t|
    t.string "raison_sociale"
    t.string "adresse_postale"
    t.string "themes",            array: true
    t.string "departements",      array: true
    t.string "email"
    t.string "roles",             array: true
    t.text   "informations"
    t.string "clavis_service_id"
  end

  add_index "intervenants", ["clavis_service_id"], name: "index_intervenants_on_clavis_service_id", using: :btree
  add_index "intervenants", ["departements"], name: "index_intervenants_on_departements", using: :gin
  add_index "intervenants", ["roles"], name: "index_intervenants_on_roles", using: :gin
  add_index "intervenants", ["themes"], name: "index_intervenants_on_themes", using: :gin

  create_table "invitations", force: :cascade do |t|
    t.integer "projet_id"
    t.integer "intervenant_id"
    t.string  "token"
    t.integer "intermediaire_id"
  end

  add_index "invitations", ["intermediaire_id"], name: "index_invitations_on_intermediaire_id", using: :btree
  add_index "invitations", ["intervenant_id"], name: "index_invitations_on_intervenant_id", using: :btree
  add_index "invitations", ["projet_id"], name: "index_invitations_on_projet_id", using: :btree
  add_index "invitations", ["token"], name: "index_invitations_on_token", using: :btree

  create_table "ntr_references", force: :cascade do |t|
    t.integer "opal_id"
    t.string  "code"
    t.text    "libelle"
  end

  create_table "occupants", force: :cascade do |t|
    t.integer  "projet_id"
    t.string   "nom"
    t.string   "prenom"
    t.integer  "lien_demandeur"
    t.date     "date_de_naissance"
    t.integer  "civilite"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.boolean  "demandeur"
  end

  add_index "occupants", ["projet_id"], name: "index_occupants_on_projet_id", using: :btree

  create_table "personnes", force: :cascade do |t|
    t.string  "prenom"
    t.string  "nom"
    t.string  "tel"
    t.string  "email"
    t.string  "lien_avec_demandeur"
    t.integer "projet_id"
    t.string  "civilite"
  end

  add_index "personnes", ["projet_id"], name: "index_personnes_on_projet_id", using: :btree

  create_table "prestations", force: :cascade do |t|
    t.string   "libelle"
    t.string   "entreprise"
    t.float    "montant"
    t.boolean  "recevable"
    t.integer  "projet_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "scenario"
    t.boolean  "souhaite",   default: false, null: false
    t.boolean  "preconise",  default: false, null: false
    t.boolean  "retenu",     default: false, null: false
    t.integer  "theme_id"
  end

  add_index "prestations", ["projet_id"], name: "index_prestations_on_projet_id", using: :btree
  add_index "prestations", ["theme_id"], name: "index_prestations_on_theme_id", using: :btree

  create_table "projet_aides", force: :cascade do |t|
    t.integer "projet_id"
    t.integer "aide_id"
    t.float   "montant"
  end

  add_index "projet_aides", ["aide_id"], name: "index_projet_aides_on_aide_id", using: :btree
  add_index "projet_aides", ["projet_id"], name: "index_projet_aides_on_projet_id", using: :btree

  create_table "projet_prestations", force: :cascade do |t|
    t.integer "projet_id"
    t.integer "prestation_id"
    t.boolean "souhaite",      default: false, null: false
    t.boolean "preconise",     default: false, null: false
    t.boolean "retenu",        default: false, null: false
  end

  add_index "projet_prestations", ["prestation_id"], name: "index_projet_prestations_on_prestation_id", using: :btree
  add_index "projet_prestations", ["projet_id"], name: "index_projet_prestations_on_projet_id", using: :btree

  create_table "projets", force: :cascade do |t|
    t.string   "numero_fiscal"
    t.string   "reference_avis"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "adresse_ligne1"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "departement"
    t.string   "email"
    t.string   "tel"
    t.string   "themes",                                   array: true
    t.integer  "nb_occupants_a_charge",        default: 0
    t.integer  "annee_construction"
    t.string   "code_insee"
    t.integer  "statut",                       default: 0
    t.integer  "operateur_id"
    t.string   "opal_numero"
    t.string   "opal_id"
    t.string   "code_postal"
    t.string   "ville"
    t.integer  "personne_id"
    t.string   "adresse_postale_ligne1"
    t.string   "adresse_postale_code_postal"
    t.string   "adresse_postale_ville"
    t.string   "disponibilite"
    t.string   "type_logement"
    t.string   "etage"
    t.string   "nb_pieces"
    t.integer  "surface_habitable"
    t.string   "etiquette_avant_travaux"
    t.integer  "niveau_gir"
    t.boolean  "handicap"
    t.boolean  "demandeur_salarie"
    t.boolean  "entreprise_plus_10_personnes"
    t.integer  "note_degradation"
    t.integer  "note_insalubrite"
    t.boolean  "ventilation_adaptee"
    t.boolean  "presence_humidite"
    t.boolean  "auto_rehabilitation"
    t.text     "remarques_diagnostic"
    t.string   "etiquette_apres_travaux"
    t.integer  "gain_energetique"
    t.float    "montant_travaux_ht"
    t.float    "montant_travaux_ttc"
    t.float    "pret_bancaire"
    t.text     "precisions_travaux"
    t.text     "precisions_financement"
    t.boolean  "autonomie"
    t.string   "plateforme_id"
    t.float    "reste_a_charge"
  end

  add_index "projets", ["operateur_id"], name: "index_projets_on_operateur_id", using: :btree
  add_index "projets", ["personne_id"], name: "index_projets_on_personne_id", using: :btree
  add_index "projets", ["themes"], name: "index_projets_on_themes", using: :gin

  create_table "qdm_references", force: :cascade do |t|
    t.integer "opal_id"
    t.string  "code"
    t.text    "libelle"
  end

  create_table "themes", force: :cascade do |t|
    t.string "libelle"
  end

  create_table "type_aides", force: :cascade do |t|
    t.string "libelle"
  end

  add_foreign_key "agents", "intervenants"
  add_foreign_key "avis_impositions", "projets"
  add_foreign_key "commentaires", "projets"
  add_foreign_key "demandes", "projets"
  add_foreign_key "documents", "projets"
  add_foreign_key "evenements", "projets"
  add_foreign_key "invitations", "intervenants"
  add_foreign_key "invitations", "projets"
  add_foreign_key "occupants", "projets"
  add_foreign_key "personnes", "projets"
  add_foreign_key "prestations", "projets"
  add_foreign_key "prestations", "themes"
  add_foreign_key "projet_aides", "aides"
  add_foreign_key "projet_aides", "projets"
  add_foreign_key "projet_prestations", "prestations"
  add_foreign_key "projet_prestations", "projets"
  add_foreign_key "projets", "intervenants", column: "operateur_id"
  add_foreign_key "projets", "personnes"
end
