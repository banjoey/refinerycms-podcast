# Podcasts engine for Refinery CMS.
    Updated by Joey Barkley. Engine now reads
    information from mp3 file and saves title,
    author, and description fields automatically
    if fields are blank on the form.

## How to build this engine as a gem

    cd vendor/engines/podcasts
    gem build refinerycms-podcasts.gemspec
    gem install refinerycms-podcasts.gem
    
    # Sign up for a http://rubygems.org/ account and publish the gem
    gem push refinerycms-podcasts.gem

## After install
    rails generate acts_as_taggable_on:migration