#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;
print $q->header('text/xml;charset=UTF-8');

my $title = $q->param('title');
my $owner = $q->param('owner');
my $text = $q->param('text');

  my $user = 'alumno';
  my $password = 'pweb1';
  my $dsn = 'DBI:MariaDB:database=pweb1;host=localhost';
  my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");
 
  #my $sth = $dbh->prepare("SELECT owner FROM Articles WHERE owner=?");
  #$sth3->execute()



  if(defined($title) and defined($text)){
    

    my $sql = "INSERT INTO Articles VALUES (?,?,?)";
    my $sth = $dbh->prepare($sql);
    $sth->execute($title, $owner, $text);
    $sth->finish;
  ############################################
    my $sth1 = $dbh->prepare("SELECT title, text, owner FROM Articles WHERE owner=?");
    $sth1->execute($owner); 
    my @row = $sth1->fetchrow_array;
     
  if($owner = $row[2]){
     
    print "<?xml version='1.0' encoding='utf-8'?>
      <article>
        <title>$title</title>
        <text>$text</text>
      </article>
      ";
    $sth1->finish;
    }
    else{
    print "<?xml version='1.0' encoding='utf-8'?>
      <article>
      </article>
      ";
    }
  } 
  else{
  print "<?xml version='1.0' encoding='utf-8'?>
    <article>
    </article>
    ";

  }

  # my $sth1 = $dbh->prepare("SELECT title, text FROM Articles WHERE owner=?");
  #$sth1->execute($owner); 

  #while(my @row = $sth1->fetchrow_array){
  # print "@row\n";
  
  #print "
  # <?xml version='1.0' encoding='utf-8'?>
  # <article>
  #   <title>$row[0] </title>
  #   <text>$row[1]</text>
  # </article>
  # ";
  #}  
  #$sth1->finish;
  
  $dbh->disconnect;
  

