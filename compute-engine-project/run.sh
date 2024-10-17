#apply the google provider
if [ "$1" == "init" ]
then
		echo "Running Init"
		project_id=$(grep "project_id" $2 | grep -o '".*"' | sed 's/"//g')
  	terraform init
		echo "Setting project to $project_id"
		gcloud config set project $project_id
		echo "Enabling APIs:"
		gcloud services enable sqladmin.googleapis.com
		gcloud services enable servicenetworking.googleapis.com
		gcloud services enable container.googleapis.com
		gcloud services enable compute.googleapis.com
		gcloud services enable logging.googleapis.com
		gcloud services enable certificatemanager.googleapis.com
		echo "APIs enabled"
		echo "Init finished"
elif [ "$1" == "plan" ]
then
    terraform plan -compact-warnings -var-file $2
elif [ "$1" == "apply" ]
then
    terraform apply     -compact-warnings -var-file $2
elif [ "$1" == "destroy" ]
then
    terraform destroy -auto-approve -compact-warnings -var-file $2
else
  echo "Invalid input"
fi