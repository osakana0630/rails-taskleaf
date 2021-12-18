require 'rails_helper'

RSpec.describe Task, type: :model do
  it '名前が30字以内の場合は有効な状態になること' do
    task = FactoryBot.build(:task, name: "t" * 30)
    task.valid?
    expect(task).to be_valid
  end

  it '名前が存在しない場合は無効な状態になること' do
    task = FactoryBot.build(:task, name: nil)
    task.valid?
    expect(task.errors[:name]).to include('を入力してください')
  end

  it '名前が30字を超える場合は無効な状態になること' do
    task = FactoryBot.build(:task, name: "t" * 31)
    task.valid?
    expect(task.errors[:name]).to include('は30文字以内で入力してください')
  end

  it '名前にカンマが含まれている場合は無効な状態になること' do
    task = FactoryBot.build(:task, name: 'Test,User')
    task.valid?
    expect(task.errors[:name]).to include('にカンマを含めることはできません')
  end
end
