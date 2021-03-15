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
                    sh '''
                        helm version
                        gpg --version
                        export GPG_TTY=$(tty)
                        gpg --import ${PUBLIC_KEY}
                        gpg --batch --passphrase ${GPG_PASSPHRASE} --allow-secret-key-import --import ${PRIVATE_KEY}
                        gpg --list-keys
                        helm plugin install https://github.com/jkroepke/helm-secrets --version v3.5.0
                        helm secrets dec secrets.yaml
                    '''

                }
            }
        }
    }
}