require "spec_helper"

RSpec.describe DataSanitizer do
  good_data = [{
    "title"=>"Maison contemporaine 5 pièces à Auray ", 
    "images"=>"../images/img1.jpg", 
    "size"=>" 90 m²", 
    "location"=>" Auray 56400", 
    "price"=>" 360468 €*", 
    "energy"=>" C ", 
    "foundation_years"=>" 1990", 
    "content"=>"\n                Cette charmante maison contemporaine, située au calme, proches des commodités, offre 4 chambres, un\n                
    séjour/salon, cuisine AEO, salle de bains, garage, annexe de 12 m², grande terrasse sans vis à vis, \n                
    le tout sur un terrain clos d'environ 350 m²."
  }, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

  dark_data = [{
    "title"=>"Maison contemporaine 5 pièces à Auray ", 
    "images"=>"../images/img1.jpg", 
    "size"=>" 90 m²", 
    "location"=>" Auray 56400", 
    "price"=>" 360468 €*", 
    "energy"=>" C ", 
    "content"=>"\n                Cette charmante maison contemporaine, située au calme, proches des commodités, offre 4 chambres, un\n                
    séjour/salon, cuisine AEO, salle de bains, garage, annexe de 12 m², grande terrasse sans vis à vis, \n                
    le tout sur un terrain clos d'environ 350 m²."
  }]

  it "return false if data is good" do
    data_sanitizer = DataSanitizer.new(good_data)
    expect(data_sanitizer.check_data).to eql(false)
  end

  it "return true if data is bad" do
    data_sanitizer = DataSanitizer.new(dark_data)
    expect(data_sanitizer.check_data).to eql(true)
  end

end
