Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF52C53A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbgKZMLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:11:01 -0500
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:38252
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388404AbgKZMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:11:01 -0500
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id E48F7448EE0;
        Thu, 26 Nov 2020 20:10:59 +0800 (+08)
MIME-Version: 1.0
Date:   Thu, 26 Nov 2020 20:10:59 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: Basic Setup of Aruba IAP-325-RW Instant Access Point
Message-ID: <3975b8c530ff122d2df69aa49d6caea0@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Basic Setup of Aruba IAP-325-RW Instant Access Point

Author: Mr. Turritopsis Dohrnii Teo En Ming (TARGETED INDIVIDUAL)

Country: Singapore

Date: 26 November 2020 Thursday Singapore Time

Type of Publication: Plain Text

Document version: 20201126.01

Assumptions
===========

An Aruba wireless controller already exists on the network.

Steps
=====

0. Unbox the new Aruba IAP-325-RW Instant Access Point and the IEEE 
802.3at midspan.

1. Connect LAN cable from the switch to "Data In" port on the POE 
Injector (aka midspan).

2. Connect LAN cable from "Data and Power Out" port on POE Injector to 
Aruba IAP-325-RW Instant Access Point (ENET0 port).

3. Note down the MAC address of the new Aruba IAP-325-RW.

4. Run Advanced IP scanner on the network.

5. Look for the MAC address of the new Aruba IAP-325-RW IAP on Advanced 
IP Scanner. You will get the IP address of the new Aruba IAP-325-RW. The 
Aruba IAP-325-RW automatically obtains an IP address from the DHCP 
server on the network.

6. Login to the GUI of the Aruba IAP-325-RW at 
https://aaa.bbb.ccc.ddd:4343

7. This Aruba IAP-325-RW has been provisioned by the existing Aruba 
wireless controller on the network, so you cannot use the default 
username and password of "admin" to login any more.

I told my boss Donald Trump (fictitious name used) that the new Aruba 
IAP-325-RW is up on the network. Before I can even explore the 
configuration settings, my boss immediately rushed and beat me in 
configuring the new Aruba IAP-325-RW, leaving me with no opportunity to 
learn how to configure the new Aruba IAP-325-RW at all.

8. After my boss Donald Trump (fictitious name used) has configured the 
new Aruba IAP-325-RW, I tried to figure out how he configured it.

9. Once you login to the GUI of Aruba IAP-325-RW, click New.

10. Under "1. WLAN Settings" tab:

Name: Enter your desired wireless network name (SSID)

Primary usage: Employee

11. Under "2. VLAN" tab:

Client IP assignment: Network assigned

Client VLAN assignment: Default

12. Under "3. Security" tab:

Security Level: choose Personal

Key management: WPA-2 Personal

Passphrase format: 8-63 chars

Passphrase: Enter your desired wi-fi password

Retype: Enter your desired wi-fi password

MAC authentication: Disabled

Blacklisting: Disabled

Enforce DHCP: Disabled

Fast Roaming

802.11r: Not checked

802.11k: Not checked

802.11v: Not checked

13. Under "4. Access" tab:

Access Rules: Unrestricted

Click Finish.

14. I am not very sure about the detailed configuration settings my boss 
made. He never shared them with me. But from what I gather, he has to 
give the new Aruba IAP-325-RW a hostname and associate the newly created 
SSID to this Aruba IAP-325-RW access point.

15. When I have the opportunity to configure Aruba wireless products 
again in the future, I will publish a more refined and detailed guide 
again. Stay tuned.




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
