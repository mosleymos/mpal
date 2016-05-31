describe "le référentiel des opérateurs" do
	factory = RGeo::Geographic.spherical_factory(:srid => 4326)
	paris_pts = [[2.35682487487793, 48.9223864684967], [2.35682487487793, 48.9261649710814], [2.36309051513672, 48.9261649710814], [2.36309051513672, 48.9223864684967], [2.35682487487793, 48.9223864684967]]
	doubs_pts = [5.51513671875, 47.2419488216324], [5.73486328125, 47.5691137586671], [6.492919921875, 47.4429499951795], [6.580810546875, 47.0776041171596], [6.119384765625, 46.9277586234344], [5.51513671875, 47.2419488216324]

	it "peut rechercher un opérateur par coordonnées GPS" do
		paris = Operateur.create!(
			nom:"OpParis",
			zone: factory.polygon(factory.line_string(paris_pts.map {|x| factory.point(*x)}))
		)

		doubs = Operateur.create!(
			nom:"OpBesac",
			zone: factory.polygon(factory.line_string(doubs_pts.map {|x| factory.point(*x)}))
		)
		expect(Operateur.find_by_coord(6.015272,47.23467).first.nom).to eq "OpBesac"
	end
end