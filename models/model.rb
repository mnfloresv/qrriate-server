require 'mongoid'

class Tarjeta
  include Mongoid::Document
 
  field :tipo, type: String
  field :titulo, type: String
  field :descripcion, type: String
  field :lat, type: String
  field :long, type: String
  field :imagen, type: String
  field :url, type: String
end
