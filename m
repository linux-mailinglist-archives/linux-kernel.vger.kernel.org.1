Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8A2C93B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgLAAOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLAAOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:14:33 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E09C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:13:53 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id t5so9717357qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UokAx8Qcgdmksk1B8p7M/csPSVmo3e9eQL5LBGqG1VA=;
        b=UP9700JIGSpmFQ5NaV+zZSbibVU5oVa3DyNJiNoaogSOYjnAu+UdGKqmj85jc2phqa
         1f03zgS0FSePbHTdn3J319gv5Jt2zgBzISlLAoGVcea+h0JkzVNsdddj8qWPVsNv2tQp
         PAtlyTShbbhuw5WJF7/6ZxztQKAGV6on5o2KDAFmd0UEwOaY8Lkl01GqSWOV0MGr2S9w
         ZOJ6E3Iuxr2nK4uFxyMC4XEQfiQjh8gZgHzJPPpRGmrb0sSIArgvwKI18Ov3InRCB9UC
         qUKkP35EJd/TMmHygIWmMe+WMx1ZWO4b0XX+vbNYaVG6wQSVRvOJCcQNIcYqyT4JN6Io
         pNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UokAx8Qcgdmksk1B8p7M/csPSVmo3e9eQL5LBGqG1VA=;
        b=BOC7vLRA6VkOG4iyeuUp2p5E9Ql9yiAdcVm4tTd4AzerWaD+AHhOQ2/ube2w8+PCxb
         m0lNeD2Fhmu9d+2UmEi5zaIWX01HlEGSsPf/yJou7s87q38kt+FEvVjUxgTD9xTGQhrJ
         GNy1dPxPgtXpyK0EhURJOR7EM8EgPfmeQ9LQr8CZGfFOese0AcIsgMIqpJ3RuPX+84st
         GxK0KsU0av5RNcR/j1LFy4bfzohxPv2Fr2pmRmfIwymtrDbEokUbLvYh6b58jN35O44x
         8kIh8PVTzhVEbMaXyL0XH80t4UcTnwejGniavFOFbxmJD9my8mbd/0dGmnMgDCe+WSjG
         xlQQ==
X-Gm-Message-State: AOAM53215Vu8bDHJzslSNevZFbG9ISM3BQwFIVh6bUvNY9It3Q4XuI09
        /YvSuV6oRRq7CEUfgibS39qZRWJitNbP7HDHRXGWhyAd8dPsBQ==
X-Google-Smtp-Source: ABdhPJy/tmsmNteWz5kJmjbK1OJZmubSm4ldgoACMeoHnWv54mPgalTWaxzYS7iq32ZgrAWyqpUokEhh5fN89wD0/pw=
X-Received: by 2002:aed:3c42:: with SMTP id u2mr24495379qte.159.1606781631751;
 Mon, 30 Nov 2020 16:13:51 -0800 (PST)
MIME-Version: 1.0
From:   Krishna M <krishnamurthi.rusty@gmail.com>
Date:   Mon, 30 Nov 2020 16:13:41 -0800
Message-ID: <CAF7cDAc8DTG1drUGYMPPVkM5CjjFqZGFodzqVOk4hmM1Bc9nnA@mail.gmail.com>
Subject: Spinlock debugging in the kernel
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please excuse me if this is a wrong group.
Please find the log of a system that I am trying to debug.

It is a "soft lockup" issue and the root cause seems to be coming from
the mm unit of the kernel.
I am relatively new to kernel and arm64 platforms.


How do you typically decipher a locking issue like this? Any ideas/
pointers that I can run with will greatly help.

[  512.522056] Rehashing will be triggered for ipset fqdn:pol_5_to of
elements 362 ahash_max 4 nsize 4
[  907.867755] BUG: soft lockup - CPU#0 stuck for 22s! [kswapd0:395]
[  919.861747] BUG: soft lockup - CPU#0 stuck for 33s! [kswapd0:395]
[  919.861752] Modules linked in: nfsv3 nfs lockd grace sunrpc
ath9k(O) ath9k_common(O) ath9k_hw(O) ath(O) mac80211(O) cfg80211(O)
compat(O) gproxy(O) bwdriver(O)            rndis_host cdc_ether usbnet
mii GobiSerial(O) cdc_acm option usb_wwan clstrio(O) clb(PO) kxp(PO)
ip6t_rpfilter ip6t_REJECT        nf_log_ipv6 nf_reject_ipv6 ip6t_frag
ip6table_mangle ip6table_filter ip6table_raw ip6t_ipv6header
nf_conntrack_ipv6 nf_defrag_ipv6 ifb act_mirred em_meta cls_basic
cls_flow cls_u32 sch_htb sch_prio sch_sfq arpt_ARPPROXY arpt_REPLY
arpt_mangle arptable_filter arp_tables xt_REDIRECT xt_nat ipt_REJECT
xt_recent xt_NETMAP ipt_MASQUERADE            nf_log_ipv4
nf_log_common xt_LOG xt_iprange ipt_ah xt_addrtype xt_TRACE xt_TCPMSS
xt_tcpmss xt_state xt_rateest xt_RATEEST xt_pkttype xt_physdev
[  919.862293]  xt_multiport xt_mark xt_mac xt_limit(O) xt_length
xt_ipv4options(O) xt_helper xt_hashlimit xt_esp xt_DSCP xt_dscp xt_CT
xt_conntrack xt_connmark             xt_connbytes xt_comment
xt_CLASSIFY nf_conntrack_netlink iptable_raw nf_nat_snmp_basic
nf_conntrack_snmp nf_conntrack_broadcast nf_nat_tftp nf_conntrack_tftp
nf_nat_pptp    nf_nat_proto_gre nf_conntrack_pptp
nf_conntrack_proto_gre nf_nat_irc nf_conntrack_irc nf_nat_ftp
nf_conntrack_ftp iptable_filter iptable_nat iptable_mangle
nf_reject_ipv4   nf_nat_redirect nf_nat_masquerade_ipv4 nf_nat_ipv4
nf_nat ip_tables nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack
compat_xtables(O) ip_set_hash_netportnet(O)
ip_set_hash_netnet(O) ip_set_hash_netiface(O) ip_set_hash_mac(O)
ip_set_hash_ipmark(O) ip_set_list_set(O) ip_set_hash_netport(O)
ip_set_hash_net(O) ip_set_hash_ipportip(O)
[  919.862508]  ip_set_hash_ipportnet(O) ip_set_hash_ipport(O)
ip_set_hash_ip(O) ip_set_bitmap_port(O) ip_set_bitmap_ipmac(O)
ip_set_bitmap_ip(O) xt_set(O) ip_set(O)        nfnetlink
sha512_generic dummy bonding ip6_vti ip6_tunnel tunnel6 ebt_ip6
ebt_arpreply 8021q garp ip_vti ip_gre ip_tunnel gre ebt_mark_m
ebt_mark ebt_redirect ebt_dnat      ebt_ip ebt_arp ebt_snat ebt_vlan
ebt_log ebt_fpath(O) ebtable_broute ebtable_filter ebtable_nat
ebtables br_netfilter bridge stp llc alarm_panic(PO) alarm(PO)
l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel tun pppoe
pppox ppp_deflate ppp_mppe ppp_async ppp_generic crc_ccitt slhc
usb_storage caam_pkc caamalg caamhash caamalg_desc caamhash_desc
caamrng caam_jr error(P) caam [last unloaded: nf_synproxy_core]
[  919.862794] CPU: 0 PID: 395 Comm: kswapd0 Tainted: P           O
4.14.83 #1
[  919.862802] task: 5a1b0000 task.stack: 5a0ba000
[  919.862808] NIP:  406f7f04 LR: 40163650 CTR: 40163d8c
[  919.862815] REGS: 5a0bbad0 TRAP: 0901   Tainted: P           O     (4.14.83)
[  919.862818] MSR:  00029000 <CE,EE,ME>  CR: 44002444  XER: 00000000
[  919.862843]  GPR00: 40163e08 5a0bbb80 5a1b0000 5aa16698 55f80540
1000f000 00000000 00000000  GPR08: 00000001 00000001 00000001 00000409
24004442
[  919.862915] NIP [406f7f04] _raw_spin_lock+0x30/0x5c
[  919.862934] LR [40163650] page_vma_mapped_walk+0x144/0x1e8

Thanks,
Krishna M
