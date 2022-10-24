# frozen_string_literal: true

require 'rails_helper'

describe 'Employees', js: true, type: :system do
  describe 'employees index' do
    let(:manager_employee) { FactoryBot.create(:manager_employee) }
    let(:normal_employee) { FactoryBot.create(:normal_employee) }

    before do
      FactoryBot.create(:department_gizyutu)
      FactoryBot.create(:office_osaka)
      visit login_path
      fill_in 'employees_account', with: login_employee.account
      fill_in 'employees_password', with: login_employee.password
      click_button 'ログイン'
    end

    context 'when authorized employee is logged in' do
      let(:login_employee) { manager_employee }

      it 'create button appear' do
        expect(page).to have_content '新規追加'
      end

      it 'delete button appear' do
        expect(page).to have_content '削除'
      end

      it 'edit button appear' do
        expect(page).to have_content '編集'
      end

      it 'delete employee' do
        all('tbody th')[4].click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "「#{manager_employee.last_name} #{manager_employee.first_name}」を削除しました"
      end

      it 'edit employee' do
        all('tbody th')[3].click_link '編集'
        fill_in 'employee_last_name', with: '治'
        fill_in 'employee_first_name', with: '太宰'
        fill_in 'employee_password', with: manager_employee.password
        select '技術部', from: 'employee_department_id'
        select '大阪', from: 'employee_office_id'
        click_button '更新'
        all('tbody th')[3].click_link '編集'
        expect(page).to have_content '治 太宰'
        expect(page).to have_content '技術部'
        expect(page).to have_content '大阪'
      end

      it 'create employee' do
        click_link '新規追加'
        fill_in 'employee_number', with: 3
        fill_in 'employee_last_name', with: '治'
        fill_in 'employee_first_name', with: '太宰'
        fill_in 'employee_account', with: 'account'
        fill_in 'employee_password', with: 'hogehoge'
        fill_in 'employee_email', with: 'hoge@example.com'
        check 'お知らせ投稿権限'
        check '社員情報管理権限'
        fill_in 'employee_date_of_joining', with: '2022-04-01'
        select '技術部', from: 'employee_department_id'
        select '大阪', from: 'employee_office_id'
        click_on '保存'
        expect(page).to have_content '治 太宰'
      end
    end

    context 'when employee is logged in' do
      let(:login_employee) { normal_employee }

      it 'delete button not appear' do
        expect(page).to have_no_content '削除'
      end

      it 'edit button not appear' do
        expect(page).to have_no_content '編集'
      end

      it 'create button not appear' do
        expect(page).to have_no_content '新規追加'
      end
    end
  end
end
