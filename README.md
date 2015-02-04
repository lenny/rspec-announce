# Rspec::Announce

Adds ```announce(msg)``` to Rspec examples to facilitate Cucumber style output without Cucumber (and separate step definitions).

Describe a block of code and see the description in Rspec output.

## Why?

Integration/feature specs can be very slow. For such specs, I sometimes find it worthwhile to
compromise on the "single expectation per example" thing, in the interest of speed. I 
often prefer to chain naturally sequenced scenarios together to avoid multiple setups, but doing
so can make it hard to see the story amongst the details. 

* Cucumber allows you to extract details into step definitions, while outputting
  only step descriptions at runtime, but sometimes, the benefits of plain text features
  don't seem to balance with the time to develop and maintain step definitions.
  Developing a ubiquitous language organically, in plain Ruby is comparatively simpler and
  may be good enough, but I still want the runtime documentation.
* Simple comments in a feature spec could help, but there's no runtime output
  and comments tend to become separated from their intended code. ```announce``
  provides a way to wrap a block of code with an inline description. 
* ```announce``` has no effect except when paired with an announcement capable formatter.
   

e.g. Using a mixture of straight Capybara DLS and custom step methods

    scenario 'existing account' do
        announce 'when I click to add a trial from the class details page' do
          visit kis_class_path(kis_class)
          click_link 'Trials'
        end
        announce 'Then I see screen 1 of the trial wizard'
        announce 'When I select a date from following month on the calendar' do
          calendar.click_month 'March'
          calendar.click_day '9'
        end
        announce 'Then the trial date input is autofilled' do
          expect(page).to have_field 'trial_initiation_date', with: '03/09/2015'
        end
        announce 'I see errors when I submit a partial form' do
          fill_in 'Email', with: 'x@somewhere.com'
          click_button 'Add Trial'
          should_see_errors
        end
        announce 'When I correct and submit a valid initiation form' do
          fill_in 'Last Name', with: 'Jones'
          click_button 'Add Trial'
        end
        announce 'Then I see screen 2 of the wizard with a listing of potentially matching accounts'
        announce 'When I choose and existing account' do
          choose "account_id_#{account.id}"
        end
        announce 'I see errors when I submit a partial form' do
          click_button 'Submit'
          should_see_errors
        end
        announce 'When I complete and submit a valid form' do
          trials.fill_in_child_name_with 'Samthetrialkid'
          click_button 'Submit'
        end
        announce 'A trial is created' do
          should_have_flash(/Trial created/i)
          trials.assert_account_page_has_trial_for('Samthetrialkid')
        end
    end

Outputs:

        existing account
          when I click to add a trial from the class details page
          Then I see screen 1 of the trial wizard
          When I select a date from following month on the calendar
          Then the trial date input is autofilled
          I see errors when I submit a partial form
          When I correct and submit a valid initiation form
          Then I see screen 2 of the wizard with a listing of potentially matching accounts
          When I choose and existing account
          I see errors when I submit a partial form
          When I complete and submit a valid form
          A trial is created


## Usage

    $ echo "--format Rspec::Announc::Formatter" >> $PROJECT_HOME/.rspec


## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec-announce/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
