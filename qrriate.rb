require 'sinatra/base'
require 'json'

require_relative 'models/model.rb'

class Qrriate < Sinatra::Base
    
    configure do
        Mongoid.configure do |config|
            config.sessions = { 
                        :default => {
                            :hosts => ["localhost:27017"], :database => "c9"
                        }
            }
        end
    end

   get '/' do
       "Hola Arriate!"
   end
   
   get '/api/getPoints' do
       
       response.headers['Access-Control-Allow-Origin'] = '*'
        
        if params.empty?
            tarjetas={:tarjetas => Tarjeta.all}
            tarjetas.to_json
        elsif params.has_key?('t')
            tarjetas={:tarjetas => Tarjeta.where(tipo: params[:t])}
            tarjetas.to_json
        elsif params.has_key?('id')
            begin
                tarjeta={:tarjetas => Tarjeta.find(params[:id])}
                tarjeta.to_json
            rescue
                e = {:error => "Codigo no encontrado"}
                e.to_json
            end
        else
            e = {:error => "Invalid query"}
            e.to_json
        end
   end
   
   post '/api/addPoint' do
        Tarjeta.create(params)
   end
   
   get '/api/count' do
        Tarjeta.count.to_s
   end
   
   get '/admin' do
        @tarjetas = Tarjeta.all
        haml :index
   end
   
   get '/admin/new' do
        haml :new
   end
   
   post '/admin/new' do
        Tarjeta.create(params)
        redirect '/admin'
   end
end
