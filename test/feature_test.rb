require_relative './feature_test_helper'

class AdminTest < FeatureTest

  def test_it_can_log_in
    visit '/my-account'
    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')
    assert page.has_css?('#product-table')
  end

  def test_it_can_log_out
    visit '/my-account'
    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')
    visit '/my-account'
    refute page.has_css?('#product-table')
  end

  def test_it_can_edit_products
    visit '/my-account'
    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')
    within('#product-table') do
      first('.edit-button').click_link('Edit')
    end
    assert page.has_css?('.edit-item')
  end

  def test_admin_can_turn_banner_on_and_off
    visit '/my-account'
    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')
    find(:xpath, "//a[@href='/3/edit']").click
    fill_in('content', :with => "1 Hello, Test")
    click_button('Submit')
    assert page.has_css?('.transbox')

    visit '/my-account'
    fill_in('username', :with => 'Admin')
    fill_in('password', :with => 'pass')
    click_button('Login')
    find(:xpath, "//a[@href='/3/edit']").click
    fill_in('content', :with => "0 Hello, Test")
    click_button('Submit')
    refute page.has_css?('.transbox')
  end

end

class UserTest < FeatureTest

  def test_it_cannot_edit_pages
    visit '/my-account'
    click_button('Login')
    refute page.has_css?('#product-table')
  end

  def test_it_can_email_admin_through_contact_form
    visit '/contact-locations'
    fill_in('name',          :with => 'Glen')
    fill_in('email_address', :with => 'glenegbert1@gmail.com')
    fill_in('message',       :with => 'Hello')
    fill_in('phone',         :with => '303 898 8988')
    click_button('Send')
    assert page.has_css?('#message')
  end

  def test_it_can_email_admin_through_reservation_form
    visit '/about'
    fill_in('name',          :with => 'Sara')
    fill_in('date',          :with => 'September 18, 2014')
    fill_in('time',          :with => 'Morning')
    fill_in('party_size',    :with => '20')
    fill_in('email_address', :with => 'ssimon@wellesley.edu')
    fill_in('phone',         :with => '867-5309')
    click_button('Send')
    assert page.has_css?('#message')
  end
end
