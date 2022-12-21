#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');

my $user = $q->param('user');
my $password = $q->param('password');

if(defined($user) and defined($password)){
  if(checkLogin($user, $password)){
    successLogin();
  }else{
    showLogin('Usuario o contraseña equivocados, vuela a intentarlo');
  }
}else{
  showLogin()
}
sub checkLogin{
  my $userQuery = $_[0];
  my $passwordQuery = $_[1];

  my $user = 'alumno';
  my $password = 'pweb1';
  my $dsn = 'DBI:MariaDB:database=pweb1;host=localhost';
  my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");

  my $sql = "SELECT * FROM login WHERE username=? AND passwd=?";
  my $sth = $dbh->prepare($sql);
  $sth->execute($userQuery, $passwordQuery);
  my @row = $sth->fetchrow_array;
  $sth->finish;
  $dbh->disconnect;
  return @row;
}

sub successLogin{
  my $body=<<"HTML";
    <h1>Bienvenido</h1>
HTML
  print(renderBody("Sistema", "", $body));
}
sub showLogin{
  my $error = $_[0];
  my $body = << "XML";
XML
  print(renderBody("Login", "", $body));
}
sub renderBody{
  my $title = $_[0];
  my $css = $_[1];
  my $body = $_[2];

  my $xml = << "XML";
<?xml version='1.0' encoding='utf-8'?>

XML
  return $xml;
}
