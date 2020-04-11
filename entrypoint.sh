#!/bin/bash
export HUGOSITEDIR=$1
export BUCKET=$2
export ENDPOINT=$3
export ACCESSKEY=$4
export SECRETKEY=$5

# build the site
cd $HUGOSITEDIR
echo 'Bulding your site'
hugo
echo 'Build ready'
echo 'Adding s3 host'
mc config host add s3 $ENDPOINT $ACCESSKEY $SECRETKEY
echo 'Host added'
echo 'Moving data to bucket'
mc cp -r public s3/$BUCKET
echo 'Data copied'
echo 'Making data public'
mc policy set download s3/$BUCKET
echo 'Is public'