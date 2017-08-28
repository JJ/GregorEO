#!/usr/bin/env perl

use 5.014;

use strict;
use warnings;

use Scalar::Util qw(
		     blessed
		  );
use Try::Tiny;

use Kafka qw(
	      $BITS64
	   );
use Kafka::Connection;
use Kafka::Producer;
use Kafka::Consumer;

# A simple example of Kafka usage

# common information
say 'This is Kafka package ', $Kafka::VERSION;
say 'You have a ', $BITS64 ? '64' : '32', ' bit system';

my ( $connection, $producer, $consumer );
try {
  
  #-- Connect to local cluster
  $connection = Kafka::Connection->new( host => 'localhost' );
  #-- Producer
  $producer = Kafka::Producer->new( Connection => $connection );
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
