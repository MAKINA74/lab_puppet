package {
    'apache2':
    ensure => present;

    'php7.3':
    ensure => present;

}



file { 'télécharger dokuwiki':
  ensure         => 'present',
  source         => 'https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz',
  checksum_value => '8867b6a5d71ecb5203402fe5e8fa18c9',
  path           => '/usr/src/dokuwiki.tgz',

}

exec { 
      
    'Décompresser le dossier':
    path    => ['/usr/bin'],
    cwd     => '/usr/src',
    command => 'tar -xavf dokuwiki.tgz';
  

}


file {
  'rename-dokuwiki':
    ensure => 'present',
    source => '/usr/src/dokuwiki-2020-07-29',
    path   => '/usr/src/dokuwiki';
}
