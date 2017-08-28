#!/usr/bin/env perl

use 5.014;

use strict;
use warnings;

use Scalar::Util qw(
		     blessed
		  );
use Try::Tiny;
use Data::Dumper;

use Kafka;
use Kafka::Connection;
use Kafka::Producer;
use Kafka::Consumer;

# A simple example of Kafka usage

# common information
say 'This is Kafka package ', $Kafka::VERSION;

my ( $connection, $producer, $consumer );
try {
  
  #-- Connect to local cluster
  $connection = Kafka::Connection->new( host => 'localhost' );
  #-- Producer
  $producer = Kafka::Producer->new( Connection => $connection );
  my $response = $producer->send("gregoreo", 0, "0001111000" );
  say Dumper($response);
  #-- Consumer
  $consumer = Kafka::Consumer->new( Connection  => $connection );
  
} catch {
  my $error = $_;
  if ( blessed( $error ) && $error->isa( 'Kafka::Exception' ) ) {
    warn 'Error: (', $error->code, ') ',  $error->message, "\n";
    exit;
  } else {
    die $error;
  }
};

# cleaning up
undef $consumer;
undef $producer;
$connection->close;
undef $connection;
