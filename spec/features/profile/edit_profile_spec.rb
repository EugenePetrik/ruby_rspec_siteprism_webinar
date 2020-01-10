# frozen_string_literal: true

RSpec.describe 'Edit Profile page', type: :feature do
  let(:login_page) { LoginPage.new }
  let(:view_profile_page) { ViewProfilePage.new }
  let(:edit_profile_page) { EditProfilePage.new }

  let(:student) { create(:student) }
  let(:name) { Faker::Name.name }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  before do
    login_page.load
    login_page.login_with(student.email, student.password)
    edit_profile_page.load(student_id: student.id)
  end

  context 'when open page' do
    it { expect(edit_profile_page).to be_displayed(student_id: student.id) }
    it { expect(edit_profile_page).to be_all_there }
    it { expect(edit_profile_page).to be_nav_bar_login_user_visible }
    it { expect(edit_profile_page).to be_footer_visible }
  end

  context 'with valid data' do
    let(:pass) { Faker::Internet.password }
    let(:params_user_data) do
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        pass: pass,
        pass_confirm: pass
      }
    end

    it 'profile saved' do
      edit_profile_page.edit_profile_with(params_user_data)

      expect(view_profile_page).to be_displayed(student_id: student.id)
      expect(view_profile_page).to be_all_there
      expect(view_profile_page).to have_content(I18n.t('students.update.success_updated_profile'))
      expect(view_profile_page.user_name.text).to eq params_user_data[:name]
      expect(view_profile_page.user_email.text).to eq params_user_data[:email]
    end
  end

  context 'without editing password' do
    let(:params_user_data) { attributes_for(:student) }

    it 'profile saved' do
      edit_profile_page.edit_profile_with(params_user_data)

      expect(view_profile_page).to have_content(I18n.t('students.update.success_updated_profile'))
      expect(view_profile_page.user_name.text).to eq params_user_data[:name]
      expect(view_profile_page.user_email.text).to eq params_user_data[:email]
    end
  end

  context 'without name' do
    let(:empty_student_name) do
      {
        name: '  ',
        email: email,
        password: password
      }
    end

    it 'raises an error' do
      edit_profile_page.edit_profile_with(empty_student_name)

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_is_blank'))
      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_short'))
    end
  end

  context 'with too long name' do
    let(:long_student_name) do
      {
        name: Faker::Lorem.characters(number: rand(51..100)),
        email: email,
        password: password
      }
    end

    it 'raises an error' do
      edit_profile_page.edit_profile_with(long_student_name)

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_long'))
    end
  end

  context 'with too short name' do
    let(:short_student_name) do
      {
        name: Faker::Lorem.characters(number: rand(1..4)),
        email: email,
        password: password
      }
    end

    it 'raises an error' do
      edit_profile_page.edit_profile_with(short_student_name)

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_short'))
    end
  end

  context 'without email' do
    let(:empty_student_email) do
      {
        name: name,
        email: '  ',
        password: password
      }
    end

    it 'raises an error' do
      edit_profile_page.edit_profile_with(empty_student_email)

      expect(view_profile_page).to have_content(I18n.t('errors.student.email_is_blank'))
      expect(view_profile_page).to have_content(I18n.t('errors.student.invalid_email'))
    end
  end

  context 'with invalid email' do
    let(:invalid_student_email) do
      {
        name: name,
        email: "#{Faker::Internet.username}@#{Faker::Internet.domain_word}",
        password: password
      }
    end

    it 'raises an error' do
      edit_profile_page.edit_profile_with(invalid_student_email)

      expect(view_profile_page).to have_content(I18n.t('errors.student.invalid_email'))
    end
  end

  context 'with different password and password confirmation' do
    let(:different_student_passwords) do
      {
        name: name,
        email: "#{Faker::Internet.username}@#{Faker::Internet.domain_word}",
        pass: Faker::Internet.password,
        pass_confirm: Faker::Internet.password
      }
    end

    it 'raises an error' do
      edit_profile_page.edit_profile_with(different_student_passwords)

      expect(view_profile_page).to have_content(I18n.t('errors.student.pass_does_not_match'))
    end
  end
end
