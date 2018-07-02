from jenkinsapi.jenkins import Jenkins
from jenkinsapi.credential import UsernamePasswordCredential, SSHKeyCredential

api = Jenkins('http://jenkins:8080')
# Get a list of all global credentials
creds = api.credentials
credentialsId = creds.credentials.keys()[0]

import jenkins

j = jenkins.Jenkins('http://jenkins:8080')

# jenkins slaves
num_nodes = 8
for i in range(1, 1+num_nodes):
    params = {
        'port': '22',
        'username': 'jenkins',
        'credentialsId': credentialsId,
        'host': 'jenkinsphoenix_slave_%d' % i
    }
    create = True
    for node in j.get_nodes():
        if node['name'] == params['host']:
            create = False
    if create:
        j.create_node(
            params['host'],
            nodeDescription='my test slave',
            remoteFS='/tmp',
            labels='jenkinsphoenix_slave',
            numExecutors=1,
            launcher=jenkins.LAUNCHER_SSH,
            launcher_params=params
        )

## jenkins docker slave
#params = {
#	'port': '22',
#	'username': 'jenkins',
#	'credentialsId': credentialsId,
#	'host': 'jenkinsdockerslave1'
#}
#create = True
#for node in j.get_nodes():
#	if node['name'] == 'jenkinsdockerslave1':
#		create = False
#if create:
#	j.create_node(
#		'jenkinsdockerslave1',
#		nodeDescription='my docker test slave',
#		remoteFS='/tmp',
#		labels='jenkinsdockerslave',
#		launcher=jenkins.LAUNCHER_SSH,
#		launcher_params=params
#	)
