use Module::Build;
my $build = Module::Build->new
  (
   module_name => 'Teamspeak',
   license => 'perl',
   requires => {
                'perl'           => '5.004',
                },
                recommends => {
                'Net::Telnet'   => '',
                'DBI'  => '',
                'DBD::mysql'  => '',
                'DBD::SQLite'  => '',
               },
  );
$build->create_build_script;

=head1 VERSION

$Id$

$URL$

=cut

