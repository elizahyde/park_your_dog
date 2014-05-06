class Park < ActiveRecord::Base
  has_many :photos
  validates_presence_of :longitude, :latitude, :name, :address
  validates_numericality_of :longitude, :latitude

  def self.get_photos(parkName)
    # get venue id
    response = HTTParty.get("https://api.foursquare.com/v2/venues/search?ll=40.7,-74&query=lafayette%20park&oauth_token=#{ENV['OATHTOKEN']}&v=20140506")
    results = {}
binding.pry
    response["response"]["groups"][0]["items"].first do |f|
      results[f["venue"]["name"]] =
        {fid:f["venue"]["id"], furl:f["venue"]["url"]}
      end

      # to search for photos by venue id
    results.each do |k,v|
      begin
        img_response = HTTParty.get("https://api.foursquare.com/v2/venues/#{v[:fid]}/photos?oauth_token=#{ENV['OATHTOKEN']}&v=20140304")
        img_results = {
          :img_url => img_response["response"]["photos"]["items"][0]["suffix"]
        }
      rescue
        next
      end
      results[k] = results[k].merge(img_results)
    end
    return results
  end
end
