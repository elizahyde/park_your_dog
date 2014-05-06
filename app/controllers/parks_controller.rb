require 'uri'

class  ParksController < ApplicationController
  def index
    @parks = Park.all
  end

  def show
    @park = Park.find(params[:id])
    # @parkName = URI.escape([ params[:name] ])
    @parkName = URI.escape("lafayette park")
    @f = Park.get_photos(@parkName)
  end
end