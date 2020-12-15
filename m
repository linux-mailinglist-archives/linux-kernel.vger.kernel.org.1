Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330D92DAFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgLOPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:15:17 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:49939 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbgLOPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:14:52 -0500
Received: by mail-il1-f199.google.com with SMTP id m14so16630742ila.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 07:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AnGmRmfihjvN7Tg8VK6Jl1pVPSZu1VQEIxNiW/n3Hr8=;
        b=SrHGsD88iF3lLLDN1+qcQKkaC9C0d/W5vW+tW+5bGkAE5wD3ppZ011AkicK//6Ok79
         8E5aw323U2qR4z4RWfDB4Au9k/hZINNkQQE6q6NL/qUd6G1BsMMLn90cPikZkObLYyT0
         5vfb/uu6/OWjtIeKNQTnWqDLlIOjgQjhtes75+OG9GWIC5+odn4A3UYmnUbtC/hp1Gvh
         UKYbNpyfncZziV+hG9GETBdsbEzp3xWkwFFdajtRQP/LFQ82eyX2zlGLyw75SKkNoaj5
         4VDaJQIXraX2q1IcV8gKMG1fGlH8JfP4VIJN57RqPkNFugCGa63cA2Z6gtHX3asZwtX8
         /vPA==
X-Gm-Message-State: AOAM530ry79MF8+Zt67qinkrIrFy5gK4kUStcwnWbvoi1DC3Q9tSKcks
        Zz4lYHVcoA+LXIPcXkzr8w74yK95B2xnVRbN+QC5gnYQybl+
X-Google-Smtp-Source: ABdhPJzOlmobw/zDV5uvUSvjrXtXYrEsNL1/D1pYRSxsKz8AI6A8VTtAHNPJav364KU3p2XRADWNrsC7XrR2jbvsOMpfkHFuv3I1
MIME-Version: 1.0
X-Received: by 2002:a02:7650:: with SMTP id z77mr39145481jab.134.1608045250882;
 Tue, 15 Dec 2020 07:14:10 -0800 (PST)
Date:   Tue, 15 Dec 2020 07:14:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f63a4705b6823516@google.com>
Subject: UBSAN: shift-out-of-bounds in hash_ipmark_create
From:   syzbot <syzbot+d81819ac03d8c36e3974@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, vvs@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156c845b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
dashboard link: https://syzkaller.appspot.com/bug?extid=d81819ac03d8c36e3974
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14960f9b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12be080f500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d81819ac03d8c36e3974@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in net/netfilter/ipset/ip_set_hash_gen.h:151:6
shift exponent 32 is too large for 32-bit type 'unsigned int'
CPU: 0 PID: 8473 Comm: syz-executor542 Not tainted 5.10.0-rc6-next-20201207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 htable_bits net/netfilter/ipset/ip_set_hash_gen.h:151 [inline]
 hash_ipmark_create.cold+0x96/0x9b net/netfilter/ipset/ip_set_hash_gen.h:1524
 ip_set_create+0x610/0x1380 net/netfilter/ipset/ip_set_core.c:1115
 nfnetlink_rcv_msg+0xecc/0x1180 net/netfilter/nfnetlink.c:252
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 nfnetlink_rcv+0x1ac/0x420 net/netfilter/nfnetlink.c:600
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x907/0xe40 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440419
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdadcbeb88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440419
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000005 R09: 00000000004002c8
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000401c20
R13: 0000000000401cb0 R14: 0000000000000000 R15: 0000000000000000
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
