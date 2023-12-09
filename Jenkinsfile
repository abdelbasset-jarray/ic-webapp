/* import shared library. */
@Library('ajarray-shared-library')_
pipeline {
    environment {
        IMAGE_NAME = "ic-webapp"
        APP_CONTAINER_PORT = "8080"
        DOCKERHUB_ID = "jarray81"
        DOCKERHUB_PASSWORD = credentials('dockerhub_password')
        ANSIBLE_IMAGE_AGENT = "registry.gitlab.com/robconnolly/docker-ansible:latest"
        IC_WEBAPP_SERVER_DEV = "127.0.0.1"
    }
    agent none
    stages {
           
      
        stage ("Delete Dev environment") {
            agent { 
                label 'jnlp-agent-terraform'  
                }
            environment {
                AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
                PRIVATE_AWS_KEY = credentials('private_aws_key')
            }
            steps {
                script {       
                    timeout(time: 30, unit: "MINUTES") {
                        input message: "Confirmer vous la suppression de la dev dans AWS ?", ok: 'Yes'
                    } 
                    sh'''
                        cd "./terraform-ressources-aws/dc-server/app"
                        terraform destroy --auto-approve
                        rm -rf ansible-ressources/host_vars/*.dev.yml
                        rm -rf devops.pem
                    '''                            
                }
            }
        }  
        stage ("Deploy in PRODUCTION") {
            /* when { expression { GIT_BRANCH == 'origin/prod'} } */
            agent { 
                label 'docker-ansible'  
                }
                                 
            stages {
                   /* 
                  stage ("PRODUCTION - Ping target hosts") {
                    steps {
                        script {
                            sh '''
                                apt update -y
                                apt install sshpass -y                            
                                export ANSIBLE_CONFIG=/var/lib/jenkins/workspace/ic-webapp/ansible-ressources/ansible.cfg
                                ansible prod -m ping  -o
                                
                            '''
                        }
                    }
                } */                                                  
                stage ("PRODUCTION - Install Docker on all hosts") {
                    steps {
                        script {
                            timeout(time: 30, unit: "MINUTES") {
                                input message: "Etes vous certains de vouloir cette MEP ?", ok: 'Yes'
                            }                            

                            sh '''
                                export ANSIBLE_CONFIG=/var/lib/jenkins/workspace/ic-webapp/ansible-ressources/ansible.cfg
                                ansible-playbook ansible-ressources/playbooks/install-docker.yml --vault-password-file vault.key --private-key devops.pem -l odoo_server,pg_admin_server
                            '''                                
                        }
                    }
                }

                stage ("PRODUCTION - Deploy pgadmin") {
                    steps {
                        script {
                            sh '''
                                export ANSIBLE_CONFIG=/var/lib/jenkins/workspace/ic-webapp/ansible-ressources/ansible.cfg
                                ansible-playbook ansible-ressources/playbooks/deploy-pgadmin.yml --vault-password-file vault.key --private-key devops.pem -l pg_admin
                            '''
                        }
                    }
                }
                stage ("PRODUCTION - Deploy odoo") {
                    steps {
                        script {
                            sh '''
                                export ANSIBLE_CONFIG=/var/lib/jenkins/workspace/ic-webapp/ansible-ressources/ansible.cfg
                                ansible-playbook ansible-ressources/playbooks/deploy-odoo.yml --vault-password-file vault.key --private-key devops.pem -l odoo
                            '''
                        }
                    }
                }

              
            }
        } 
    }  

    post {
        always {
            script {
                /*sh '''
                    echo "Manually Cleaning workspace after starting"
                    rm -f vault.key id_rsa id_rsa.pub password devops.pem public_ip.txt
                ''' */
                slackNotifier currentBuild.result
            }
        }
    }    
}
