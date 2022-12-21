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
    my @row = checkLogin($user, $password);
   print "<?xml version='1.0' encoding='utf-8'?>
   <user>
   <owner>$row[0]</owner>
    <firstName>$row[3]</firstName>
    <lastName>$row[2]</lastName>
   </user>";
   # print $info[0]; 
  }else{
  print "<?xml version='1.0' encoding='utf-8'?>
  <user>
  </user>";
  }
}else{
  print "<?xml version='1.0' encoding='utf-8'?>
  <user>
  </user>";
  
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
  # print "<?xml version='1.0' encoding='utf-8'?>
  # <user>
  # <owner>$row[0]</owner>
   # <firstName>$row[3]</firstName>
   # <lastName>$row[2]</lastName>
   # </user>";
  $sth->finish;
  $dbh->disconnect;
  return @row;
}
#sub successLogin{
#print "<?xml version='1.0' encoding='utf-8'?>
# <user>
# <owner>$row[0]</owner>
# <firstName>$row[3]</firstName>
# <lastName>$row[2]</lastName>
# </user>"; 
#}
#sub showLogin{
# my $body = << "XML";
# <?xml version='1.0' encoding='utf-8'>
# <user>
# </user>
#XML
# return $body;
#}
