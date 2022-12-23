#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');
#view.pl
my $owner = $q->param('owner');
my $title = $q->param('title');

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = 'DBI:MariaDB:database=pweb1;host=localhost';
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");

my $sth1 = $dbh->prepare("SELECT owner, title, text FROM Articles WHERE owner=? AND title=?");
  $sth1->execute($owner,$title); 
my @row = $sth1->fetchrow_array;
  
if($owner = $row[0] and $title = $row[1]){
   print "<?xml version='1.0' encoding='utf-8'?>
    <article>
     <owner>$row[0]</owner>
     <title>$row[1]</title>
     <text>$row[2]</text>
    </article>";
}else{
   print "<?xml version='1.0' encoding='utf-8'?>
  <article>
  </article>";
}

$sth1->finish;
$dbh->disconnect;
