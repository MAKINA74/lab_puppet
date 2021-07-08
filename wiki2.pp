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
   ensure  => 'present',
   source  => '/usr/src/dokuwiki-2020-07-29',
   path    => '/usr/src/dokuwiki',
   require => Exec['Décompresser le dossier'];

}



file { '/var/www/recettes-wiki':
   ensure => 'directory',
   mode   => '0755',
   owner  => 'www-data',
   group  => 'www-data';
}



exec { 
   'copier dokuwiki dans le site':
   path    => ['/usr/bin', '/usr/sbin'],
   cwd     => '/usr/src/',
   command => 'rsync -av /usr/src/dokuwiki/ /var/www/recettes-wiki';
}

exec {
   'start recette-wiki'
   require => Package['apache2'],
   path    => ['usr/bin', '/usr/sbin'],
   command => 'a2ensite recettes-wiki.conf';
 

}



file {
  "/etc/apache2/sites-available/recettes-wiki.conf":

   ensure  => present,
   owner   => root, group => root,
   content  => '<VirtualHost *:80>
        ServerName recettes-wiki
        ServerAdmin unidan@example.com

        DocumentRoot /var/www/recettes-wiki

        ErrorLog /var/www/example.com/logs/error.log
        CustomLog /var/www/example.com/logs/access.log combined
</VirtualHost>';
 
 # require => Package['apache2'],

}

service {
   "apache2":
   ensure    => running,
   enable    => true,
   require   => Package['apache2'],
   subscribe => Exec['start recette-wiki'];
}



