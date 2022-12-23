#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');
#delete.pl
my $owner = $q->param('owner');
my $title = $q->param('title');

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = 'DBI:MariaDB:database=pweb1;host=localhost';
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");

my $sth = $dbh->prepare("SELECT owner, title FROM Articles WHERE owner=? AND title=?");
$sth->execute($owner,$title);
my @row = $sth->fetchrow_array;
$sth->finish;

if($owner = $row[0] and $title = $row[1]){
  my $sth1 = $dbh->prepare("DELETE FROM Articles WHERE owner=? AND title=?");
  $sth1->execute($owner,$title); 

    print "<?xml version='1.0' encoding='utf-8'?>
    <article>
      <article>
        <owner>$owner</owner>
        <title>$title</title>
        </article>";
  print "</article>";
  $sth1->finish;
  }
  else{
  print "<?xml version='1.0' encoding='utf-8'?>
    <article>
    </article>";
  }
  $dbh->disconnect;
  

