require 'rails_helper'

RSpec.describe User, type: :model do
  it '名前、メール、パスワードがが存在する場合は有効な状態であること' do
    user = FactoryBot.build(:user)
    user.valid?
    expect(user).to be_valid
  end

  it '名前が存在しない場合は無効な状態であること' do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it 'emailが重複している場合は無効な状態であること' do
    FactoryBot.create(:user, name: 'test1user', email: "test@test.com")
    user = FactoryBot.build(:user, name: 'test2user', email: "test@test.com")
    user.valid?
    expect(user.errors[:email]).to include('はすでに存在します')
  end

  it 'パスワードが存在しない場合は無効な状態であること' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
end
