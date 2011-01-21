require 'bundler'
Bundler::GemHelper.install_tasks

require "rubygems"
gem 'hoe', '>= 2.1.0'
require 'hoe'

Hoe.plugins.delete :rubyforge
Hoe.plugin :minitest #gem install hoe-seattlerb
Hoe.plugin :gemspec  #gem install hoe-gemspec

Hoe.spec 'levene' do
  developer('Robert Rasmussen', 'rob.rasmussen@gmail.com')

  self.readme_file      = 'README.markdown'
  self.extra_rdoc_files = FileList['README.markdown']

  self.extra_deps << [ 'activemodel', '>=3.0.3' ]
  self.extra_deps << [ 'activesupport', '>=3.0.3' ]
  self.extra_deps << [ 'rforce', '~>0.6.0' ]

  self.extra_dev_deps << [ 'nokogiri', '>=1.4.4' ]
end

