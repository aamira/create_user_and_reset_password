def create_new_user(formdata)
  begin
                        #user information
  @browser.text_field(:id => 'firstName').set formdata[:firstName]
  @browser.text_field(:id => 'lastName').set formdata[:lastName]
  @browser.text_field(:id => 'userInitial').set formdata[:userInitial]
  @browser.text_field(:id => 'loginName').set formdata[:loginName]
  @browser.text_field(:id => 'password1').set formdata[:password1]
  @browser.text_field(:id => 'password2').set formdata[:password2]  
  @browser.radio(:name => 'disablePasswordCheck', :value => formdata[:ignorePassword]) 
  @browser.select_list(:id => 'preferredTz').select formdata[:preferredTz] unless formdata[:preferredTz].nil?
  @browser.text_field(:id => 'externalSystemId').set formdata[:externalSystemId]
                        #account settings
  @browser.radio(:name => 'status', :value => formdata[:status])
  @browser.radio(:name => 'selfEnroll',:value => formdata[:selfEnroll]) 
                        #employer/work information
  @browser.select_list(:id => 'userTitle.id').select formdata[:title]
  @browser.text_field(:id => 'employeeId').set formdata[:employeeId]
  @browser.text_field(:id => 'hireDate').set formdata[:hireDate]
                        #submit
  @browser.button(:name => 'save').click
  @browser.button(:name => 'Save').click
  @log.write 'Successfully created user.'
  return true
  rescue => err
    puts @browser.span(:id => 'loginName.errors').exists?
    @log.write "Error creating user: {:firstName=> #{formdata[:firstName]},:lastName=> #{formdata[:lastName]},:userInitial=> #{formdata[:userInitial]},:loginName=> #{formdata[:loginName]},:title=> #{formdata[:title]}}"
    @log.write ('firstName: '+ @browser.span(:id => 'firstName.errors').text) if @browser.span(:id => 'firstName.errors').exists?
    @log.write ('lastName: '+ @browser.span(:id => 'lastName.errors').text) if @browser.span(:id => 'lastName.errors').exists?
    @log.write ('userInitial: '+ @browser.span(:id => 'userInitial.errors').text) if @browser.span(:id => 'userInitial.errors').exists?
    @log.write ('loginName: '+ @browser.span(:id => 'loginName.errors').text) if @browser.span(:id => 'loginName.errors').exists?
    @log.write ('password: '+ @browser.div(:id => 'div_global_error').text[44..@browser.div(:id => 'div_global_error').text.length]) if @browser.div(:id => 'div_global_error').exists? && !@browser.div(:id => 'div_global_error').text[44..@browser.div(:id => 'div_global_error').text.length].nil?
    @log.write ('preferredTz: '+ @browser.span(:id => 'preferredTz.errors').text) if @browser.span(:id => 'preferredTz.errors').exists?
    @log.write ('userTitle: '+ @browser.span(:id => 'userTitle.errors').text) if @browser.span(:id => 'userTitle.errors').exists?
    @log.write ('hireDate: '+ @browser.span(:id => 'hireDate.errors').text) if @browser.span(:id => 'hireDate.errors').exists?
    @log.write err
    return false
  end
end

