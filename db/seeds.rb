lorems = []
lorems << lorem1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras dui."
lorems << lorem2 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dapibus."
lorems << lorem3 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ullamcorper."
lorems << lorem4 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pellentesque."
lorems << lorem5 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sagittis."
lorems << ""

(1..20).to_a.each do |num|
    Project.create(name: "Project #{num}", description: lorems.sample, img_link: [0,1].sample)
    
end
  

