require 'watir'
require 'json'

#getting login credentials from json file
json = File.read('info.json')
info = JSON.parse(json)

user = info['email']
password = info['password']
recipient = info['recipient']
message = info['message']

#open browser & goto login page
browser = Watir::Browser.new
browser.goto 'linkedin.com/login'

#find username text field
user_field = browser.text_field(id: "username")
#fill field
user_field.set(user)
#find password text field
pass_field = browser.text_field(id: "password")
#fill
pass_field.set(password)
#find submit button
sign_in = browser.element(tag_name: "form",class: "login__form").button(type:"submit" )
#click
sign_in.click

#navigate to messages page (easier than trying to handle buttons on profiles, apparently)
browser.goto 'linkedin.com/messaging/compose'

#enter recipient name into text box
whom =  browser.text_field(placeholder: "Type a name or multiple names…")
whom.set(recipient)

#select recipient from dropdown
 whom_specifically = browser.button(class: "display-flex", role:"option")
 whom_specifically.click

#move to message box and enter message
message_box = browser.div(class: "msg-form__contenteditable t-14 t-black--light t-normal flex-grow-1")
message_box.set(message)

#send message
send = browser.button(text: "Send", type: "submit")
send.click