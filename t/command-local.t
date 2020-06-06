use Mojolicious::Command::proxy;
use Mojolicious::Lite;
use Test::Mojo;
use Test::More;

get '/subdir/:id' => sub {
  my ($c) = @_;
  $c->render(text => 'ID: '. $c->stash('id'));
};

my $t = Test::Mojo->new;

Mojolicious::Command::proxy->proxy(app, '/proxy', '/subdir');
$t->get_ok('/proxy/2')->content_like(qr/ID: 2/);

done_testing;
