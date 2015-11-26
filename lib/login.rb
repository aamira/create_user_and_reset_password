def login(loginName: nil,password: nil,providerCode: nil)
   begin 
     if loginName.nil? || password.nil? || providerCode.nil?
       if !loginName.nil?        
         @log.write 'password|providerCode : cannot be empty{loginName:#{loginName}} ' if password.nil? && providerCode.nil?
         @log.write 'providerCode : cannot be empty{loginName:#{loginName}} ' if !password.nil? && providerCode.nil?
         @log.write 'password : cannot be empty{loginName:#{loginName}} ' if password.nil? && !providerCode.nil?
       elsif !password.nil?
         @log.write 'LoginName|providerCode : cannot be empty{loginName:#{loginName}} ' if loginName.nil? && providerCode.nil?
         @log.write 'loginName : cannot be empty' if loginName.nil? && !providerCode.nil?
       elsif !providerCode.nil?
         @log.write 'loginName|password : cannot be empty. ' if password.nil? && loginName.nil?
       else @log.write 'loginName|password|providerCode : cannot be empty. '
       end
       return false
     end   
    @browser.send_keys loginName, :tab, password, :tab, providerCode, :enter
    if @browser.text.include? 'Login Failed' 
      @log.write "Login error: loginName=> #{loginName} "
      return false
    end
    return true
    end
end