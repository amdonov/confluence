FROM centos:7
COPY response.varfile /root/
RUN yum install -y tar && yum clean all
RUN curl -x proxy:3128 -k -o confluence.bin https://downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-5.8.16-x64.bin && chmod 755 confluence.bin && ./confluence.bin -q -varfile /root/response.varfile && rm confluence.bin && pkill java
# Allow confluence to run as any UID for Openshift
RUN chmod -R 777 /opt/atlassian/confluence/logs /opt/atlassian/confluence/work /opt/atlassian/confluence/temp /opt/atlassian/confluence/conf /opt/atlassian/confluence/confluence /var/atlassian/application-data/confluence && echo "" > /opt/atlassian/confluence/bin/user.sh
EXPOSE 8090
VOLUME /var/atlassian/application-data/confluence
CMD /opt/atlassian/confluence/bin/start-confluence.sh -fg
