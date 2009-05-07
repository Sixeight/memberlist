
Given /^I create a new event "(.*)"$/ do |event_name|
  Given 'I am on the homepage'
  When %[I fill in "イベントの名前" with "#{event_name}"]
  And 'I press "新規作成"'
  Then 'I should be on setting page'
  And %[I should see "#{event_name}"]
end
