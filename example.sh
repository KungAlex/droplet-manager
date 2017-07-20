!/bin/bash

title="Use Digital ocean API-Example"
prompt="Select an option:"
options=("show API Token" "list Droplets" "create new Droplet" "ping all" "start Deployment")

cat <<EOF
#######################################
###          WELCOME                ###
###  To Droplet Manger for          ###
###       Digitalocean v.0.1        ###
###                                 ###
###  TODO: readme.md                ###
###  export TOKEN=XXX               ###
###  export SSH_FINGER_PRINT=XXX    ###
###                                 ###
### -----------KUNGF.OOO----------- ###
#######################################
EOF

echo "$title"

PS3="$prompt "
select opt in "${options[@]}" "Quit"; do

    case "$REPLY" in

    1 ) echo $TOKEN;;
    2 ) http -v GET https://api.digitalocean.com/v2/droplets "Authorization:Bearer $TOKEN";;
    3 ) http -v POST https://api.digitalocean.com/v2/droplets "Authorization:Bearer $TOKEN" name=Ansible-test region=fra1 size=512mb image=ubuntu-16-04-x64 ssh_keys:='["'$SSH_FINGER_PRINT'"]';;
    4 ) ansible -i hosts -m ping all;;  ##&& ansible-playbook playbook.yml -i hosts;;
    5 ) ansible-playbook playbook.yml -i hosts;;


    ## TODO Destroy
    ## TODO Generate ansible hosts file
    ## TODO INFO by ID http -v GET https://api.digitalocean.com/v2/droplets/51937454 "Authorization:Bearer $TOKEN"

    $(( ${#options[@]}+1 )) ) echo "Exit!"; break;;

    *) echo "Invalid option.";continue;;
    esac

done
