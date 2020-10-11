Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9411128A744
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 13:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbgJKL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 07:58:24 -0400
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:50048
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbgJKL6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 07:58:24 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2020 07:58:23 EDT
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id F1EB744DD90;
        Sun, 11 Oct 2020 19:52:05 +0800 (+08)
MIME-Version: 1.0
Date:   Sun, 11 Oct 2020 19:52:05 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: Configure Cisco ASA 5506-X Firewall for M1 Leased Line
Message-ID: <3878b845eb3792db19856be9a51d0711@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Configure Cisco ASA 5506-X Firewall for M1 Leased Line

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date: 11 October 2020 Sunday Singapore Time

Type of Publication: Plain Text
Document Version: 20201011.01

Cisco ASA Firewall CLI commands:

enable
conf t
interface GigabitEthernet1/8 (M1 Leased Line connected to Port 8)
no shut
ip address aaa.bbb.108.212 255.255.255.248
nameif M1-Leased-Line
security-level 50

route outside 0.0.0.0 0.0.0.0 aaa.bbb.ccc.121 5 track 1
route M1-Leased-Line aaa.bbb.108.0 255.255.255.0 aaa.bbb.108.209 1

object network Quantum
subnet aaa.bbb.108.0 255.255.255.0

same-security-traffic permit intra-interface

access-list nat_inside_quantum extended permit ip aaa.bbb.23.0 
255.255.255.0 aaa.bbb.108.0 255.255.255.0

access-list nat_inside_quantum extended permit ip aaa.bbb.108.0 
255.255.255.0 aaa.bbb.23.0 255.255.255.0

Teo En Ming’s Original NAT rule (partially correct only):

nat (inside,M1-Leased-Line) source static NETWORK_OBJ_aaa.bbb.23.0_24 
NETWORK_OBJ_aaa.bbb.23.0_24 destination static Quantum Quantum 
no-proxy-arp route-lookup

NAT rule corrected/fixed by boss (FINAL VERSION):

nat (inside,M1-Leased-Line) source static NETWORK_OBJ_aaa.bbb.23.0_24 
interface destination static Quantum Quantum

Useful Troubleshooting Commands
===============================

show interface ip brief
show route | begin Gateway
show nat (Very Important Command to use)
packet-tracer input inside tcp aaa.bbb.23.10 12345 aaa.bbb.108.180 22

Quantum Linux Servers
=====================

aaa.bbb.108.180 (Primary Linux Server)
aaa.bbb.108.181 (Backup Linux Server)
aaa.bbb.108.182 (UAT Linux Virtual Machine)
aaa.bbb.108.183 (IDRAC of Primary Linux Server)
aaa.bbb.108.184 (IDRAC of Backup Linux Server)

Useful Reading Resources
========================

[1] Cisco ASA 5506-X | Leased Line w/DSL Failover | Default Route 
Preference

https://www.reddit.com/r/networking/comments/fhff1m/cisco_asa_5506x_leased_line_wdsl_failover_default/

[2] ASA Dual ISP using IP SLA

https://integratingit.wordpress.com/2019/11/24/asa-dual-isp-using-ip-sla/

[3] Static route on inside interface of ASA does'nt work

https://community.cisco.com/t5/network-security/static-route-on-inside-interface-of-asa-does-nt-work/td-p/914826

[4] Cisco ASA 8.3 - No NAT / NAT Exemption

https://www.fir3net.com/Firewalls/Cisco/cisco-asa-83-no-nat-nat-exemption.html

[5] NAT: Untranslate_hits

https://community.cisco.com/t5/switching/nat-untranslate-hits/td-p/1056571

[6] Cisco ASA Firewall Packet Tracer

https://www.cisco.com/c/en/us/support/docs/security/asa-5500-x-series-next-generation-firewalls/115904-asa-config-dmz-00.html

[7] Cisco ASA NAT – Configuration Guide

https://www.practicalnetworking.net/stand-alone/cisco-asa-nat/







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
