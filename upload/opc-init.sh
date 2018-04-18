#       NAME
#       opc-init.sh
#
#    DESCRIPTION
#      Script used to inject the public keys into .ssh directory.
#
exec > /var/log/opc-compute/opc-init.log 2>&1

mkdir /home/opc/.ssh

keysfound=1
retries=1

while [ $keysfound -ne 0 ] && [ $retries -lt 3 ] ; do
    # Use curl to get the key list
    echo "Checking http://192.0.0.192/latest/meta-data/public-keys/...."
    curl -m 5 http://192.0.0.192/latest/meta-data/public-keys/ > /root/keylist
    # Check if the curl command was successful and the file was not empty
    if [ $? -eq 0 ] && [ -s /root/keylist ] ; then
        grep 'No such' /root/keylist
        if [ $? -ne 0 ] ; then
            keysfound=0
        fi
    fi
    retries=`expr ${retries} + 1`
done

if [ $keysfound -eq 0 ] ; then
    cat /root/keylist | while read line ; do
        # metadata service is working, so the URL will have data
        curl -m 5 http://192.0.0.192/latest/meta-data/public-keys/${line}/openssh-key/ >> /home/opc/.ssh/authorized_keys
        echo "" >> /home/opc/.ssh/authorized_keys
    done
fi

chown -R opc:opc /home/opc/.ssh
chmod 0700 /home/opc/.ssh
chmod 0600 /home/opc/.ssh/authorized_keys

restorecon -R -v /home/opc/.ssh
