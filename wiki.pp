package {
    'apache2':
    ensure => present;

    'php7.3':
    ensure => present;

}


exec { 

    'téléchargement de dokuwiki':
    path    => ['/usr/bin'],
    command => 'wget -O /usr/src/dokuwiki.tgz \
  https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz ';
  
    
    'Décompresser le dossier':
    path    => ['/usr/bin'],
    cwd     => '/usr/src',
    command => 'tar -xavf dokuwiki.tgz';
  
    'renommer le fichier':
    path    => ['/usr/bin'],
    cwd     => '/usr/src',
    command => 'mv dokuwiki-* dokuwiki';

}
