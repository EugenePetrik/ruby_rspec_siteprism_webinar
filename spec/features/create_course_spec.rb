# frozen_string_literal: true

RSpec.describe 'Create Course page' do
  let(:login_page) { LoginPage.new }
  let(:create_course_page) { CreateCoursePage.new }

  let(:student) { create(:student) }

  let(:name) { Faker::Educator.course_name }
  let(:short_name) { Faker::Lorem.characters(number: (3..15)).upcase }
  let(:description) { Faker::Lorem.paragraph_by_chars(number: rand(10..300)) }

  before do
    login_page.load
    login_page.login_with(student.email, student.password)
    create_course_page.load
  end

  context 'when open page', :smoke do
    it { expect(create_course_page).to be_displayed }
    it { expect(create_course_page).to be_all_there }
    it { expect(create_course_page).to be_nav_bar_login_user_visible }
    it { expect(create_course_page).to be_footer_visible }
  end

  context 'with valid data', :smoke do
    let(:view_course_page) { ViewCoursePage.new }
    let(:course) { attributes_for(:course) }

    it 'course saved' do
      create_course_page.create_course_with(course)

      course_name = course[:name]
      course_description = course[:description]

      expect(view_course_page.flash_message.text).to eq(I18n.t('success_create', course_name: course_name))
      expect(view_course_page.course_title.text).to eq(course_name)
      expect(view_course_page.course_description.text).to eq(course_description)
    end

    it 'creates the record in the database' do
      expect do
        create_course_page.create_course_with(course)
      end.to change(Course, :count).by(1)
    end
  end

  context 'with empty course name' do
    let(:empty_course_name) do
      {
        name: '',
        short_name: short_name,
        description: description
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(empty_course_name)

      expect(create_course_page).to have_content(I18n.t('errors.course.name_is_blank'))
      expect(create_course_page).to have_content(I18n.t('errors.course.name_too_short'))
    end
  end

  context 'with too short course name' do
    let(:short_course_name) do
      {
        name: Faker::Lorem.characters(number: rand(1..4)).upcase,
        short_name: short_name,
        description: description
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(short_course_name)

      expect(create_course_page).to have_content(I18n.t('errors.course.name_too_short'))
    end
  end

  context 'with too long course name' do
    let(:long_course_name) do
      {
        name: Faker::Lorem.characters(number: rand(51..100)).upcase,
        short_name: short_name,
        description: description
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(long_course_name)

      expect(create_course_page).to have_content(I18n.t('errors.course.name_too_long'))
    end
  end

  context 'with empty course short name' do
    let(:empty_course_short_name) do
      {
        name: name,
        short_name: '',
        description: description
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(empty_course_short_name)

      expect(create_course_page).to have_content(I18n.t('errors.course.short_name_is_blank'))
      expect(create_course_page).to have_content(I18n.t('errors.course.short_name_too_short'))
    end
  end

  context 'with too short course short name' do
    let(:short_course_short_name) do
      {
        name: name,
        short_name: Faker::Lorem.characters(number: rand(1..2)).upcase,
        description: description
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(short_course_short_name)

      expect(create_course_page).to have_content(I18n.t('errors.course.short_name_too_short'))
    end
  end

  context 'with too long course short name' do
    let(:long_course_short_name) do
      {
        name: name,
        short_name: Faker::Lorem.characters(number: rand(16..30)).upcase,
        description: description
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(long_course_short_name)

      expect(create_course_page).to have_content(I18n.t('errors.course.short_name_too_long'))
    end
  end

  context 'with empty course description' do
    let(:empty_course_description) do
      {
        name: name,
        short_name: short_name,
        description: ''
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(empty_course_description)

      expect(create_course_page).to have_content(I18n.t('errors.course.desc_is_blank'))
      expect(create_course_page).to have_content(I18n.t('errors.course.desc_too_short'))
    end
  end

  context 'with too short course description' do
    let(:short_course_description) do
      {
        name: name,
        short_name: short_name,
        description: Faker::Lorem.paragraph_by_chars(number: rand(1..9))
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(short_course_description)

      expect(create_course_page).to have_content(I18n.t('errors.course.desc_too_short'))
    end
  end

  context 'with too long course description' do
    let(:long_course_description) do
      {
        name: name,
        short_name: short_name,
        description: Faker::Lorem.paragraph_by_chars(number: rand(301..350))
      }
    end

    it 'raises an error' do
      create_course_page.create_course_with(long_course_description)

      expect(create_course_page).to have_content(I18n.t('errors.course.desc_too_long'))
    end
  end
end
