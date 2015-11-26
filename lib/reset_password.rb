def reset_password(currentPassword,password1,password2)
  begin
    @browser.text_field(:id => 'currentPassword').set currentPassword
    @browser.text_field(:id => 'password1').set password1
    @browser.text_field(:id => 'password2').set password2
    @browser.button(:text => 'Change Password').click
  rescue => err
    @log.write "error creating password"
  end
end