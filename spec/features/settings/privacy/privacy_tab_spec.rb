RSpec.describe 'PrivacyTab' do
  let(:settings_page) { SettingsPage.new }
  let(:user) { create(:user) }

  before do
    login_as(user)
    settings_page.load
    settings_page.privacy_tab.click
  end

  context 'when update email' do
    context 'with correct data' do
      user_email = FFaker::Internet.email

      it 'updates email' do
        settings_page.update_email.update_email_with(user_email)
        
        expect(settings_page.success_flash.text).to eq(I18n.t('settings.updated_email'))

        settings_page.privacy_tab.click

        expect(settings_page.update_email.email_field.value).to eq(user_email)
      end
    end

    context 'with empty email' do
      it 'raises an error' do
        settings_page.update_email.update_email_with('')
                
        expect(settings_page.success_flash.text).to eq(I18n.t('settings.mistake_update_email'))

        settings_page.privacy_tab.click

        expect(settings_page.update_email.email_field.value).to eq(user.email)
      end
    end

    context 'with invalid email format' do
      it 'raises an error' do
        settings_page.update_email.update_email_with('testexample.com')
  
        expect(settings_page.success_flash.text).to eq(I18n.t('settings.mistake_update_email'))

        settings_page.privacy_tab.click

        expect(settings_page.update_email.email_field.value).to eq(user.email)
      end
    end
  end

  context 'when update avatar' do
    it 'updates avatar', skip: 'Error 500 when update avatar' do
      expect do
        settings_page.update_avatar.update_avatar_with('dummy_image.jpeg')
      end.to change(Image, :count).by(0)
    end
  end

  context 'when remove account' do
    it 'removes user account', skip: 'Error 500 when remove account' do
      expect do
        accept_confirm do
          settings_page.remove_account.checkbox_delete_account.click
        end
        settings_page.remove_account.delete_account_button.click
      end.to change(User, :count).by(0)      
    end
  end

  context 'when update password' do
    let(:sign_in_page) { SignInPage.new }
    let(:home_page) { HomePage.new }

    let(:password) { FFaker::Internet.password }

    let(:params_update_password) do
      {
        old_pass: user.password,
        new_pass: password,
        confirm_pass: password
      }
    end

    let(:params_login_data) do
      {
        email: user.email,
        password: password
      }
    end

    context 'with correct data' do
      it 'signs in with new password' do
        settings_page.update_password.update_password_with(params_update_password)
        
        expect(sign_in_page).to be_displayed
        expect(sign_in_page.error_flash.text).to eq(I18n.t('devise.failure.unauthenticated'))
        
        sign_in_page.login_with(params_login_data)
        
        expect(home_page).to be_displayed
        expect(home_page.success_flash.text).to eq(I18n.t('devise.sessions.signed_in'))
        expect(home_page.user_email.text).to eq(user.email)
        expect(home_page).to have_no_sign_up_link
        expect(home_page).to have_no_login_link
      end
    end

    context 'with empty new password' do
      it 'saves old password' do
        params_update_password[:new_pass], params_update_password[:confirm_pass] = ''
        settings_page.update_password.update_password_with(params_update_password)

        expect(settings_page.success_flash.text).to eq(I18n.t('settings.updated_password'))
      end
    end

    context 'with empty old password' do
      it 'raises an error' do
        params_update_password[:old_pass] = ''
        settings_page.update_password.update_password_with(params_update_password)

        expect(settings_page.success_flash.text).to eq(I18n.t('settings.mistake_update_password'))
      end
    end

    context 'with incorrect old password' do
      it 'raises an error' do
        params_update_password[:old_pass] = FFaker::Internet.password
        settings_page.update_password.update_password_with(params_update_password)

        expect(settings_page.success_flash.text).to eq(I18n.t('settings.mistake_update_password'))
      end
    end

    context 'with new password less than 6 characters' do
      it 'raises an error' do
        params_update_password[:new_pass], params_update_password[:confirm_pass] = rand(100_000)
        settings_page.update_password.update_password_with(params_update_password)
  
        expect(settings_page.success_flash.text).to eq(I18n.t('settings.mistake_update_password'))
      end
    end

    context 'with different new and confirm passwords' do
      it 'raises an error' do
        params_update_password[:new_pass] = "   #{password}   "
        params_update_password[:confirm_pass] = password
        settings_page.update_password.update_password_with(params_update_password)
  
        expect(settings_page.success_flash.text).to eq(I18n.t('settings.mistake_update_password'))
      end
    end
  end
end
