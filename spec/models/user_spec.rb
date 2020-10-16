require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nickname,email,password,password_confirmation,first_name,first_name_kana,family_name,family_name_kana,birthdayがあれば登録できること" do
      expect(@user).to be_valid
    end

    it "nicknameが空では登録できないこと" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空では登録できないこと" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "emailに@が含まれていない場合は登録できないこと" do
      @user.email = "abcdefg"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "passwordが空では登録できないこと" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "passwordが6文字以上であれば登録できること" do
      @user.password = "aaa456"
      @user.password_confirmation = "aaa456"
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "aa345"
      @user.password_confirmation = "aa345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "aaa456"
      @user.password_confirmation = "aaa4567"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "passwordが半角英数字混合での入力であれば登録できること" do
      @user.password = "aaa456"
      @user.password_confirmation = "aaa456"
      expect(@user).to be_valid
    end

    it "passwordが半角英数字混合での入力でなければ登録できないこと" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end

    it "passwordが半角英数字混合での入力でなければ登録できないこと" do
      @user.password = "abcdef"
      @user.password_confirmation = "abcdef"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end


    it "first_nameが空では登録できないこと" do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name 全角文字を使用してください")
    end

    it "first_nameは、全角（漢字・ひらがな・カタカナ）での入力であれば登録できること" do
      @user.first_name = "一郎"
      expect(@user).to be_valid
    end

    it "first_nameは、全角（漢字・ひらがな・カタカナ）での入力でなければ登録できないこと" do
      @user.first_name = "ichiro"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
    end

    it "first_name_kanaが空では登録できないこと" do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana 全角（カタカナ）を使用してください")
    end

    it "first_name_kanaは、全角（カタカナ）での入力であれば登録できること" do
      @user.first_name_kana = "イチロウ"
      expect(@user).to be_valid
    end

    it "first_name_kanaは、全角（カタカナ）での入力でなければ登録できないこと" do
      @user.first_name_kana = "一郎"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角（カタカナ）を使用してください")
    end

    it "family_nameが空では登録できないこと"do
      @user.family_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name 全角文字を使用してください")
    end

    it "family_nameは、全角（漢字・ひらがな・カタカナ）での入力であれば登録できること" do
      @user.family_name = "鈴木"
      expect(@user).to be_valid
    end

    it "family_nameは、全角（漢字・ひらがな・カタカナ）での入力でなければ登録できないこと" do
      @user.family_name = "suzuki"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
    
    end

    it "family_name_kanaが空では登録できないこと" do
      @user.family_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank", "Family name kana 全角（カタカナ）を使用してください")
    end

    it "family_name_kanaは、全角（カタカナ）での入力であれば登録できること" do
      @user.family_name = "スズキ"
      expect(@user).to be_valid
    end

    it "family_name_kanaは、全角（カタカナ）での入力でなければ登録できないこと" do
      @user.family_name_kana = "鈴木"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角（カタカナ）を使用してください")
    end

    it "birthdayが空では登録できないこと" do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

  end

end
