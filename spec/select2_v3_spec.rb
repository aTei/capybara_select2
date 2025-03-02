require 'spec_helper'

describe CapybaraSelect2 do

  context 'with select2 version 3' do

    before { visit '/select2-v3/index.html' }

    context 'selecting a value from a single select box' do

      it 'should select an option from select found by XPath' do
        select2 'XBox', xpath: '//div[@id="single"]'
        expect(page).to have_css '.select2-chosen', text: 'XBox'
      end

      it 'should select an option from select found by CSS selector' do
        select2 'XBox', css: '#single'
        expect(page).to have_css '.select2-chosen', text: 'XBox'
      end

      it 'should select an option from select found by label' do
        select2 'XBox', from: 'Select game console'
        expect(page).to have_css '.select2-chosen', text: 'XBox'
      end

      context 'when searching for an option' do
        it 'should select an option from search results' do
          select2 'Wii', css: '#single', search: true
          expect(page).to have_css '.select2-chosen', text: 'Wii'
        end

        it 'should select first matched option from search results' do
          select2 'PlayStation', css: '#single', search: true, match: :first
          expect(page).to have_css '.select2-chosen', text: 'PlayStation 3'
        end

        it 'should select option with exact text from search results' do
          select2 'PlayStation', css: '#single', exact_text: true
          expect(page).to have_css '.select2-chosen', text: 'PlayStation'
        end
      end

      context 'when searching for an option within a block' do
        it 'should select an option from search results' do
          within '#single' do
            select2 'Wii', css: '.select2-container', search: true
          end
          expect(page).to have_css '.select2-container span', text: 'Wii'
        end
      end

      context 'with a select2 with options "XBox", "PlayStation" and "Wii"' do
        it 'should confirm that page has select2 option with text "XBox"' do
          find('#single .select2-choice').click
          expect(page).to have_select2_option('XBox')
        end

        it 'should confirm that there is no select2 option with text "PC4"' do
          find('#single .select2-choice').click
          expect(page).not_to have_select2_option('PC4')
        end
      end
    end

    context 'selecting a value from a multi select box' do

      it 'should select an option from select found by XPath' do
        select2 'Buy Milk', xpath: '//div[@id="multiple"]'
        expect(page).to have_css '.select2-search-choice', text: 'Buy Milk'
      end

      it 'should select an option from select found by CSS selector' do
        select2 'Buy Milk', css: '#multiple'
        expect(page).to have_css '.select2-search-choice', text: 'Buy Milk'
      end

      it 'should select an option from select found by label' do
        select2 'Buy Milk', from: 'Things to do'
        expect(page).to have_css '.select2-search-choice', text: 'Buy Milk'
      end

      it 'should select an option from select with previously selected values' do
        select2 'Buy Milk', css: '#multiple', search: true
        select2 'See Malaysia', css: '#multiple', search: true

        expect(page).to have_css '.select2-search-choice', text: 'Buy Milk'
      end

      context 'when searching for an option' do
        before { select2 'Buy Milk', css: '#multiple', search: true }

        it 'should select an option from search results' do
          expect(page).to have_css '.select2-search-choice', text: 'Buy Milk'
        end
      end

      context 'with a select2 select with options "Buy Milk", "See Malaysia" and "Go to gym"' do
        it 'should confirm that page has select2 option with text "Buy Milk"' do
          find('#multiple .select2-search-field').click
          expect(page).to have_select2_option('Buy Milk')
        end

        it 'should confirm that there is no select2 option with text "Travel to Minsk"' do
          find('#multiple .select2-search-field').click
          expect(page).not_to have_select2_option('Travel to Minsk')
        end
      end
    end

    # tagging

    context 'creating a dynamic option' do
      it 'should add an option from search box' do
        select2 'Millennials', css: '#tagging', tag: true

        expect(page).to have_css '.select2-search-choice', text: 'Millennials'
      end
    end

  end
end
