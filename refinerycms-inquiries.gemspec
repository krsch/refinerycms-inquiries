Gem::Specification.new do |s|
  s.name              = %q{refinerycms-inquiries}
  s.version           = %q{1.0.1}
  s.date              = %q{2011-11-25}
  s.summary           = %q{Inquiry handling functionality for the Refinery CMS project.}
  s.description       = %q{Inquiry handling functionality extracted from Refinery CMS to allow you to have a contact form and manage inquiries in the Refinery backend.}
  s.homepage          = %q{http://refinerycms.com}
  s.email             = %q{info@refinerycms.com}
  s.authors           = ["Resolve Digital", "at8eqeq3", "krsch"]
  s.require_paths     = %w(lib)

  s.files             = [
    'db',
    'db/migrate',
    'db/migrate/20111125232000_create_inquiries.rb',
    'db/migrate/20111125232020_drop_inquiry_settings_table.rb',
    'db/migrate/20111125232010_remove_position_and_open_from_inquiries.rb',
    'db/seeds',
    'db/seeds/pages_for_inquiries.rb',
    'features',
    'features/create_inquiries.feature',
    'features/step_definitions',
    'features/step_definitions/inquiry_steps.rb',
    'features/support',
    'features/support/factories.rb',
    'features/support/paths.rb',
    'features/manage_inquiries.feature',
    'readme.md',
    'spec',
    'spec/models',
    'spec/models/inquiry_spec.rb',
    'license.md',
    'refinerycms-inquiries.gemspec',
    'config',
    'config/locales',
    'config/locales/it.yml',
    'config/locales/pt-BR.yml',
    'config/locales/pl.yml',
    'config/locales/sk.yml',
    'config/locales/zh-CN.yml',
    'config/locales/de.yml',
    'config/locales/es.yml',
    'config/locales/lv.yml',
    'config/locales/lt.yml',
    'config/locales/cs.yml',
    'config/locales/nb.yml',
    'config/locales/nl.yml',
    'config/locales/fr.yml',
    'config/locales/en.yml',
    'config/locales/sv.yml',
    'config/locales/da.yml',
    'config/locales/lolcat.yml',
    'config/locales/en-GB.yml',
    'config/locales/bg.yml',
    'config/locales/sl.yml',
    'config/locales/ru.yml',
    'config/routes.rb',
    'lib',
    'lib/refinerycms-inquiries.rb',
    'lib/generators',
    'lib/generators/refinerycms_inquiries_generator.rb',
    'lib/inquiries.rb',
    'lib/gemspec.rb',
    'app',
    'app/models',
    'app/models/inquiry_setting.rb',
    'app/models/inquiry_category.rb',
    'app/models/inquiry.rb',
    'app/mailers',
    'app/mailers/inquiry_mailer.rb',
    'app/views',
    'app/views/inquiries',
    'app/views/inquiries/thank_you.html.erb',
    'app/views/inquiries/new.html.erb',
    'app/views/inquiries/show.html.erb',
    'app/views/inquiries/_inquiry.html.erb',
    'app/views/inquiries/index.html.erb',
    'app/views/admin',
    'app/views/admin/inquiry_settings',
    'app/views/admin/inquiry_settings/_notification_recipients_form.html.erb',
    'app/views/admin/inquiry_settings/_confirmation_email_form.html.erb',
    'app/views/admin/inquiry_settings/edit.html.erb',
    'app/views/admin/inquiries',
    'app/views/admin/inquiries/show.html.erb',
    'app/views/admin/inquiries/_inquiry.html.erb',
    'app/views/admin/inquiries/_submenu.html.erb',
    'app/views/admin/inquiries/index.html.erb',
    'app/views/admin/inquiries/edit.html.erb',
    'app/views/inquiry_mailer',
    'app/views/inquiry_mailer/notification.html.erb',
    'app/views/inquiry_mailer/confirmation.html.erb',
    'app/views/inquiry_mailer/change_notification.html.erb',
    'app/controllers',
    'app/controllers/admin',
    'app/controllers/admin/inquiry_settings_controller.rb',
    'app/controllers/admin/inquiry_categories_controller.rb',
    'app/controllers/admin/inquiries_controller.rb',
    'app/controllers/inquiries_controller.rb',
    'app/helpers',
    'app/helpers/inquiries_helper.rb',
    'public/stylesheets/inquiries.css'
  ]
  s.require_path = 'lib'

  s.add_dependency('aasm', '~> 2.3.1')
end
