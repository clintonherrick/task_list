require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new list', {:type => :feature}) do
  it('allows a user to click a list to see the task and details for it') do
    visit('/')
    click_link('Add New List')
    fill_in('name', :with => 'Epicodus Work')
    click_button('Add List')
    expect(page).to have_content('Your list has been added!!!')
  end
end

describe('viewing all of the lists', {:type => :feature}) do
  it('allows a user to sell all of the lists that have been created') do
  list = List.new({:name => 'Epicodus Homework', :id => nil})
  list.save()
  visit('/')
  click_link('View All Lists')
  expect(page).to have_content(list.name)
  end
end

describe('seeing details for a single list', {:type => :feature}) do
  it('alows a user to click a list to see the tasks and details for it') do
    test_list = List.new({:name => 'School Stuff', :id => nil})
    test_list.save()
    test_task = Task.new ({:description => "learn SLQ", :list_id => test_list.id(), :due_date => '2015-08-31', :id => nil})
    test_task.save()
    visit('/lists')
    click_link(test_list.name())
    expect(page).to have_content(test_task.description())
  end
end

describe('adding tasks to the list', {:type => :feature}) do
  it('allows a user to add a task to a list') do
    test_list = List.new({:name => 'School Stuff', :id => nil})
    test_list.save()
    visit("/lists/#{test_list.id()}")
    fill_in("Description", {:with => "Learn SQL"})
    click_button("Add task")
    expect(page).to have_content("Your task has been added to your list!!!")
  end
end
