source .env

f=llm-starter

cd ../.. # cd just outside the repo
tar --exclude='.git' \
    --exclude='.idea'  \
    -czvf ${f}.tar.gz $f

USER=${CHTC_USER}
HOSTNAME="ap2001.chtc.wisc.edu"

echo "Transferring to CHTC: ${USER} to ${HOSTNAME}"

scp ${f}.tar.gz ${USER}@${HOSTNAME}:/staging/${USER}
rm ${f}.tar.gz