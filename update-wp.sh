#!/bin/bash

paths=()

# find all instance of the config file and push results to the paths array
find /home -name "wp-config.php" -print0 >/tmp/find_results
while IFS=  read -r -d $'\0'; do
    paths+=("$REPLY")
done </tmp/find_results
rm -f /tmp/find_results


# cycle through the paths array
for PATH_STRING in "${paths[@]}"
do
  :

  # remove file name from full path before we proceed
  PATH_STRING=$(dirname ${PATH_STRING})/

  # regex to extract username from path
  re="\/home\/([^/]+)\/"
  if [[ $PATH_STRING =~ $re ]]; then

    # change to correct directory
    cd ${PATH_STRING}

    #echo "Backing up" ${PATH_STRING} "Database..."
    #/usr/bin/sudo -H -u ${BASH_REMATCH[1]} zsh -c '~/.wp-cli/bin/wp db export'

    # prompt user of upgrade
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "$dt -- Running: " ${PATH_STRING}
    echo " ----- ------ ------ "

    # do wp-cli magic
    echo " ----- Updating Specified Plugins ------ "
    echo " ----- ------ ------ "
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp plugin update wordpress-seo wordpress-seo-premium duplicate-post elementor elementor-pro limit-login-attempts-reloaded jupiterx-core wp-rocket contact-form-7 loco-translate uk-cookie-consent really-simple-ssl limit-login-attempts easy-wp-smtp restricted-site-access jet-elements raven wpforms-lite wpforms advanced-custom-fields advanced-custom-fields-pro akismet tablepress wpml-string-translation wpml-translation-management reveal-ids-for-wp-admin-25 sitepress-multilingual-cms total-theme-core gravityforms-multilingual contact-form-7-honeypot classic-editor wordfence cookie-law-info custom-typekit-fonts duplicate-page header-footer-code-manager all-in-one-wp-migration iwp-client loco-translate really-simple-ssl'
    echo " ----- Updating WP Language ------ "
    echo " ----- ------ ------ "
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp language core update'
    echo " ----- Updating Default Themes ------ "
    echo " ----- ------ ------ "
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentyten'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentyeleven'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentytwelve'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentythirteen'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentyfourteen'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentyfifteen'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentysixteen'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentyseventeen'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentynineteen'
    /usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update twentytwenty'

    #/usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp plugin list'
    #/usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp core update-db'
    #/usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp plugin update --all'
    #/usr/bin/sudo -H -u ${BASH_REMATCH[1]} bash -c '/usr/local/bin/wp theme update --all'

  fi

done
