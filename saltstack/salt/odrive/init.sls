odrive_group:
    group.present:
        - name: odrive
        - gid: 4000
        - system: True

# Requisite format:  `- require: {<state>: <id>}`
odrive:
    user.present:
        - name: odrive
        - fullname: odrive
        - shell: /bin/sh
        - home: /home/odrive
        - uid: 5000  # Do we need to specify this?
        - gid: 4000
        - groups:
            - odrive
        - require:
            - group: odrive_group

odrive_deps:
    pkg.installed:
        - pkgs: ["git", "openssl", "pkgconfig", "openssl-devel"]
    archive.extracted:
        - name: /usr/local/go/
        - source: https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz
        - source_hash: sha256=e40c36ae71756198478624ed1bb4ce17597b3c19d243f3f0899bb5740d56212a
        - archive_format: tar
        - tar_options: --strip-components=1
        - user: root
        - group: root
        - require:
            - group: odrive_group

source_dir:
    file.directory:
        - name: /home/odrive/Go/src/decipher.com
        - user: odrive
        - group: odrive
        - mode:  755
        - makedirs: True
        - require:
            - user: odrive

# We can access some of the salt API in the Jinja template language.
# generate_ssh_key_odrive:
# {% if not salt['file.file_exists']('/home/odrive/.ssh/id_rsa') %}
#     cmd.run:
#         - name: ssh-keygen -q -N '' -f /home/odrive/.ssh/id_rsa
#         - user: odrive
# {% else %}
#     cmd.run:
#         - name: echo "odrive ssh key exists"
# {% endif %}
#     require:
#         - source_dir:
#             - file: directory

#gitlab.363-283.io:
#    ssh_known_hosts.present:
#        - user: odrive
#        - name: gitlab.363-283.io
#        - fingerprint: e9:3a:d3:f5:48:0f:92:9a:c0:4d:aa:ac:ad:cf:68:6c
#    require:
#        - sls: generate_ssh_key_odrive
