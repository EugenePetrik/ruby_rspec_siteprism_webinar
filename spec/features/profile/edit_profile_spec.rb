# frozen_string_literal: true

RSpec.describe 'Edit Profile page', type: :feature do
  let(:login_page) { LoginPage.new }
  let(:view_profile_page) { ViewProfilePage.new }
  let(:edit_profile_page) { EditProfilePage.new }

  let(:student) { create(:student) }

  let(:password) { Faker::Internet.password }

  let(:params_login_data) do
    {
      email: student.email,
      password: student.password
    }
  end

  let(:params_student_data) do
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      pass: password,
      pass_confirm: password
    }
  end

  before do
    login_page.load
    login_page.login_with(params_login_data)
    edit_profile_page.load(student_id: student.id)
  end

  context 'when open page', :smoke do
    it { expect(edit_profile_page).to be_displayed(student_id: student.id) }
    it { expect(edit_profile_page).to be_all_there }
    it { expect(edit_profile_page).to be_nav_bar_login_user_visible }
    it { expect(edit_profile_page).to be_footer_visible }
  end

  context 'with valid data' do
    it 'profile saved', :smoke do
      edit_profile_page.edit_profile_with(params_student_data)

      expect(view_profile_page).to be_displayed(student_id: student.id)
      expect(view_profile_page).to be_all_there
      expect(view_profile_page).to have_content(I18n.t('students.update.success_updated_profile'))
      expect(view_profile_page.user_name.text).to eq(params_student_data[:name])
      expect(view_profile_page.user_email.text).to eq(params_student_data[:email])
    end
  end

  context 'without editing password' do
    it 'profile saved', :smoke do
      edit_profile_page.edit_profile_with(params_student_data)

      expect(view_profile_page).to have_content(I18n.t('students.update.success_updated_profile'))
      expect(view_profile_page.user_name.text).to eq(params_student_data[:name])
      expect(view_profile_page.user_email.text).to eq(params_student_data[:email])
    end
  end

  context 'without name' do
    it 'raises an error' do
      params_student_data[:name] = '  '

      edit_profile_page.edit_profile_with(params_student_data)

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_is_blank'))
      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_short'))
    end
  end

  context 'with too long name' do
    it 'raises an error' do
      params_student_data[:name] = Faker::Lorem.characters(number: rand(51..100))

      edit_profile_page.edit_profile_with(params_student_data)

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_long'))
    end
  end

  context 'with too short name' do
    it 'raises an error' do
      params_student_data[:name] = Faker::Lorem.characters(number: rand(1..4))

      edit_profile_page.edit_profile_with(params_student_data)

      expect(view_profile_page).to have_content(I18n.t('errors.student.name_too_short'))
    end
  end

  context 'without email' do
    it 'raises an error' do
      params_student_data[:email] = '  '

      edit_profile_page.edit_profile_with(params_student_data)

      expect(view_profile_page).to have_content(I18n.t('errors.student.email_is_blank'))
      expect(view_profile_page).to have_content(I18n.t('errors.student.invalid_email'))
    end
  end

  context 'with invalid email' do
    it 'raises an error' do
      params_student_data[:email] = "#{Faker::Internet.username}@#{Faker::Internet.domain_word}"

      edit_profile_page.edit_profile_with(params_student_data)

      expect(view_profile_page).to have_content(I18n.t('errors.student.invalid_email'))
    end
  end

  context 'with different password and password confirmation' do
    it 'raises an error' do
      params_student_data[:pass_confirm] = Faker::Internet.password

      edit_profile_page.edit_profile_with(params_student_data)

      expect(view_profile_page).to have_content(I18n.t('errors.student.pass_does_not_match'))
    end
  end
end
