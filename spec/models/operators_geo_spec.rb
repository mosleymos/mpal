describe "operateurs by coordinates" do
	paris = Operateur.create!(
		name:"OpParis",
		zone: "",
	)

	doubs = Operateur.create!(
		name:"OpBesac",
		zone: "",
	)

	it "peut rechercher un opérateur par coordonnées GPS" do
		expect(Operateur.find_by_coord(6.015272,47.23467).first.name).to eq "OpBesac"
	end
end