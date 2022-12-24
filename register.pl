#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
#REGISTER
my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');

my $userName = $q->param('user');
my $pass = $q->param('password');
my $first = $q->param('first');
my $last = $q->param('last');

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = 'DBI:MariaDB:database=pweb1;host=localhost';
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");
 
my $sth = $dbh->prepare("SELECT userName FROM Users WHERE userName=?");
$sth->execute($userName);
my @row1 = $sth->fetchrow_array;
$sth->finish;

if(defined($userName) and $userName ne $row1[0]){
  my $sth1 = $dbh->prepare("INSERT INTO Users VALUES (?,?,?,?)");
  $sth1->execute($userName,$pass,$first,$last);

  print "<?xml version='1.0' encoding='utf-8'?>
   <user>
    <owner>$userName</owner>
    <firstName>$first</firstName>
    <lastName>$last</lastName>
   </user>";

  $sth1->finish;
}else{
  print "<?xml version='1.0' encoding='utf-8'?>
  <user>
  </user>";
}
  $dbh->disconnect;
