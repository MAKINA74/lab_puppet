file { 'hello':
  path => '/tmp/hello',
  ensure => present,
  content => 'Hello World',
  owner => 'root',
  group => 'root',
  mode => '0600';

}
 
