Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718832C60D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgK0I0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:26:50 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:38948
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgK0I0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:26:50 -0500
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id 746CD448EE0;
        Fri, 27 Nov 2020 16:26:49 +0800 (+08)
MIME-Version: 1.0
Date:   Fri, 27 Nov 2020 16:26:49 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: How to Unblock IP Address of Email Client in Linux iptables Firewall
 in Linux Mail Server
Message-ID: <841285c108f960bee81fd107dbc3798f@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: How to Unblock IP Address of Email Client in Linux iptables 
Firewall in Linux Mail Server

Good day from Singapore,

I am an IT consultant in Singapore. Today, Black Friday 27 November 
2020, my client Donald Trump (fictitious name used) informed me that he 
cannot send and receive emails using his home Wi-Fi connection. But he 
could send and receive emails using his mobile phone 4G connection.

Apparently, the public IP address of his home internet connection was 
blocked. The IP address is 666.666.666.666 (fictitious IP address used).

I checked the Fortigate 100D firewall but it was not blocked there.

Then I proceed to check the Linux iptables firewall on my client's Linux 
mail server. I login/putty/ssh into mail.teo-en-ming-corp.com.sg, which 
is my client's Linux mail server.

I executed the following command:

# iptables -S | grep 666.666.666.666

The output is:

-A DENYIN -s 666.666.666.666/32 ! -i lo -j DROP
-A DENYOUT -d 666.666.666.666/32 ! -o lo -j LOGDROPOUT

I proceeded to delete the above 2 Linux iptables firewall rules which 
blocked the IP address 666.666.666.666, using the following commands:

# iptables -D DENYIN -s 666.666.666.666/32 ! -i lo -j DROP
# iptables -D DENYOUT -d 666.666.666.666/32 ! -o lo -j LOGDROPOUT

Then I run the following command again to make sure the IP address has 
been unblocked.

# iptables -S | grep 666.666.666.666

There should be no output, confirming that the IP address has been 
unblocked.

Now my client Donald Trump is able to send and receive emails using his 
home Wi-fi connection successfully.

The author, Mr. Turritopsis Dohrnii Teo En Ming, 42 years as of 27 Nov 
2020 Friday, is a TARGETED INDIVIDUAL (TI) living in Singapore.

Reference Guide: How To List and Delete Iptables Firewall Rules
Link: 
https://www.digitalocean.com/community/tutorials/how-to-list-and-delete-iptables-firewall-rules







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
