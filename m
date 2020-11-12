Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8512B02AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgKLK00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:26:26 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:60968
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgKLK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:26:25 -0500
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id 4B40F448F09;
        Thu, 12 Nov 2020 18:26:22 +0800 (+08)
MIME-Version: 1.0
Date:   Thu, 12 Nov 2020 18:26:22 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: Guide on Renewing SSL Certificate for Apache, Postfix and Dovecot on
 CentOS 6.8 Linux
Message-ID: <2a3eb9295792ffa6a4767552f72ef6cf@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guide on Renewing SSL Certificate for Apache, Postfix and Dovecot on 
CentOS 6.8 Linux
=====================================================================================

Author: Mr. Turritopsis Dohrnii Teo En Ming (TARGETED INDIVIDUAL)

Country: Singapore

Date: 12 November 2020 Thursday Singapore Time

Type of Publication: Plain Text

Document Version: 20201112.01

Generating Certificate Signing Request (CSR) Using OpenSSL command on 
Linux
===========================================================================

Reference Guide: Generating CSR on Apache + OpenSSL/ModSSL/Nginx + 
Heroku
Link: 
https://www.namecheap.com/support/knowledgebase/article.aspx/9446/14/generating-csr-on-apache--opensslmodsslnginx--heroku/#4

# cd /root

# which openssl

# openssl req -new -newkey rsa:2048 -nodes -keyout teo-en-ming-corp.key 
-out teo-en-ming-corp.csr

Generating a 2048 bit RSA private key
...............................................................................................................................................................................+++
........................................................................+++
writing new private key to 'teo-en-ming-corp.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a 
DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:SG
State or Province Name (full name) []:Singapore
Locality Name (eg, city) [Default City]:Singapore
Organization Name (eg, company) [Default Company Ltd]:Teo En Ming 
Corporation
Organizational Unit Name (eg, section) []:IT Department
Common Name (eg, your name or your server's hostname) 
[]:*.teo-en-ming-corp.com.sg (USE WILDCARD!!!)
Email Address []:ceo@teo-en-ming-corp.com

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:

# mkdir teo-en-ming

# mv teo-en-ming-corp.csr teo-en-ming-corp.key teo-en-ming/

# cd teo-en-ming

[root@mail.teo-en-ming-corp.com.sg teo-en-ming]# ls -al
total 16
drwxr-xr-x   2 root root 4096 Nov 11 11:43 .
dr-xr-x---. 14 root root 4096 Nov 11 11:43 ..
-rw-r--r--   1 root root 1119 Nov 11 11:42 teo-en-ming-corp.csr
-rw-r--r--   1 root root 1708 Nov 11 11:42 teo-en-ming-corp.key

# cat teo-en-ming-corp.csr (Display Certificate Signing Request)

-----BEGIN CERTIFICATE REQUEST-----

-----END CERTIFICATE REQUEST-----

# cat teo-en-ming-corp.key (Display Private/Secret Key)

-----BEGIN PRIVATE KEY-----

-----END PRIVATE KEY-----

Result from AlphaSSL Portal
============================

Congratulations!
Your order has been placed successfully.
Your order number is :
You'll need to copy the following Domain Verification Code and place it 
in a text file called "gsdv.txt" which you'll then need to put in one of 
the approved locations
Meta Tag : <meta name="_globalsign-domain-verification" content="" />

http://teo-en-ming-corp.com.sg/.well-known/pki-validation/gsdv.txt

https://teo-en-ming-corp.com.sg/.well-known/pki-validation/gsdv.txt

To complete the URL Verification, close the browser. Open the SSL 
Configuration Link in new browser and click on "Complete Url 
Verification".

End of Result from AlphaSSL Portal
==================================

Domain Verification for SSL Certificate
=======================================

# cd /home/teo-en-ming-corp/public_html

# mkdir .well-known

# cd .well-known

# mkdir pki-validation

# cd pki-validation/

Edit gsdv.txt.

# nano gsdv.txt

<meta name="_globalsign-domain-verification" content="" />

Begin Email from AlphaSSL
=========================

Email Subject: : Your SSL Certificate for *.teo-en-ming-corp.com.sg has 
been issued

-------------------------------------------------------------------------------
Please note that this email is automatically sent from a noreply 
mailbox.
To contact AlphaSSL please use the Contact Details at the footer of this 
email.
-------------------------------------------------------------------------------


Dear Turritopsis Dohrnii Teo En Ming,

Your AlphaSSL Certificate has now been issued and is ready to be 
installed. Your SSL Certificate can be found at the bottom of this 
email.


CERTIFICATE DETAILS
--------------------------------------------------
Order Number:
Common Name:  *.teo-en-ming-corp.com.sg


INSTALLING YOUR CERTIFICATE
----------------------------------------------------
Your SSL Certificate and Intermediate Certificate must be installed on 
your server.

Please note that as of March 31st 2014, SHA-256 will become the default 
hashing algorithm used unless SHA-1 was selected during the ordering 
process.

You can find guides on installing your certificate with the Support 
Center online at:  http://www.alphassl.com/support


QUICK INSTALLATION GUIDE
----------------------------------------------------
1) Using a text editor, copy the SSL Certificate text from the bottom of 
this email (including the -----BEGIN CERTIFICATE-----  and -----END 
CERTIFICATE----- lines) and save it to a file such as yourdomain.txt

2) Retrieve the Intermediate Certificate (selecting SHA-1 or SHA-256 as 
appropriate) from the Support Center at:
https://www.alphassl.com/support/install-root-certificate.html

3) Using a text editor, copy the Intermediate Certificate text 
(including the ----BEGIN CERTIFICATE----- and -----END CERTIFICATE----- 
lines) and save it to a file such as intermediate_domain_ca.txt

4) Copy these .txt files to your server and then rename them with .crt 
extensions

5) Install the Intermediate and SSL Certificates

6) Restart your server

7) To test for installation errors please use our SSL Configuration 
Checker located at https://sslcheck.globalsign.com/en_US

8) Install your Site Seal with the instructions show at: 
http://www.alphassl.com/support/ssl-site-seal.html

9) We suggest you back-up your SSL Certificate and Private Key pair and 
keep it safe, all IIS users can use the Export Wizard

We hope that your application process was quick and easy and you have 
enjoyed the AlphaSSL experience.


Thank you for choosing AlphaSSL, if you have any questions or issues 
please do not hesitate to contact us.

CONTACT US
--------------------------------------------------
For Sales, Technical Support & Account Queries:
W: http://www.alphassl.com/support
E: support@alphassl.com
T: US Toll Free: 877 SSLALPHA (+1 877 775 2574) | Fax: 720 528 8160
T: EU: +44 1622 766 700 | Fax: +44 1622 662 255

---------------------------------------------------
LOW COST. TRUSTED BY ALL BROWSERS. SSL MADE EASY.
---------------------------------------------------


YOUR SSL CERTIFICATE
--------------------------------------------------
(Formatted for the majority of web server software including IIS and 
Apache based servers):

-----BEGIN CERTIFICATE-----

-----END CERTIFICATE-----

End of Email from AlphaSSL
===========================

# cd /root/teo-en-ming

# nano teo-en-ming-corp.crt (Saving the SSL Certificate/Public Key)

-----BEGIN CERTIFICATE-----

-----END CERTIFICATE-----

# nano intermediate_domain_ca.crt (Saving the intermediate CA 
certificate)

-----BEGIN CERTIFICATE-----

-----END CERTIFICATE-----

Installing SSL Certificate on Postfix SMTP Server
=================================================

Backup the Postfix configuration files first before you modify anything.

# cd /etc/postfix

# cp main.cf main.teoenming

# cp master.cf master.teoenming

Reference Guide: Installing and configuring SSL on Postfix/Dovecot mail 
server
Link: 
https://www.namecheap.com/support/knowledgebase/article.aspx/9795/69/installing-and-configuring-ssl-on-postfixdovecot-mail-server

Copy the public and private key over from /root/teo-en-ming to 
/etc/postfix.

# cd /root/teo-en-ming/

# cp * /etc/postfix

# cd /etc/postfix

Edit the Postfix configuration file.

# nano main.cf

smtpd_tls_cert_file = /etc/postfix/teo-en-ming-corp.crt
smtpd_tls_key_file = /etc/postfix/teo-en-ming-corp.key
smtpd_tls_CAfile = /etc/postfix/intermedia_domain_ca.crt

***Please note that the previous IT support company did not enable 
SSL/TLS for SMTP Server.***

Restart the Postfix SMTP Server.

# service postfix restart

Installing SSL Certificate on Dovecot IMAP and POP3 Incoming Mail Server
=========================================================================

Backup the auxiliary Dovecot configuration file first before you modify 
anything.

# cd /etc/dovecot/conf.d

# cp 10-ssl.conf 10-ssl.teoenming

Begin Redundant/Useless Section
===============================

Please do not follow the instructions in this section.

# cd /etc/pki/dovecot/certs

# cp /root/teo-en-ming/teo-en-ming-corp.crt .

# cd /etc/pki/dovecot/private/

# cp /root/teo-en-ming/teo-en-ming-corp.key .

# cd /etc/dovecot/conf.d

Edit 10-ssl.conf.

# nano 10-ssl.conf

ssl_cert = </etc/pki/dovecot/certs/teo-en-ming-corp.crt
ssl_key = </etc/pki/dovecot/private/teo-en-ming-corp.key

End of Redundant/Useless Section
================================

Backup the Main Dovecot configuration file before you modify anything.

# cd /etc/dovecot

# cp dovecot.conf dovecot.conf.teoenming

Modify the Main Dovecot Configuration file.

# nano dovecot.conf

local_name teo-en-ming-corp.com.sg {
ssl_cert = </home/teo-en-ming-corp/teo-en-ming-corp.crt
ssl_key = </home/teo-en-ming-corp/teo-en-ming-corp.key
   ssl_ca = </home/teo-en-ming-corp/intermediate_domain_ca.crt
}
local_name www.teo-en-ming-corp.com.sg {
ssl_cert = </home/teo-en-ming-corp/teo-en-ming-corp.crt
ssl_key = </home/teo-en-ming-corp/teo-en-ming-corp.key
   ssl_ca = </home/teo-en-ming-corp/intermediate_domain_ca.crt
}
local_name autoconfig.teo-en-ming-corp.com.sg {
ssl_cert = </home/teo-en-ming-corp/teo-en-ming-corp.crt
ssl_key = </home/teo-en-ming-corp/teo-en-ming-corp.key
   ssl_ca = </home/teo-en-ming-corp/intermediate_domain_ca.crt
}
local_name autodiscover.teo-en-ming-corp.com.sg {
ssl_cert = </home/teo-en-ming-corp/teo-en-ming-corp.crt
ssl_key = </home/teo-en-ming-corp/teo-en-ming-corp.key
   ssl_ca = </home/teo-en-ming-corp/intermediate_domain_ca.crt
}

Restart the Dovecot IMAP and POP3 Incoming Mail Server.

# service dovecot restart

Verify SSL Certificate of Email Server
======================================

Reference Guide: How to verify that SSL for IMAP/POP3/SMTP works and a 
proper SSL certificate is in use
Link: 
https://support.plesk.com/hc/en-us/articles/213961665-How-to-verify-that-SSL-for-IMAP-POP3-SMTP-works-and-a-proper-SSL-certificate-is-in-use

[1] 
https://www.sslshopper.com/ssl-checker.html#hostname=smtp.gmail.com:465

[2] https://ssl-tools.net/mailservers

[3] IMAPS test: openssl s_client -showcerts -connect 
mail.teo-en-ming-corp.com.sg:993 -servername 
mail.teo-en-ming-corp.com.sg

CONNECTED(00000003)
depth=2 C = BE, O = GlobalSign nv-sa, OU = Root CA, CN = GlobalSign Root 
CA
verify return:1
depth=1 C = BE, O = GlobalSign nv-sa, CN = AlphaSSL CA - SHA256 - G2
verify return:1
depth=0 CN = *.teo-en-ming-corp.com.sg
verify return:1
---
Certificate chain
  0 s:/CN=*.teo-en-ming-corp.com.sg
    i:/C=BE/O=GlobalSign nv-sa/CN=AlphaSSL CA - SHA256 - G2
-----BEGIN CERTIFICATE-----

-----END CERTIFICATE-----
  1 s:/C=BE/O=GlobalSign nv-sa/CN=AlphaSSL CA - SHA256 - G2
    i:/C=BE/O=GlobalSign nv-sa/OU=Root CA/CN=GlobalSign Root CA
-----BEGIN CERTIFICATE-----

-----END CERTIFICATE-----
---
Server certificate
subject=/CN=*.teo-en-ming-corp.com.sg
issuer=/C=BE/O=GlobalSign nv-sa/CN=AlphaSSL CA - SHA256 - G2
---
No client certificate CA names sent
---
SSL handshake has read 2961 bytes and written 632 bytes
---
New, TLSv1/SSLv3, Cipher is AES256-SHA256
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
SSL-Session:
     Protocol  : TLSv1.2
     Cipher    : AES256-SHA256
     Session-ID:
     Session-ID-ctx:
     Master-Key:
     Key-Arg   : None
     Krb5 Principal: None
     PSK identity: None
     PSK identity hint: None
     TLS session ticket lifetime hint: 300 (seconds)
     TLS session ticket:


     Start Time: 1605161631
     Timeout   : 300 (sec)
     Verify return code: 0 (ok)
---
* OK [CAPABILITY IMAP4rev1 LITERAL+ SASL-IR LOGIN-REFERRALS ID ENABLE 
IDLE AUTH=PLAIN AUTH=LOGIN] Dovecot ready.

[4] POP3S test: openssl s_client -showcerts -connect 
mail.teo-en-ming-corp.com.sg:995 -servername 
mail.teo-en-ming-corp.com.sg

CONNECTED(00000003)
depth=2 C = BE, O = GlobalSign nv-sa, OU = Root CA, CN = GlobalSign Root 
CA
verify return:1
depth=1 C = BE, O = GlobalSign nv-sa, CN = AlphaSSL CA - SHA256 - G2
verify return:1
depth=0 CN = *.teo-en-ming-corp.com.sg
verify return:1
---
Certificate chain
  0 s:/CN=*.teo-en-ming-corp.com.sg
    i:/C=BE/O=GlobalSign nv-sa/CN=AlphaSSL CA - SHA256 - G2
-----BEGIN CERTIFICATE-----

-----END CERTIFICATE-----
  1 s:/C=BE/O=GlobalSign nv-sa/CN=AlphaSSL CA - SHA256 - G2
    i:/C=BE/O=GlobalSign nv-sa/OU=Root CA/CN=GlobalSign Root CA
-----BEGIN CERTIFICATE-----

-----END CERTIFICATE-----
---
Server certificate
subject=/CN=*.teo-en-ming-corp.com.sg
issuer=/C=BE/O=GlobalSign nv-sa/CN=AlphaSSL CA - SHA256 - G2
---
No client certificate CA names sent
---
SSL handshake has read 2961 bytes and written 632 bytes
---
New, TLSv1/SSLv3, Cipher is AES256-SHA256
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
SSL-Session:
     Protocol  : TLSv1.2
     Cipher    : AES256-SHA256
     Session-ID:
     Session-ID-ctx:
     Master-Key:
     Key-Arg   : None
     Krb5 Principal: None
     PSK identity: None
     PSK identity hint: None
     TLS session ticket lifetime hint: 300 (seconds)
     TLS session ticket:


     Start Time: 1605161905
     Timeout   : 300 (sec)
     Verify return code: 0 (ok)
---
+OK Dovecot ready.

[5] SMTPS Port 465 test: openssl s_client -showcerts -connect 
mail.teo-en-ming-corp.com.sg:465 -servername 
mail.teo-en-ming-corp.com.sg

socket: Connection timed out
connect:errno=110

[6] SMTPS Port 587 test: openssl s_client -starttls smtp -showcerts 
-connect mail.teo-en-ming-corp.com.sg:587 -servername 
mail.teo-en-ming-corp.com.sg

CONNECTED(00000003)
140575970621256:error:140770FC:SSL 
routines:SSL23_GET_SERVER_HELLO:unknown protocol:s23_clnt.c:769:
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 278 bytes and written 309 bytes
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
---

Installing SSL Certificate on Apache Web Server
===============================================

Backup the auxiliary Apache web server configuration file before you 
modify anything.

# cd /etc/httpd/conf.d

# cp ssl.conf ssl.teoenming

Begin Redundant/Useless Section
===============================

Please do not follow the instructions in this section.

# /etc/pki/tls/certs

# cp /root/teo-en-ming/teo-en-ming-corp.crt .

# /etc/pki/tls/private

# cp /root/teo-en-ming/teo-en-ming-corp.key .

# cd /etc/httpd/conf.d

Edit ssl.conf.

# nano ssl.conf

SSLCertificateFile /etc/pki/tls/certs/teo-en-ming-corp.crt

SSLCertificateKeyFile /etc/pki/tls/private/teo-en-ming-corp.key

Verify all Apache web server configuration files are correct.

# httpd -t

Restart Apache web server.

# service httpd restart

End of Redundant/Useless Section
=================================

Copy the public and private key over.

# cd /home/teo-en-ming-corp

# cp /root/teo-en-ming/* .

Backup the Main Apache web server configuration file before you modify 
anything.

# cd /etc/httpd/conf

# cp httpd.conf httpd.teoenming

Edit the Main Apache web server configuration file.

# nano httpd.conf

SSLCertificateFile /home/teo-en-ming-corp/teo-en-ming-corp.crt
SSLCertificateKeyFile /home/teo-en-ming-corp/teo-en-ming-corp.key
SSLCACertificateFile /home/teo-en-ming-corp/intermediate_domain_ca.crt

Verify that your Apache web server configuration files are all correct.

# httpd -t

Restart Apache web server.

# service httpd restart

Configuring SSL Certificate inside Webmin
=========================================

Login to https://mail.teo-en-ming-corp.com.sg:10101

Username: root
Password: <CENSORED>

You can also configure SSL Certificate using Webmin. I will publish a 
guide on this in the future.

Also, 16 screenshots will be published in the future.

End of Guide
============






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
