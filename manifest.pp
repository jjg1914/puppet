node jglynn-arch {
  package { "vim": ensure => latest }
  package { "git": ensure => latest }
  package { "zsh": ensure => latest }
  package { "tmux": ensure => latest }
  package { "openssh": ensure => latest }
  
  service { "sshd": ensure => running }

  group { "sudo":
    ensure => present,
    system => true,
  }

  file { "/tmp/sudoers":
    content => "%sudo	ALL=(ALL) NOPASSWD: ALL",
    owner => "root",
    group => "root",
    mode => "0440",
    require => Group["sudo"],
  }

  exec { "sudoers":
    command => "/usr/bin/visudo -cf /tmp/sudoers",
    require => File["/tmp/sudoers"]
  }

  file { "/etc/sudoers":
    source => "file:///tmp/sudoers",
    owner => "root",
    group => "root",
    mode => "0440",
    require => Exec["sudoers"],
  }

  user { "jglynn":
    ensure => present,
    uid => 1000,
    gid => "users",
    groups => "sudo",
    shell => "/bin/bash",
    home => "/home/jglynn",
    comment => "John J. Glynn IV",
    managehome => true,
    require => Group["sudo"],
  }

  file { "/home/jglynn":
    ensure => directory,
    owner => "jglynn",
    group => "users",
    mode => "0750",
    require => User["jglynn"],
  }
}
