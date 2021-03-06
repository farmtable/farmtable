module SettingsSteps
  DELETE_LINK_SELECTOR = ".account-settings-email-row-delete-link"
  NOTIFICATION_CHECKOUT_SELECTOR = ".account-settings-email-row-send-notification-checkbox"
  RESEND_LINK_SELECTOR = ".account-settings-email-row-resend-link"

  def find_row_for_email(email)
    email_div = find(".account-settings-email-row-address", :text => "#{email}")
    email_row = email_div.first(:xpath, ".//..")
  end

  def find_remove_link_for_email(email)
    find_row_for_email(email).find(DELETE_LINK_SELECTOR)
  end

  def should_not_find_remove_link_for(email)
    find_row_for_email(email).should have_no_selector(DELETE_LINK_SELECTOR)
  end

  def find_notification_checkbox_for_email(email)
    find_row_for_email(email).find(NOTIFICATION_CHECKOUT_SELECTOR)
  end

  def find_resend_link_for_email(email)
    find_row_for_email(email).find(RESEND_LINK_SELECTOR)
  end

  def should_not_find_resend_link_for_email(email)
    find_row_for_email(email).should have_no_selector(RESEND_LINK_SELECTOR)
  end
end

World(SettingsSteps)

When /^I add a new email "(.*?)"$/ do |email|
  steps %Q{
    When I click "#account-new-email"
    And I fill in "person_email_attributes_address" with "#{email}"
    And I wait for 1 second
    And I save email settings
    Then I should see "#{email}"
  }
end

When /^I save email settings$/ do
  steps %Q{
    When I press "email_submit"
  }
end

Then /^I should not be able to remove email "(.*?)"$/ do |email|
  should_not_find_remove_link_for(email)
end

When /^I remove email "(.*?)"$/ do |email|
  find_remove_link_for_email(email).click
  steps %Q{
    And I confirm alert popup
  }
end

Then /^I should not have email "(.*?)"$/ do |email|
  steps %Q{
    Then I should not see "#{email}"
  }
  Email.find_by_address_and_person_id(email, @logged_in_user.id).should be_nil
end

Then /^I should not be able to remove notifications from "(.*?)"$/ do |email|
  find_notification_checkbox_for_email(email).should be_checked
  find_notification_checkbox_for_email(email).click
  steps %Q{
    And I save email settings
    Then I should see "You must pick at least one email address for receiving notifications"
  }
  # Rollback
  find_notification_checkbox_for_email(email).click
  find_notification_checkbox_for_email(email).should be_checked
end

When /^I set notifications for email "(.*?)"$/ do |email|
  find_notification_checkbox_for_email(email).should_not be_checked
  find_notification_checkbox_for_email(email).click
  steps %Q{
    And I save email settings
  }
end

Then /^I should be able to remove notifications from "(.*?)"$/ do |email|
  steps %{
    Given I should receive notifications for email "#{email}"
  }
  find_notification_checkbox_for_email(email).should be_checked
  find_notification_checkbox_for_email(email).click
  steps %{
    When I save email settings
  }
  find_notification_checkbox_for_email(email).should_not be_checked
  steps %{
    Then I should not receive notifications for email "#{email}"
  }
end

Then /^I should receive notifications for email "(.*?)"$/ do |email|
  Email.find_by_address(email).send_notifications.should be_true
end

Then /^I should not receive notifications for email "(.*?)"$/ do |email|
  Email.find_by_address(email).send_notifications.should be_false
end

Then /^I should not be able to resend confirmation for "(.*?)"$/ do |email|
  should_not_find_resend_link_for_email(email)
end

Then /^I should be able to resend confirmation for "(.*?)"$/ do |email|
  find_resend_link_for_email(email)
end

When /^I resend confirmation for "(.*?)"$/ do |email|
  find_resend_link_for_email(email).click
end
