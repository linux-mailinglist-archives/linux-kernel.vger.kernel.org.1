Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2392D024D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 10:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgLFJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 04:40:30 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:60060
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgLFJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 04:40:30 -0500
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id 35ED9448EE0;
        Sun,  6 Dec 2020 17:39:49 +0800 (+08)
MIME-Version: 1.0
Date:   Sun, 06 Dec 2020 17:39:49 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: Teo En Ming has been locked out of his CentOS Web Panel (CWP) web
 hosting control panel
Message-ID: <2f395ab5ed950c36b357995c1a6b86b2@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Teo En Ming has been locked out of his CentOS Web Panel (CWP) 
web hosting control panel

Good day from Singapore,

I have been locked out of my CentOS Web Panel (CWP) web hosting control 
panel due to numerous invalid SMTP authentication attempts. I can't 
login to CWP any more using my home IP address.

This is how I solved my problem.

1. Connect to a free VPN service.

2. Login to CentOS Web Panel at 
https://www.teo-en-ming-corp.com.sg:2087/login/index.php

3. On the left hand side menu, click Security.

4. Click "CSF Firewall".

5. Click "Firewall Deny IPs".

Contents of File: /etc/csf/csf.deny

###############################################################################
# Copyright 2006-2018, Way to the Web Limited
# URL: http://www.configserver.com
# Email: sales@waytotheweb.com
###############################################################################
# The following IP addresses will be blocked in iptables
# One IP address per line
# CIDR addressing allowed with a quaded IP (e.g. 192.168.254.0/24)
# Only list IP addresses, not domain names (they will be ignored)
#
# Note: If you add the text "do not delete" to the comments of an entry 
then
# DENY_IP_LIMIT will ignore those entries and not remove them
#
# Advanced port+ip filtering allowed with the following format
# tcp/udp|in/out|s/d=port,port,...|s/d=ip
#
# See readme.txt for more information regarding advanced port filtering
#

6. Delete the line that contains my home IP address.

7. Click "Save changes".

8. On the left hand side menu, click Security.

9. Click "CSF Firewall".

10. Click "Firewall Restart".

11. Logout from CWP.

12. Disconnect from free VPN service.

13. Login to CWP again. It is successful now.

14. My problem is solved!

Mr. Turritopsis Dohrnii Teo En Ming, 42 years old as of 6th Dec 2020 
Sunday, is a TARGETED INDIVIDUAL (TI) living in Singapore.






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
