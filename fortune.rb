require 'json'
require 'sinatra/base'
require 'sinatra/respond_with'


class FortuneApp < Sinatra::Base
  register Sinatra::RespondWith

  set :app_path, '/fortune'

  get '/?:long?/?:dirty?' do
    args = '-'
    command = ['fortune']
    long = params[:long].to_i
    dirty = params[:dirty].to_i

    case long
      when 1
        args += 'l'
      when 0
        args += 's'
      when nil
        args = '-'
    end

    args += 'o' if dirty == 1
    command << args if args.length > 1

    begin

      fortune = IO.popen([command]).read

      #respond_to do |f|
      #  f.txt { fortune }
      #  f.json { {text: fortune.gsub!(/[\n|\t]/, '')}.to_json }
      #end

      if request.env['Content-Type'] == 'application/json'
        content_type 'application/json'
        [200, {text: fortune.gsub!(/[\n|\t]/, '')}.to_json ]
      else
        content_type 'text/plain'
        [200, fortune]
      end

    rescue Exception => e
      [500, {error: e.message}.to_json, {ContentType: 'application/json'}]
    end

  end

end
