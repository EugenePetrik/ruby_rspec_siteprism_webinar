# frozen_string_literal: true

RSpec.describe 'View Profile page' do
  let(:login_page) { LoginPage.new }
  let(:view_profile_page) { ViewProfilePage.new }
  let(:student) { create(:student, :with_courses, courses_count: 3) }

  let(:params_login_data) do
    {
      email: student.email,
      password: student.password
    }
  end

  before do
    login_page.load
    login_page.login_with(params_login_data)
    view_profile_page.load(student_id: student.id)
  end

  context 'when open page', :smoke do
    it { expect(view_profile_page).to be_displayed(student_id: student.id) }
    it { expect(view_profile_page).to be_all_there }
    it { expect(view_profile_page).to be_nav_bar_login_user_visible }
    it { expect(view_profile_page).to be_footer_visible }

    it 'student name is displayed' do
      expect(view_profile_page.user_name.text).to eq(student.name)
    end

    it 'student email is displayed' do
      expect(view_profile_page.user_email.text).to eq(student.email)
    end

    it 'course links are displayed' do
      expect(view_profile_page.course_links.size).to eq(3)
    end

    it 'course names match' do
      course = Course.all
      expect(view_profile_page.courses_links)
        .to match_array([course[0].name, course[1].name, course[2].name])
    end
  end

  context 'when click to the edit profile button' do
    let(:edit_profile_page) { EditProfilePage.new }

    it 'edit profile page is displayed', :smoke do
      view_profile_page.click_to_edit_profile_button

      expect(edit_profile_page).to be_displayed(student_id: student.id)
      expect(edit_profile_page).to be_all_there
      expect(edit_profile_page).to be_nav_bar_login_user_visible
      expect(edit_profile_page).to be_footer_visible
    end
  end
end
