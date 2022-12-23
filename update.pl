#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');
#update.pl
my $owner = $q->param('owner');
my $title = $q->param('title');
my $text = $q->param('text');

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = 'DBI:MariaDB:database=pweb1;host=localhost';
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");

my $sth1 = $dbh->prepare("UPDATE Articles SET text=? WHERE owner=? AND title=?");
  $sth1->execute($text,$owner,$title); 
my $sth = $dbh->prepare("SELECT owner, text FROM Articles WHERE owner=? and title=?");
  $sth->execute($owner,$title);

my @row = $sth->fetchrow_array;
  
if($owner = $row[0] and $title = $row[1]){
   print "<?xml version='1.0' encoding='utf-8'?>
    <article>
     <owner>$row[0]</owner>
     <text>$row[1]</text>
    </article>";
}else{
   print "<?xml version='1.0' encoding='utf-8'?>
  <article>
  </article>";
}
$sth->finish;
$sth1->finish;
$dbh->disconnect;
