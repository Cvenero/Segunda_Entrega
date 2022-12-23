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

  my $sth1 = $dbh->prepare("SELECT owner,text FROM Articles WHERE owner=? AND title=?");
  $sth1->execute($owner,$title); 
  my @row = $sth1->fetchrow_array;

  if($row[1] =~ /^\#{1}(\s.*)/){
    print "<h1>$1</h1>";
  }
  elsif($row[1] =~ /^\#{6}(\s.*)/){
    print "<h6>$1</h6>";
  }
  elsif($row[1] =~ /^(\*{2})(\w.*)(\*{2})$/){
    print "<p><strong>$2</strong></p>";
  }

  $sth1->finish;

  $dbh->disconnect;
  

