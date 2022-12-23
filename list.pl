#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');
#list.pl
my $owner = $q->param('owner');

  my $user = 'alumno';
  my $password = 'pweb1';
  my $dsn = 'DBI:MariaDB:database=pweb1;host=localhost';
  my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");

if(defined($owner)){
  my $sth1 = $dbh->prepare("SELECT owner,title FROM Articles WHERE owner=?");
  $sth1->execute($owner); 
  my @row = $sth1->fetchrow_array;
  if($owner = $row[0] ){
    print "<?xml version='1.0' encoding='utf-8'?>
    <article>
      <article>
        <owner>$row[0] </owner>
        <title>$row[1]</title>
        </article>";
    while(@row = $sth1->fetchrow_array){
      print "<article>
        <owner>$row[0] </owner>
        <title>$row[1]</title>
        </article>
        ";
    }  
  print "</article>";
  }else{
    print "<?xml version='1.0' encoding='utf-8'?>
      <article>
      </article>";
  }
  $sth1->finish;
  }else{
  print "<?xml version='1.0' encoding='utf-8'?>
    <article>
    </article>";
  }
  $dbh->disconnect;
  

