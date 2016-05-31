class Operateur < ActiveRecord::Base
	scope :find_by_coord, -> (longitude, latitude) {
		where(%{
			ST_CONTAINS(
			  operateurs.zone,
				ST_GeometryFromText('SRID=4326;POINT(%f %f)')
			)
		} % [longitude, latitude])
	}
end
