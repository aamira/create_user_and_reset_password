require 'roo'
require_relative 'source_file'

NewUserForm = Struct.new(:firstName, :lastName, :userInitial,:loginName, :password1, :password2, :ignorePassword, :preferredTz, :externalSystemId,
 :status, :selfEnroll,
 :title, :employeeId, :hireDate)
 
def get_user_data
  begin
    file_source = get_file_spec('../test_data/conf.txt')
    
    xlsx = Roo::Excelx.new(file_source["source_file_path"])
    users = Array.new{NewUserForm.new}
    myexcel = xlsx.sheet 0
    counter = file_source["start_from_line_no"].to_i
    rows = counter-1
    myexcel.each do |row|      
    unless rows==counter-1 
   
      ignorePassword = row[6].nil?? 'false':row[6]
      
      
      status = row[9].nil?? 0:row[9]
      selfEnroll = row[10].nil?? 'false':row[10]
      title = row[11].nil?? '- Please Select -':row[11]

     
       users.push(:firstName => row[0].to_s, 
      :lastName => row[1].to_s, 
      :userInitial => row[2],
      :loginName => row[3], 
      :password1 => row[4], 
      :password2 => row[5],
      :ignorePassword => ignorePassword.to_s.downcase,
      :preferredTz => row[7],
      :externalSystemId =>row[8],
       
      :status => status.to_i.to_s,
      :selfEnroll => selfEnroll.to_s.downcase,
      
      :title => title.to_s,
      :employeeId => row[12].to_s,
      :hireDate => row[13].to_s
      )
      end
    rows = rows+1
   end
  
  xlsx.close
  users
  rescue => err
    p err
  end
end

def get_loginName(user)
  user[:loginName]
end

def get_password(user)
  user[:password1]
end
