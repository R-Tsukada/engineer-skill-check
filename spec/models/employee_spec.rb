# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:department) { FactoryBot.create(:department_gizyutu) }
  let(:office) { FactoryBot.create(:office_osaka) }

  it 'is valid with a department id, office id, number, last name, first name, account, password, email, and date of joing' do
    employee = described_class.new(
      department_id: department.id,
      office_id: office.id,
      number: 1,
      last_name: 'aoi',
      first_name: 'tsukada',
      account: 'tsukada',
      password: 'password',
      email: 'sample@example.com'
    )
    expect(employee).to be_valid
  end

  it 'is invalid without a department id' do
    employee = described_class.new(department_id: nil)
    employee.valid?
    expect(employee.errors[:department]).to include('を入力してください')
  end

  it 'is invalid without a office id' do
    employee = described_class.new(office_id: nil)
    employee.valid?
    expect(employee.errors[:office]).to include('を入力してください')
  end

  it 'is invalid without a number' do
    employee = described_class.new(number: nil)
    employee.valid?
    expect(employee.errors[:number]).to include('を入力してください')
  end

  it 'is invalid without a last name' do
    employee = described_class.new(last_name: nil)
    employee.valid?
    expect(employee.errors[:last_name]).to include('を入力してください')
  end

  it 'is invalid without a first name' do
    employee = described_class.new(first_name: nil)
    employee.valid?
    expect(employee.errors[:first_name]).to include('を入力してください')
  end

  it 'is invalid without a account' do
    employee = described_class.new(account: nil)
    employee.valid?
    expect(employee.errors[:account]).to include('を入力してください')
  end

  it 'is invalid without a password' do
    employee = described_class.new(password: nil)
    employee.valid?
    expect(employee.errors[:password]).to include('を入力してください')
  end

  it 'checks csv columns department' do
    csv_content = described_class.generate_csv
    csv = CSV.parse(csv_content)
    expect(csv[0][0]).to eq 'department_id'
  end

  it 'checks csv columns office' do
    csv_content = described_class.generate_csv
    csv = CSV.parse(csv_content)
    expect(csv[0][1]).to eq 'office_id'
  end

  it 'checks csv columns number' do
    csv_content = described_class.generate_csv
    csv = CSV.parse(csv_content)
    expect(csv[0][2]).to eq 'number'
  end

  it 'checks csv columns last_name' do
    csv_content = described_class.generate_csv
    csv = CSV.parse(csv_content)
    expect(csv[0][3]).to eq 'last_name'
  end

  it 'checks csv columns first_name' do
    csv_content = described_class.generate_csv
    csv = CSV.parse(csv_content)
    expect(csv[0][4]).to eq 'first_name'
  end

  it 'checks csv columns account' do
    csv_content = described_class.generate_csv
    csv = CSV.parse(csv_content)
    expect(csv[0][5]).to eq 'account'
  end

  it 'checks csv columns email' do
    csv_content = described_class.generate_csv
    csv = CSV.parse(csv_content)
    expect(csv[0][6]).to eq 'email'
  end

  it 'checks csv columns date_of_joining' do
    csv_content = described_class.generate_csv
    csv = CSV.parse(csv_content)
    expect(csv[0][7]).to eq 'date_of_joining'
  end
end
