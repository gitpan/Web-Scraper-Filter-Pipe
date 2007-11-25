use inc::Module::Install;
include 'Module::AutoInstall';

name 'Web-Scraper-Filter-Pipe';
all_from 'lib/Web/Scraper/Filter/Pipe.pm';
perl_version '5.006';

requires 'Test::Base';
requires 'Text::Pipe' => '0.06';
requires 'Web::Scraper' => '0.22';

build_requires 'Test::More' => '0.70';

process_templates(
    first_year => 2007,
    rest_from  => "$ENV{HOME}/.mitlib/standard_pod",
    start_tag  => '{%',
    end_tag    => '%}',
);

use_standard_tests(without => 'pod_coverage');
auto_install;
auto_include;
WriteAll;
