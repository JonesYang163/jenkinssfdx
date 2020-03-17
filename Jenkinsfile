#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    //def HUB_ORG='yangjiwen129@sina.com'
    def HUB_ORG=env.HUB_ORG
    // def SFDC_HOST = 'https://login.salesforce.com'
    def SFDC_HOST = env.SFDC_HOST
    // def JWT_KEY_CRED_ID1 = '0535322c-d972-40ae-a693-c68055aab9d2'
    // def JWT_KEY_CRED_ID = '0535322c-d972-40ae-a693-c68055aab9d2'
    def JWT_KEY_CRED_ID = env.JWT_KEY_CRED_ID
    // def JWT_KEY_CRED_ID1 = 'Users/yjw/Documents/JWT/server.key'
    // def CONNECTED_APP_CONSUMER_KEY='3MVG9pe2TCoA1Pf5e20tslKYCmYaN4Or1Bx2vjr6aIY5jm61BiH8Od8V4B8SHBTxVrEWqwGltHRQ9K1L.nnO9'
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY
    def toolbelt = tool 'toolbelt'

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
        stage('Deploye Code') {
		
		sh 'echo "Hello World"'
		//sh '/usr/local/bin/sfdx force:auth:jwt:grant'
            //if (isUnix()) {
                //rc = sh '/usr/local/bin/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST} --setalias my-hub-org'
		rc = sh '/usr/local/bin/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ~/documents/jwt/server.key --setdefaultdevhubusername --instanceurl ${SFDC_HOST} --setalias my-hub-org'
                //rc = command "${toolbelt}/sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"

            //}else{
                 //rc = bat returnStatus: true, script: "\"${toolbelt}\" force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
                //rc = sh returnStatus: true, script: "${toolbelt} force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"

            //}
            if (rc != 0) { error 'hub org authorization failed' }

			println rc
			println('1111!')
			// need to pull out assigned username
			if (isUnix()) {
				rmsg = sh returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
			}else{
			   rmsg = bat returnStdout: true, script: "\"${toolbelt}\" force:mdapi:deploy -d manifest/. -u ${HUB_ORG}"
			}
			  
            printf rmsg
            println('Hello from a Job DSL script!')
            println(rmsg)
        }
    }
}
