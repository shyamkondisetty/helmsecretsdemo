pipeline {
    agent {
        kubernetes {

            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:

  - name: helmcontainer
    image: projectwave/helm
    command:
    - sleep
    args:
    - infinity
'''
        }
    }
    environment{
        PUBLIC_KEY=credentials('gpg_public_key')
        PRIVATE_KEY=credentials('gpg_private_key')
        GPG_PASSPHRASE=credentials('gpg_passphrase')

    }
    stages {
        stage('helm') {
            steps {
                container('helmcontainer'){
                    sh 'helm version'
                    sh 'gpg --version'
                    sh 'export GPG_TTY=/dev/console'
                    sh 'gpg --import ${PUBLIC_KEY}'
                    sh 'gpg --batch --passphrase ${GPG_PASSPHRASE} --allow-secret-key-import --import ${PRIVATE_KEY}'
                    sh 'gpg --list-keys'
                    sh 'helm plugin install https://github.com/jkroepke/helm-secrets --version v3.5.0'
                    sh 'helm secrets dec secrets.yaml'
                }
            }
        }
    }
}