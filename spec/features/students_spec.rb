# frozen_string_literal: true

RSpec.describe 'Students page', type: :feature do
  let(:login_page) { LoginPage.new }
  let(:students_page) { StudentsPage.new }
  let(:view_profile_page) { ViewProfilePage.new }

  let!(:student1) { create(:student, courses: [course3, course4, course1]) }
  let!(:student2) { create(:student, courses: [course1, course1]) }
  let!(:student3) { create(:student) }

  let(:course1) { create(:course) }
  let(:course2) { create(:course) }
  let(:course3) { create(:course) }
  let(:course4) { create(:course) }

  let(:params_login_data) do
    {
      email: student1.email,
      password: student1.password
    }
  end

  before do
    login_page.load
    login_page.login_with(params_login_data)
    students_page.load
  end

  context 'when open page', :smoke do
    it { expect(students_page).to be_displayed }
    it { expect(students_page).to be_all_there }
    it { expect(students_page).to be_nav_bar_login_user_visible }
    it { expect(students_page).to be_footer_visible }

    it 'the number of students equal 3' do
      expect(students_page.student_cards.size).to eq(3)
    end

    it 'student ids match' do
      expect(students_page.student_cards_ids)
        .to eq([student1.id, student2.id, student3.id])
    end

    it 'student names match' do
      expect(students_page.student_names.map(&:text))
        .to match_array([student1.name, student2.name, student3.name])
    end
  end

  context 'when open profile page for student without courses' do
    it 'courses are not displayed', skip: 'Flaky test' do
      students_page.open_student_profile_for(student3.id)

      expect(view_profile_page).to be_displayed(student_id: student3.id)
      expect(view_profile_page.user_name.text).to eq(student3.name)
      expect(view_profile_page.user_email.text).to eq(student3.email)
      expect(view_profile_page.course_links.size).to eq(0)
      expect(view_profile_page).to have_content(I18n.t('students.show.none'))
    end
  end

  context 'when open profile page for student with courses' do
    it 'courses are displayed', :smoke do
      students_page.open_student_profile_for(student1.id)

      expect(view_profile_page.course_links.size).to eq(3)
      expect(view_profile_page.course_links.map(&:text))
        .to match_array([course1.name, course3.name, course4.name])
    end
  end

  context 'when open own student profile page' do
    it 'Edit Profile button is displayed', :smoke do
      students_page.open_student_profile_for(student1.id)

      expect(view_profile_page).to have_edit_profile_button
    end
  end

  context 'when open profile page for another student' do
    it 'Edit Profile button is not displayed', :smoke do
      students_page.open_student_profile_for(student2.id)

      expect(view_profile_page).to have_no_edit_profile_button
    end
  end
end
