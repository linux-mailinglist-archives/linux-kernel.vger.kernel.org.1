Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FF2DF452
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 08:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgLTHkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 02:40:46 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:40060
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgLTHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 02:40:45 -0500
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id 558E4414E03;
        Sun, 20 Dec 2020 15:40:01 +0800 (+08)
MIME-Version: 1.0
Date:   Sun, 20 Dec 2020 15:40:01 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: HELP! I can't get my Cisco CP-7960G IP hardphone to register on my
 Asterisk VoIP IP PBX SIP Server with FreePBX GUI
Message-ID: <7848953149cc20f0f735782eb7683a09@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: HELP! I can't get my Cisco CP-7960G IP hardphone to register on 
my Asterisk VoIP IP PBX SIP Server with FreePBX GUI

Good day from Singapore,

My Asterisk version: 16.13.0
My FreePBX version: 15.0.16.81

On 7 December 2020, I was able to get Bria softphone to work with my 
Asterisk PBX server successfully.

On 19 December 2020, I bought a refurbished Cisco CP-7960G IP hardphone 
for SGD$30 in Singapore. I have tried all of the following steps, but I 
simply can't get my Cisco CP-7960G IP phone to register on my Asterisk 
PBX server.

TFTP works though. My DHCP server in my pfSense firewall applaince is 
able to assign my Cisco 7960 IP phone with an IP address with DHCP 
option 66 (TFTP server). My Cisco 7960 IP phone is able to connect to my 
TFTP server on my Asterisk PBX appliance and download firmware and 
configuration files successfully. However, it simply cannot register on 
my Asterisk PBX server.

You can watch my Youtube video at

https://www.youtube.com/watch?v=ip_F08jmmio

Appreciate your kind assistance.

Thank you very much.

STEPS I HAVE TRIED
===================

Reference Guide: Configure Asterisk with Cisco IP Phones
Link: http://docshare02.docshare.tips/files/6706/67061980.pdf

SECTION: INSTALLING TFTP SERVER ON ASTERISK PBX APPLIANCE
=========================================================

Putty/ssh into Teo En Ming's Asterisk VoIP IP PBX SIP Server at 
192.168.1.9.

# yum install tftp-server

Package tftp-server-5.2-23.8.sng7.x86_64 already installed and latest 
version

# chkconfig xinetd on

# chkconfig tftp on

# systemctl start tftp.service

# ps -ef | grep tftp
root      3424     1  0 11:17 ?        00:00:00 /usr/sbin/in.tftpd -s 
/tftpboot

SECTION: DOWNLOADING CISCO 7960 IP PHONE SIP FIRMWARE
======================================================

# cd /tftpboot

# wget 
http://www.firewall.cx/downloads/cisco-tools-a-applications/cisco-ip-phone-a-ata-firmware-downloads/107-7940-a-7960-ip-phone-sccp-a-sip/file.html

# mv file.html file.zip

# unzip file.zip

# cd 7940_7960/

# cd SIP/

# tar -xf P0S3-8-12-00.tar

# rm P0S3-8-12-00.tar

# mv * /tftpboot/

# cd /tftpboot/

[root@freepbx tftpboot]# ls
7940_7960  file.zip  OS79XX.TXT  P003-8-12-00.bin  P003-8-12-00.sbn  
P0S3-8-12-00.loads  P0S3-8-12-00.sb2

SECTION: CREATING CISCO 7960 IP PHONE CONFIGURATION FILES
==========================================================

# nano OS79XX.TXT (Create configuration file)
=============================================

P003-8-12-00

# nano XMLDefault.cnf.xml (Create configuration file)
=====================================================

<Default>
<callManagerGroup>
  <members>
  <member priority="0">
  <callManager>
  <ports>
  <ethernetPhonePort>2000</ethernetPhonePort>
  <mgcpPorts>
  <listen>2427</listen>
  <keepAlive>2428</keepAlive>
  </mgcpPorts>
  </ports>
  <processNodeName></processNodeName>
  </callManager>
  </member>
  </members>
  </callManagerGroup>
<loadInformation8 model="IP Phone 7940">P0S3-8-12-00</loadInformation8>
<loadInformation7 model="IP Phone 7960">P0S3-8-12-00</loadInformation7>
<loadInformation435 model="Cisco 7945">SIP45.8-4-2S</loadInformation435>
<loadInformation436 model=”Cisco 7965”>SIP45.8-4-2S</loadInformation436>
<loadInformation30006 model="IP Phone 
7970">SIP70.8-0-3S</loadInformation30006>
<authenticationURL></authenticationURL>
<directoryURL></directoryURL>
<idleURL></idleURL>
<informationURL></informationURL>
<messagesURL></messagesURL>
<servicesURL></servicesURL>
</Default>

# nano SIPDefault.cnf (Create configuration file)
=================================================

image_version: "P0S3-8-12-00"
proxy1_address: "192.168.1.9"
# proxy2_address: "xxx.xxx.xxx.xxx"
# proxy3_address: "xxx.xxx.xxx.xxx"
# proxy4_address: "xxx.xxx.xxx.xxx"

# Proxy Server Port
proxy1_port:"5060"
# proxy2_port:"5060"
# proxy3_port:"5060"
# proxy4_port:"5060"
proxy_emergency: ""
proxy_emergency_port: "5060"
proxy_backup: ""
proxy_backup_port: "5060"
outbound_proxy: ""
outbound_proxy_port: "5060"

nat_enable: "0"
nat_address: ""
voip_control_port: "5060"
start_media_port: "16348"
end_media_port: "20134"
nat_received_processing: "1"
dyn_dns_addr_1: ""
dyn_dns_addr_2: ""
dyn_tftp_addr: "192.168.1.9"
tftp_cfg_dir: "./"
proxy_register: "1"
timer_register_expires: "120"
preferred_codec: "none"
tos_media: "5"
enable_vad: "0"
dial_template: "dialplan"
network_media_type: "auto"
autocomplete: "1"
telnet_level: "2"
cnf_join_enable: "1"
semi_attended_transfer: "0"
call_waiting: "1"
anonymous_call_block: "0"
callerid_blocking: "0"
dnd_control: "0"
dtmf_inband: "1"
dtmf_outofband: "avt"
dtmf_db_level: "3"
dtmf_avt_payload: "101"
timer_t1: "500"
timer_t2: "4000"
sip_retx: "10"
sip_invite_retx: "6"
timer_invite_expires: "180"

sntp_mode: "directedbroadcast"
sntp_server: "time-a-g.nist.gov"
time_zone: "8"
time_format_24hr: "0"
dst_offset: "0"
dst_start_month: "April"
dst_start_day: ""
dst_start_day_of_week: "Sun"
dst_start_week_of_month: "1"
dst_start_time: "2"
dst_stop_month: "Nov"
dst_stop_day: "1"

dst_stop_day_of_week: "Sunday"
dst_stop_week_of_month: ""
dst_stop_time: "2"
dst_auto_adjust: "1"

messages_uri: "*99"
services_url: "http://example.domain.ext/services/menu.xml"
directory_url: "http://example.domain.ext/services/directory.php"
logo_url: "http://example.domain.ext/imagename.bmp"
http_proxy_addr: ""
http_proxy_port: ""
remote_party_id: 0

# nano dialplan.xml (Create configuration file)
===============================================

<DIALTEMPLATE>
  <TEMPLATE MATCH="*" Timeout="5"/> <!-- Anything else -->
</DIALTEMPLATE>

# nano RINGLIST.DAT (Create configuration file)
===============================================

FlintPhone FlintPhone.raw
HarpSynth HarpSynth.raw
Jamaica Jamaica.raw
Klaxons Klaxons.raw
KotoEffect KotoEffect.raw
MusicBox MusicBox.raw
Ohno Ohno.raw
Piano 1 Piano1.raw
Piano 2 Piano2.raw

# nano SEP000E84C060A6.cnf.xml (Create configuration file)
==========================================================

<device>
<deviceProtocol>SIP</deviceProtocol>
<loadInformation model="IP Phone 7960">P0S3-8-12-00</loadInformation>
</device>

# nano SIP000E84C060A6.cnf (Create configuration file)
=======================================================

proxy1_address: "192.168.1.9"
proxy2_address: "xxx.xxx.xxx.xxx"
proxy3_address: "xxx.xxx.xxx.xxx"
proxy4_address: "xxx.xxx.xxx.xxx"
line1_name: "1600"
line1_shortname: "TEO EN MING"
line1_displayname: "TURRITOPSIS DOHRNII TEO EN MING"
line1_authname: "1600"
line1_password: "IP Phone Extension Password"
line2_name: ""
line2_shortname: ""
line2_displayname: ""
line2_authname: "UNPROVISIONED"
line2_password: "UNPROVISIONED"
line3_name: ""
line3_shortname: ""
line3_displayname: ""
line3_authname: "UNPROVISIONED"
line3_password: "UNPROVISIONED"
line4_name: ""
line4_shortname:
line4_displayname: ""
line4_authname: "UNPROVISIONED"
line4_password: "UNPROVISIONED"
line5_name: ""
line5_shortname: ""
line5_displayname: ""
line5_authname: "UNPROVISIONED"
line5_password: "UNPROVISIONED"
line6_name: ""
line6_shortname: ""
line6_displayname: ""
line6_authname: "UNPROVISIONED"
line6_password: "UNPROVISIONED"
proxy_emergency: ""
proxy_emergency_port: "5060"
proxy_backup: ""
proxy_backup_port: "5060"
outbound_proxy: ""
outbound_proxy_port: "5060"
nat_enable: "0"
nat_address: ""
voip_control_port: "5060"
start_media_port: "16348"
end_media_port: "20134"
nat_received_processing: "0"
phone_label: "TEO EN MING CORP "
time_zone: 8
logo_url: "http://domain.ext/imagefile.bmp"
telnet_level: "2"
phone_prompt: "Cisco7960"
phone_password: "password"
enable_vad: "0"
network_media_type: "auto"
user_info: phone

SECTION: GETTING TFTP SERVER TO START AUTOMATICALLY UPON EVERY BOOT
====================================================================

# systemctl enable tftp

# systemctl start tftp

[root@freepbx ~]# ps -ef | grep tftp
root      4097     1  0 02:24 ?        00:00:00 /usr/sbin/in.tftpd -s 
/tftpboot

SECTION: CONFIGURING PFSENSE FIREWALL'S DHCP SERVER WITH DHCP OPTION 66 
(TFTP SERVER)
=====================================================================================

Reference Guide: Chapter: Getting Started With Your Cisco SIP IP Phone 
(Version 3.0)
Link: 
https://www.cisco.com/c/en/us/td/docs/voice_ip_comm/cuipph/7960g_7940g/sip/3_0/english/administration/guide/ver3_0/install.html

[QUOTE]

Configuring Network Parameters
==============================

Note This section describes how to configure the basic network 
parameters that are required for the phone to operate on the network. 
For a complete list of the network parameters that you can configure, 
see the "Modifying the Phone's Network Settings" section.

The network parameters include those parameters that must be configured 
on a phone for the phone to operate in an IP network. You can configure 
the required network parameters via DHCP or manually configure them 
after you have connected the phone to a power supply.

The following parameters must be defined for your phone to establish 
network connectivity:

•Phone's IP address

•Subnet mask

•Default gateway for the subnet (use "0.0.0.0" if not required)

•Domain name

•DNS server IP address (use "0.0.0.0" if not required)

•TFTP server IP address

When configuring the network parameters of an IP phone, adhere to the 
following guidelines:

•Use 0.0.0.0 for unused IP addresses.

•You can use 0.0.0.0 for the subnet mask only if the default gateway is 
also 0.0.0.0.

•The TFTP server must have a nonzero IP address.

•The default gateway must be on the same subnet as the phone.

•The default gateway can be 0.0.0.0 only if the TFTP or DNS server is on 
the same subnet as the phone.


Note By default, DHCP is enabled on your phone. Before you can manually 
configure the network parameters, you must disable DHCP after connecting 
your phone to a power supply.

Configuring Network Parameters via a DHCP Server
================================================

If you are using DHCP to configure the network parameters, configure the 
following DHCP options on your DHCP server before you connect your Cisco 
SIP IP phone:

•dhcp option #50 (IP address)

•dhcp option #1 (IP subnet mask)

•dhcp option #3 (Default IP gateway)

•dhcp option #15 (Domain name)

•dhcp option #6 (DNS server IP address)

•dhcp option #66 (TFTP server IP address)

[/QUOTE]

Reference Guide: pfSense Firewall DHCPv4 Server
Link: https://docs.netgate.com/pfsense/en/latest/services/dhcp/ipv4.html

Login to Teo En Ming's pfSense firewall appliance.

Click Services > DHCP Server.

At TFTP, click Display Advanced.

TFTP Server: 192.168.1.9

Please remember to click Save.

Then click Restart Service. You must restart the DHCP server for the 
changes to take effect.

SECTION: PERFORM FACTORY RESET ON CISCO 7960 IP PHONE
=====================================================

Because I bought an used Cisco 7960 IP phone, I must factory reset it to 
clear all previous owner's settings.

Reference Guide: Reset 7900 Series IP Phones if Password is Set
Link: 
https://www.cisco.com/c/en/us/support/docs/voice-unified-communications/unified-ip-phone-7900-series/15254-7960-default.html

[QUOTE]

Reset the 7940 and 7960 IP Phones to the Factory Default
=========================================================

In order to perform a factory reset of a phone if the password is set, 
complete these steps:

Unplug the power cable from the phone, and then plug in the cable again.

The phone begins its power up cycle.

Immediately press and hold # and while the Headset, Mute, and Speaker 
buttons begin to flash in sequence, release #.

The Headset, Mute, and Speaker buttons flash in sequence in order to 
indicate that the phone waits for you to enter the key sequence for the 
reset.

Press 123456789*0# within 60 seconds after the Headset, Mute, and 
Speaker buttons begin to flash.

If you repeat a key within the sequence, for example, if you press 
1223456789*0#, the sequence is still accepted and the phone resets.

If you do not complete this key sequence or do not press any keys, after 
60 seconds, the Headset, Mute, and Speaker buttons no longer flash, and 
the phone continues with its normal startup process. The phone does not 
reset.

If you enter an invalid key sequence, the buttons no longer flash, and 
the phone continues with its normal startup process. The phone does not 
reset.

If you enter this key sequence correctly, the phone displays this 
prompt:

Keep network cfg? 1 = yes 2 = no

In order to maintain the current network configuration settings for the 
phone when the phone resets, press 1. In order to reset the network 
configuration settings when the phone resets, press 2.

If you press another key or do not respond to this prompt within 60 
seconds, the phone continues with its normal startup process and does 
not reset. Otherwise, the phone goes through the factory reset process.

[/QUOTE]

SECTION: TEMPORARILY DISABLE FREEPBX FIREWALL TO TEST TFTP CONNECTION
=====================================================================

Reference Guide: Firewall Command Line
Link: https://wiki.freepbx.org/display/FPG/Firewall+Command+Line

# fwconsole firewall disable

[root@freepbx ~]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

[root@freepbx ~]# iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT

[root@freepbx ~]# tail -f /var/log/messages

Dec 20 03:24:42 freepbx systemd: Started Tftp Server.
Dec 20 03:25:25 freepbx xinetd[939]: START: tftp pid=8213 
from=192.168.1.130
Dec 20 03:25:25 freepbx in.tftpd[8214]: RRQ from 192.168.1.130 filename 
CTLSEP000E84C060A6.tlv
Dec 20 03:25:25 freepbx in.tftpd[8214]: Client 192.168.1.130 File not 
found CTLSEP000E84C060A6.tlv
Dec 20 03:25:25 freepbx in.tftpd[8215]: RRQ from 192.168.1.130 filename 
SEP000E84C060A6.cnf.xml
Dec 20 03:25:25 freepbx in.tftpd[8215]: Client 192.168.1.130 finished 
SEP000E84C060A6.cnf.xml
Dec 20 03:25:25 freepbx in.tftpd[8216]: RRQ from 192.168.1.130 filename 
P0S3-8-12-00.loads
Dec 20 03:25:25 freepbx in.tftpd[8216]: Client 192.168.1.130 finished 
P0S3-8-12-00.loads
Dec 20 03:25:49 freepbx in.tftpd[8217]: RRQ from 192.168.1.130 filename 
SIPDefault.cnf
Dec 20 03:25:49 freepbx in.tftpd[8217]: Client 192.168.1.130 finished 
SIPDefault.cnf
Dec 20 03:25:49 freepbx in.tftpd[8218]: RRQ from 192.168.1.130 filename 
./SIP000E84C060A6.cnf
Dec 20 03:25:49 freepbx in.tftpd[8218]: Client 192.168.1.130 finished 
./SIP000E84C060A6.cnf
Dec 20 03:25:51 freepbx in.tftpd[8219]: RRQ from 192.168.1.130 filename 
RINGLIST.DAT
Dec 20 03:25:51 freepbx in.tftpd[8220]: RRQ from 192.168.1.130 filename 
dialplan.xml
Dec 20 03:25:51 freepbx in.tftpd[8219]: Client 192.168.1.130 finished 
RINGLIST.DAT
Dec 20 03:25:51 freepbx in.tftpd[8220]: Client 192.168.1.130 finished 
dialplan.xml

SECTION: ENABLE AND START THE FREEPBX FIREWALL FOR PRODUCTION USE
==================================================================

[root@freepbx ~]# fwconsole firewall start
Enabling Firewall.
[root@freepbx ~]#
Broadcast message from root@freepbx.sangoma.local (Sun Dec 20 03:37:45 
2020):

Firewall service now starting.

# iptables -L

# iptables -S

Login to FreePBX Dashboard.

Please check the following item:

System Firewall: Firewall Active

Power off and then power on the Cisco 7960 IP Phone.

[root@freepbx ~]# tail -f /var/log/messages
Dec 20 03:42:27 freepbx xinetd[939]: START: tftp pid=10209 
from=192.168.1.130
Dec 20 03:42:27 freepbx in.tftpd[10210]: RRQ from 192.168.1.130 filename 
CTLSEP000E84C060A6.tlv
Dec 20 03:42:27 freepbx in.tftpd[10210]: Client 192.168.1.130 File not 
found CTLSEP000E84C060A6.tlv
Dec 20 03:42:28 freepbx in.tftpd[10211]: RRQ from 192.168.1.130 filename 
SEP000E84C060A6.cnf.xml
Dec 20 03:42:28 freepbx in.tftpd[10211]: Client 192.168.1.130 finished 
SEP000E84C060A6.cnf.xml
Dec 20 03:42:28 freepbx in.tftpd[10212]: RRQ from 192.168.1.130 filename 
P0S3-8-12-00.loads
Dec 20 03:42:28 freepbx in.tftpd[10212]: Client 192.168.1.130 finished 
P0S3-8-12-00.loads
Dec 20 03:42:51 freepbx in.tftpd[10286]: RRQ from 192.168.1.130 filename 
SIPDefault.cnf
Dec 20 03:42:51 freepbx in.tftpd[10286]: Client 192.168.1.130 finished 
SIPDefault.cnf
Dec 20 03:42:52 freepbx in.tftpd[10287]: RRQ from 192.168.1.130 filename 
./SIP000E84C060A6.cnf
Dec 20 03:42:52 freepbx in.tftpd[10287]: Client 192.168.1.130 finished 
./SIP000E84C060A6.cnf
Dec 20 03:42:53 freepbx in.tftpd[10288]: RRQ from 192.168.1.130 filename 
RINGLIST.DAT
Dec 20 03:42:53 freepbx in.tftpd[10288]: Client 192.168.1.130 finished 
RINGLIST.DAT
Dec 20 03:42:53 freepbx in.tftpd[10289]: RRQ from 192.168.1.130 filename 
dialplan.xml
Dec 20 03:42:53 freepbx in.tftpd[10289]: Client 192.168.1.130 finished 
dialplan.xml

Asterisk CLI Troubleshooting Commands
======================================

# asterisk -vvvr

sip set debug on

sip show peers
Name/username             Host                                    Dyn 
Forcerport Comedia    ACL Port     Status      Description
didlogic/60751            107.6.123.181                               
Yes        Yes            5060     OK (7 ms)
1 sip peers [Monitored: 1 online, 0 offline Unmonitored: 0 online, 0 
offline]

SECTION: ASTERISK PBX SERVER DEBUGGING OUTPUT
=============================================

# asterisk -vvvr

sip set debug on

freepbx*CLI>
[2020-12-20 07:06:22] NOTICE[2366]: chan_sip.c:15893 sip_reregister:    
-- Re-registration for  60751@sip.sg.didlogic.net
REGISTER 12 headers, 0 lines
Reliably Transmitting (NAT) to 107.6.123.181:5060:
REGISTER sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK3f11a8b8;rport
Max-Forwards: 70
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: <sip:60751@sip.sg.didlogic.net>
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 165 REGISTER
Supported: replaces, timer
User-Agent: FPBX-15.0.16.81(16.13.0)
Authorization: Digest username="60751", realm="sip.sg.didlogic.net", 
algorithm=MD5, uri="sip:sip.sg.didlogic.net", 
nonce="X974SF/e9xyVB6XKqpfatDHcb8chw9fPak+Ke4A=", 
response="bfadacdd4e745fd4b9e12046e6ce2afc", qop=auth, 
cnonce="2b1b6d13", nc=00000003
Expires: 120
Contact: <sip:6531590313@192.168.1.9:5160>
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK3f11a8b8;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: 
<sip:60751@sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.4d21
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 165 REGISTER
Contact: <sip:6531590313@<CORPORATE OFFICE PUBLIC 
IP>:26462>;expires=120;received="sip:<CORPORATE OFFICE PUBLIC IP>:26462"
Content-Length: 0

<------------->
--- (8 headers 0 lines) ---
[2020-12-20 07:06:22] NOTICE[2366]: chan_sip.c:24961 
handle_response_register: Outbound Registration: Expiry for 
sip.sg.didlogic.net is 120 sec (Scheduling reregistration in 105 s)
Really destroying SIP dialog 
'005dbc8238e06ac421ef613a3b55e134@127.0.0.1' Method: REGISTER

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->
Reliably Transmitting (NAT) to 107.6.123.181:5060:
OPTIONS sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK51105854;rport
Max-Forwards: 70
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as41ddf4a6
To: <sip:sip.sg.didlogic.net>
Contact: <sip:60751@192.168.1.9:5160>
Call-ID: 0b0605df4f4ca7b03402c9fd5a869606@192.168.1.9:5160
CSeq: 102 OPTIONS
User-Agent: FPBX-15.0.16.81(16.13.0)
Date: Sun, 20 Dec 2020 07:07:07 GMT
Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, SUBSCRIBE, NOTIFY, 
INFO, PUBLISH, MESSAGE
Supported: replaces, timer
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK51105854;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as41ddf4a6
To: <sip:sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.f924
Call-ID: 0b0605df4f4ca7b03402c9fd5a869606@192.168.1.9:5160
CSeq: 102 OPTIONS
Content-Length: 0

<------------->
--- (7 headers 0 lines) ---
Really destroying SIP dialog 
'0b0605df4f4ca7b03402c9fd5a869606@192.168.1.9:5160' Method: OPTIONS

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->
Reliably Transmitting (NAT) to 107.6.123.181:5060:
OPTIONS sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK4ff08179;rport
Max-Forwards: 70
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as004073f3
To: <sip:sip.sg.didlogic.net>
Contact: <sip:60751@192.168.1.9:5160>
Call-ID: 500c8eb32071e3fc462be80f243d38fc@192.168.1.9:5160
CSeq: 102 OPTIONS
User-Agent: FPBX-15.0.16.81(16.13.0)
Date: Sun, 20 Dec 2020 07:08:07 GMT
Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, SUBSCRIBE, NOTIFY, 
INFO, PUBLISH, MESSAGE
Supported: replaces, timer
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK4ff08179;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as004073f3
To: <sip:sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.385d
Call-ID: 500c8eb32071e3fc462be80f243d38fc@192.168.1.9:5160
CSeq: 102 OPTIONS
Content-Length: 0

<------------->
--- (7 headers 0 lines) ---
Really destroying SIP dialog 
'500c8eb32071e3fc462be80f243d38fc@192.168.1.9:5160' Method: OPTIONS
[2020-12-20 07:08:07] NOTICE[2366]: chan_sip.c:15893 sip_reregister:    
-- Re-registration for  60751@sip.sg.didlogic.net
REGISTER 12 headers, 0 lines
Reliably Transmitting (NAT) to 107.6.123.181:5060:
REGISTER sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK6d85e46f;rport
Max-Forwards: 70
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: <sip:60751@sip.sg.didlogic.net>
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 166 REGISTER
Supported: replaces, timer
User-Agent: FPBX-15.0.16.81(16.13.0)
Authorization: Digest username="60751", realm="sip.sg.didlogic.net", 
algorithm=MD5, uri="sip:sip.sg.didlogic.net", 
nonce="X974SF/e9xyVB6XKqpfatDHcb8chw9fPak+Ke4A=", 
response="074f1f037639144de751dc9231c191c9", qop=auth, 
cnonce="6eb58a86", nc=00000004
Expires: 120
Contact: <sip:6531590313@192.168.1.9:5160>
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 401 Unauthorized
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK6d85e46f;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: 
<sip:60751@sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.e426
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 166 REGISTER
WWW-Authenticate: Digest realm="sip.sg.didlogic.net", 
nonce="X975g1/e+FcgTQnFYPwx5RQy4kH7puXkamn2zYA=", qop="auth"
Content-Length: 0

<------------->
--- (8 headers 0 lines) ---
Responding to challenge, registration to domain/host name 
sip.sg.didlogic.net
REGISTER 12 headers, 0 lines
Reliably Transmitting (NAT) to 107.6.123.181:5060:
REGISTER sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK7f0ddbdc;rport
Max-Forwards: 70
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: <sip:60751@sip.sg.didlogic.net>
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 167 REGISTER
Supported: replaces, timer
User-Agent: FPBX-15.0.16.81(16.13.0)
Authorization: Digest username="60751", realm="sip.sg.didlogic.net", 
algorithm=MD5, uri="sip:sip.sg.didlogic.net", 
nonce="X975g1/e+FcgTQnFYPwx5RQy4kH7puXkamn2zYA=", 
response="c1184dab1dd50dad14cba70933b6bbaa", qop=auth, 
cnonce="4945f552", nc=00000001
Expires: 120
Contact: <sip:6531590313@192.168.1.9:5160>
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK7f0ddbdc;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: 
<sip:60751@sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.f557
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 167 REGISTER
Contact: <sip:6531590313@<CORPORATE OFFICE PUBLIC 
IP>:26462>;expires=120;received="sip:<CORPORATE OFFICE PUBLIC IP>:26462"
Content-Length: 0

<------------->
--- (8 headers 0 lines) ---
[2020-12-20 07:08:07] NOTICE[2366]: chan_sip.c:24961 
handle_response_register: Outbound Registration: Expiry for 
sip.sg.didlogic.net is 120 sec (Scheduling reregistration in 105 s)
Really destroying SIP dialog 
'005dbc8238e06ac421ef613a3b55e134@127.0.0.1' Method: REGISTER

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->
Reliably Transmitting (NAT) to 107.6.123.181:5060:
OPTIONS sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK0f99cec8;rport
Max-Forwards: 70
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as786e56f3
To: <sip:sip.sg.didlogic.net>
Contact: <sip:60751@192.168.1.9:5160>
Call-ID: 49595bb227bd6e390ca40ce6508308aa@192.168.1.9:5160
CSeq: 102 OPTIONS
User-Agent: FPBX-15.0.16.81(16.13.0)
Date: Sun, 20 Dec 2020 07:09:07 GMT
Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, SUBSCRIBE, NOTIFY, 
INFO, PUBLISH, MESSAGE
Supported: replaces, timer
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK0f99cec8;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as786e56f3
To: <sip:sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.e4fb
Call-ID: 49595bb227bd6e390ca40ce6508308aa@192.168.1.9:5160
CSeq: 102 OPTIONS
Content-Length: 0

<------------->
--- (7 headers 0 lines) ---
Really destroying SIP dialog 
'49595bb227bd6e390ca40ce6508308aa@192.168.1.9:5160' Method: OPTIONS

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->
[2020-12-20 07:09:52] NOTICE[2366]: chan_sip.c:15893 sip_reregister:    
-- Re-registration for  60751@sip.sg.didlogic.net
REGISTER 12 headers, 0 lines
Reliably Transmitting (NAT) to 107.6.123.181:5060:
REGISTER sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK030dc571;rport
Max-Forwards: 70
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: <sip:60751@sip.sg.didlogic.net>
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 168 REGISTER
Supported: replaces, timer
User-Agent: FPBX-15.0.16.81(16.13.0)
Authorization: Digest username="60751", realm="sip.sg.didlogic.net", 
algorithm=MD5, uri="sip:sip.sg.didlogic.net", 
nonce="X975g1/e+FcgTQnFYPwx5RQy4kH7puXkamn2zYA=", 
response="b6e96ab578798296e812139c383ebbac", qop=auth, 
cnonce="6313e774", nc=00000002
Expires: 120
Contact: <sip:6531590313@192.168.1.9:5160>
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK030dc571;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: 
<sip:60751@sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.2fbb
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 168 REGISTER
Contact: <sip:6531590313@<CORPORATE OFFICE PUBLIC 
IP>:26462>;expires=120;received="sip:<CORPORATE OFFICE PUBLIC IP>:26462"
Content-Length: 0

<------------->
--- (8 headers 0 lines) ---
[2020-12-20 07:09:52] NOTICE[2366]: chan_sip.c:24961 
handle_response_register: Outbound Registration: Expiry for 
sip.sg.didlogic.net is 120 sec (Scheduling reregistration in 105 s)
Really destroying SIP dialog 
'005dbc8238e06ac421ef613a3b55e134@127.0.0.1' Method: REGISTER
Reliably Transmitting (NAT) to 107.6.123.181:5060:
OPTIONS sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK25d81863;rport
Max-Forwards: 70
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as3a8d9861
To: <sip:sip.sg.didlogic.net>
Contact: <sip:60751@192.168.1.9:5160>
Call-ID: 4f9667021511db2968a0dc9964673ac9@192.168.1.9:5160
CSeq: 102 OPTIONS
User-Agent: FPBX-15.0.16.81(16.13.0)
Date: Sun, 20 Dec 2020 07:10:07 GMT
Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, SUBSCRIBE, NOTIFY, 
INFO, PUBLISH, MESSAGE
Supported: replaces, timer
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK25d81863;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as3a8d9861
To: <sip:sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.a139
Call-ID: 4f9667021511db2968a0dc9964673ac9@192.168.1.9:5160
CSeq: 102 OPTIONS
Content-Length: 0

<------------->
--- (7 headers 0 lines) ---
Really destroying SIP dialog 
'4f9667021511db2968a0dc9964673ac9@192.168.1.9:5160' Method: OPTIONS

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->
Reliably Transmitting (NAT) to 107.6.123.181:5060:
OPTIONS sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK443d3196;rport
Max-Forwards: 70
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as5d241373
To: <sip:sip.sg.didlogic.net>
Contact: <sip:60751@192.168.1.9:5160>
Call-ID: 201fab2b13e08922618f34911ce37ce0@192.168.1.9:5160
CSeq: 102 OPTIONS
User-Agent: FPBX-15.0.16.81(16.13.0)
Date: Sun, 20 Dec 2020 07:11:07 GMT
Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, SUBSCRIBE, NOTIFY, 
INFO, PUBLISH, MESSAGE
Supported: replaces, timer
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK443d3196;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: "Unknown" <sip:60751@192.168.1.9:5160>;tag=as5d241373
To: <sip:sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.19e3
Call-ID: 201fab2b13e08922618f34911ce37ce0@192.168.1.9:5160
CSeq: 102 OPTIONS
Content-Length: 0

<------------->
--- (7 headers 0 lines) ---
Really destroying SIP dialog 
'201fab2b13e08922618f34911ce37ce0@192.168.1.9:5160' Method: OPTIONS

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->
[2020-12-20 07:11:37] NOTICE[2366]: chan_sip.c:15893 sip_reregister:    
-- Re-registration for  60751@sip.sg.didlogic.net
REGISTER 12 headers, 0 lines
Reliably Transmitting (NAT) to 107.6.123.181:5060:
REGISTER sip:sip.sg.didlogic.net SIP/2.0
Via: SIP/2.0/UDP 192.168.1.9:5160;branch=z9hG4bK292b942b;rport
Max-Forwards: 70
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: <sip:60751@sip.sg.didlogic.net>
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 169 REGISTER
Supported: replaces, timer
User-Agent: FPBX-15.0.16.81(16.13.0)
Authorization: Digest username="60751", realm="sip.sg.didlogic.net", 
algorithm=MD5, uri="sip:sip.sg.didlogic.net", 
nonce="X975g1/e+FcgTQnFYPwx5RQy4kH7puXkamn2zYA=", 
response="8305fa5eb2ec2396b7b618f40923e597", qop=auth, 
cnonce="043fc0dd", nc=00000003
Expires: 120
Contact: <sip:6531590313@192.168.1.9:5160>
Content-Length: 0


---

<--- SIP read from UDP:107.6.123.181:5060 --->
SIP/2.0 200 OK
Via: SIP/2.0/UDP 
192.168.1.9:5160;branch=z9hG4bK292b942b;rport=26462;received=<CORPORATE 
OFFICE PUBLIC IP>
 From: <sip:60751@sip.sg.didlogic.net>;tag=as6df6d977
To: 
<sip:60751@sip.sg.didlogic.net>;tag=b27e1a1d33761e85846fc98f5f3a7e58.6c72
Call-ID: 005dbc8238e06ac421ef613a3b55e134@127.0.0.1
CSeq: 169 REGISTER
Contact: <sip:6531590313@<CORPORATE OFFICE PUBLIC 
IP>:26462>;expires=120;received="sip:<CORPORATE OFFICE PUBLIC IP>:26462"
Content-Length: 0

<------------->
--- (8 headers 0 lines) ---
[2020-12-20 07:11:37] NOTICE[2366]: chan_sip.c:24961 
handle_response_register: Outbound Registration: Expiry for 
sip.sg.didlogic.net is 120 sec (Scheduling reregistration in 105 s)
Really destroying SIP dialog 
'005dbc8238e06ac421ef613a3b55e134@127.0.0.1' Method: REGISTER

<--- SIP read from UDP:107.6.123.181:5060 --->

<------------->
freepbx*CLI>

SECTION: ONLINE DISCUSSIONS FOR READING LATER
==============================================

Post: Cisco 7960 SIP Registration Problem
Link: 
https://community.freepbx.org/t/cisco-7960-sip-registration-problem/19110

Mr. Turritopsis Dohrnii Teo En Ming, 42 years old as of 20 December 2020 
Sunday, is a TARGETED INDIVIDUAL (TI) living in Singapore. He is an IT 
Consultant with a System Integrator (SI)/computer firm in Singapore. He 
is an IT enthusiast.













-- 
-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: 
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's 
Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the 
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 
2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
