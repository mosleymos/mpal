test "operateurs by coordinates" do
	paris = Operateur.create!(
		name:"OpParis",
		zone: "",
	)

	doubs = Operateur.create!(
		name:"OpBesac",
		zone: "",
	)

	assert_equal "OpBesac", Operateur.find_by_coord(6.015272,47.23467).first.name
end