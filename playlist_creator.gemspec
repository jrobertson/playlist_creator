Gem::Specification.new do |s|
  s.name = 'playlist_creator'
  s.version = '0.1.1'
  s.summary = 'Creates an XML Shareable Playlist Format (XSPF) file from plain text. '
  s.authors = ['James Robertson']
  s.files = Dir['lib/playlist_creator.rb']
  s.add_runtime_dependency('dynarex', '~> 1.8', '>=1.8.27')
  s.add_runtime_dependency('nokogiri', '~> 1.12', '>=1.12.5')
  s.signing_key = '../privatekeys/playlist_creator.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/playlist_creator'
end
