describe "operateurs by coordinates" do
	paris = Operateur.create!(
		nom:"OpParis",
		zone: "",
	)

	doubs = Operateur.create!(
		nom:"OpBesac",
		zone: "",
	)

	it "peut rechercher un opérateur par coordonnées GPS" do
		expect(Operateur.find_by_coord(6.015272,47.23467).first.nom).to eq "OpBesac"
	end
end