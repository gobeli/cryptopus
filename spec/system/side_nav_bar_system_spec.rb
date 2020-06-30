# frozen_string_literal: true

#  Copyright (c) 2008-2017, Puzzle ITC GmbH. This file is part of
#  Cryptopus and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/cryptopus.

require 'rails_helper'


describe 'SideNavBar', type: :system, js: true do
  include SystemHelpers

  it 'navigate through side nav bar' do
    login_as_user(:bob)

    sidebar = page.find('#sidebar')
    expect(sidebar).to be_present

    expect(sidebar).to have_text('team1')
    expect(sidebar).to have_text('team2')

    within(sidebar) do
      first_team_entry = all('a')[1]
      second_team_entry = all('a')[2]

      expect(first_team_entry).to have_xpath("//img[@alt='<']")
      first_team_entry.click

      expect(sidebar).to have_text('folder1')
      expect(first_team_entry).to have_xpath("//img[@alt='v']")

      expect(current_path).to eq '/teams?team_id=1'
      # TODO: check if page shows this team

      first_team_entry.click
      expect(first_team_entry).to have_xpath("//img[@alt='<']")
      expect(sidebar).to_not have_text('folder1')

      second_team_entry.click
      expect(sidebar).to_not have_text('folder1')
      expect(sidebar).to have_text('folder2')

      folder_entry = first_team_entryall('a')[1]
      folder_entry.click

      expect(current_path).to eq '#/teams?folder_id=1&team_id=2'
      # TODO: check if page expanded correct folder

      start_page = all('a')[0]
      expect(start_page).to have_text('All Teams or something')
      start_page.click
      # TODO: what to expect on start page?

    end

    logout
  end

end
