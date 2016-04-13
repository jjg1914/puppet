node jglynn-arch {
  package { "vim": ensure => latest }
  package { "git": ensure => latest }
  package { "zsh": ensure => latest }
  package { "tmux": ensure => latest }
  package { "openssh": ensure => latest }
  
  service { "sshd": ensure => running }

  user { "jglynn":
    ensure => present,
    uid => 1000,
    gid => "users",
    shell => "/bin/bash",
    home => "/home/jglynn",
    comment => "John J. Glynn IV",
    managehome => true,
  }

  file { "/home/jglynn":
    ensure => directory,
    owner => "jglynn",
    group => "users",
    mode => "0750",
    require => [ User["jglynn"] ],
  }
}
