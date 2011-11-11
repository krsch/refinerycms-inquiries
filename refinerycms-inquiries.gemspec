Gem::Specification.new do |s|
  s.name              = %q{refinerycms-inquiries}
  s.version           = %q{1.0.1}
  s.date              = %q{2011-07-19}
  s.summary           = %q{Inquiry handling functionality for the Refinery CMS project.}
  s.description       = %q{Inquiry handling functionality extracted from Refinery CMS to allow you to have a contact form and manage inquiries in the Refinery backend.}
  s.homepage          = %q{http://refinerycms.com}
  s.email             = %q{info@refinerycms.com}
  s.authors           = ["Resolve Digital", "at8eqeq3"]
  s.require_paths     = %w(lib)

  s.files             = [
    'refinerycms-inquiries.gemspec',
    'app',
    'app/controllers',
    'app/controllers/inquiries_controller.rb',
    'app/controllers/admin',
    'app/controllers/admin/inquiries_controller.rb',
    'app/controllers/admin/inquiry_settings_controller.rb',
    'app/views',
    'app/views/inquiries',
    'app/views/inquiries/thank_you.html.erb',
    'app/views/inquiries/new.html.erb',
    'app/views/inquiry_mailer',
    'app/views/inquiry_mailer/confirmation.html.erb',
    'app/views/inquiry_mailer/notification.html.erb',
    'app/views/admin',
    'app/views/admin/inquiries',
    'app/views/admin/inquiries/show.html.erb',
    'app/views/admin/inquiries/_submenu.html.erb',
    'app/views/admin/inquiries/index.html.erb',
    'app/views/admin/inquiries/_inquiry.html.erb',
    'app/views/admin/inquiry_settings',
    'app/views/admin/inquiry_settings/_notification_recipients_form.html.erb',
    'app/views/admin/inquiry_settings/_confirmation_email_form.html.erb',
    'app/views/admin/inquiry_settings/edit.html.erb',
    'app/helpers',
    'app/helpers/inquiries_helper.rb',
    'app/models',
    'app/models/inquiry_setting.rb',
    'app/models/inquiry.rb',
    'app/mailers',
    'app/mailers/inquiry_mailer.rb',
    'spec',
    'spec/models',
    'spec/models/inquiry_spec.rb',
    'features',
    'features/support',
    'features/support/paths.rb',
    'features/support/factories.rb',
    'features/manage_inquiries.feature',
    'features/create_inquiries.feature',
    'features/step_definitions',
    'features/step_definitions/inquiry_steps.rb',
    'lib',
    'lib/gemspec.rb',
    'lib/inquiries.rb',
    'lib/generators',
    'lib/generators/refinerycms_inquiries_generator.rb',
    'lib/refinerycms-inquiries.rb',
    'db',
    'db/migrate',
    'db/migrate/20101208082840_create_inquiries.rb',
    'db/migrate/20110719082646_drop_inquiry_settings_table.rb',
    'db/migrate/20101208082841_remove_position_and_open_from_inquiries.rb',
    'db/seeds',
    'db/seeds/pages_for_inquiries.rb',
    'readme.md',
    'license.md',
    'config',
    'config/locales',
    'config/locales/sk.yml',
    'config/locales/cs.yml',
    'config/locales/bg.yml',
    'config/locales/nl.yml',
    'config/locales/sl.yml',
    'config/locales/sv.yml',
    'config/locales/ru.yml',
    'config/locales/pt-BR.yml',
    'config/locales/zh-CN.yml',
    'config/locales/lt.yml',
    'config/locales/da.yml',
    'config/locales/en-GB.yml',
    'config/locales/it.yml',
    'config/locales/lolcat.yml',
    'config/locales/nb.yml',
    'config/locales/en.yml',
    'config/locales/lv.yml',
    'config/locales/fr.yml',
    'config/locales/de.yml',
    'config/locales/es.yml',
    'config/locales/pl.yml',
    'config/routes.rb'
  ]
  s.require_path = 'lib'

  s.add_dependency('aasm', '~> 2.3.1')
end
