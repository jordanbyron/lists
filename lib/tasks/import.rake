require 'csv'

desc "Imports legacy lists from csv"
task :import => :environment do
  csv_files = Rails.root.join("csv")
  
  users         = CSV.read(csv_files + "users.csv",         :headers => true)
  lists         = CSV.read(csv_files + "lists.csv",         :headers => true)
  gifts         = CSV.read(csv_files + "gifts.csv",         :headers => true)
  invites       = CSV.read(csv_files + "invites.csv",       :headers => true)
  claimed_gifts = CSV.read(csv_files + "claimed_gifts.csv", :headers => true)
  
  users.each do |legacy_user|
    user = User.find_or_create_by_email(:name  => legacy_user["name"], 
                                        :email => legacy_user["email"])
    
    lists.select {|l| l["user_id"] == legacy_user["id"] }.each do |legacy_list|
      list = user.lists.create(
        :name        => legacy_list["name"],
        :description => legacy_list["description"],
        :occurs_on   => legacy_list["occurs_on"],
        :archived    => legacy_list["archived"] == "true",
        :public      => false
      )
      
      gifts.select {|g| g["list_id"] == legacy_list["id"] }.each do |legacy_gift|
        gift = list.gifts.create(
          :name => legacy_gift["name"],
          :description => legacy_gift["description"],
          :price       => legacy_gift["price"],
          :link        => legacy_gift["link"],
          :quantity    => legacy_gift["quantity"]
        )
        
        claimed_gifts.select {|g| g["gift_id"] == legacy_gift["id"] }.each do |legacy_claim|
          legacy_claim_user = users.find {|u| u["id"] == legacy_claim["user_id"] }
          
          next if legacy_claim_user.nil?
          
          claim_user = User.find_or_create_by_email(
            :name  => legacy_claim_user["name"], 
            :email => legacy_claim_user["email"]
          )
          
          Claim.create(
            :user      => claim_user,
            :gift      => gift,
            :purchased => legacy_claim["purchased"] == "true"
          )
        end
      end
      
      invites.select {|i| i["list_id"] == legacy_list["id"] }.each do |legacy_invite|
        legacy_invite_user = users.find {|u| u["id"] == legacy_invite["user_id"] }
        
        next if legacy_invite_user.nil?
        
        invite_user = User.find_or_create_by_email(
          :name  => legacy_invite_user["name"], 
          :email => legacy_invite_user["email"]
        )
        
        list.invites.create(
          :user       => invite_user, 
          :email_sent => legacy_invite["email_sent"]
        )
      end
    end
  end
end