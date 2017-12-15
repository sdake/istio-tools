# Enables admission controller for Istio
# ASL2

import yaml

admission = ['--feature-gates=AllAlpha=true', '--runtime-config=admissionregistration.k8s.io/v1alpha1']
alpha = ['--feature-gates=AllAlpha=true']


def extend_container(input_data, extension):
    input_data['spec']['containers'][0]['command'].extend(extension)
    return(input_data)


def read_extend_write(filename, extension):
    manifest = file('%s/%s' % ('/etc/kubernetes/manifests', filename))
    manifest_data = yaml.safe_load(manifest)
    extended_manifest_data = extend_container(manifest_data, extension)
    with open ('%s/%s' % ('/etc/kubernetes/manifests', filename), 'w') as yaml_file:
        yaml.dump(extended_manifest_data, yaml_file, default_flow_style=False)
    

read_extend_write ('kube-apiserver.yaml', admission)
#read_extend_write ('kube-controller-manager.yaml', alpha)
#read_extend_write ('kube-scheduler.yaml', alpha)
