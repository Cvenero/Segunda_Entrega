#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
#LOGIN
my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');

my $user = $q->param('user');
my $password = $q->param('password');

if(defined($user) and defined($password)){
  if(checkLogin($user, $password)){
    #successLogin();
  }else{
    showLogin('Usuario o contraseña equivocados, vuela a intentarlo');
  }
}else{
  #showLogin()
  print <<XML;
  <?xml version='1.0'encoding='utf-8'>
}
sub checkLogin{
  my $userQuery = $_[0];
  my $passwordQuery = $_[1];

  my $user = 'alumno';
  my $password = 'pweb1';
  my $dsn = 'DBI:MariaDB:database=pweb1;host=localhost';
  my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");

  my $sql = "SELECT * FROM Users WHERE userName=? AND password=?";
  my $sth = $dbh->prepare($sql);
  $sth->execute($userQuery, $passwordQuery);
  my @row = $sth->fetchrow_array;
print <<XML;
  <?xml version='1.0' encoding='utf-8'>
  <user>
   <owner>$row[0]</owner>
   <firstName>$row[3] </firstName>
   <lastName>$row[2]</lastName>
  </user>
XML
  $sth->finish;
  $dbh->disconnect;
  return @row;
}

sub successLogin{
print <<XML;
  <?xml version='1.0' encoding='utf-8'>
  <user>
   <owner>$user</owner>
   <firstName>$_[0] </firstName>
   <lastName></lastName>
  </user>
XML
}
sub showLogin{
  my $error = $_[0];
  my $body = << "XML";
<user>
</user>
XML
  return $body;
}
