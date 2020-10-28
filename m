Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4174229D9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390016AbgJ1XCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:02:35 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:51880 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbgJ1XBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:01:34 -0400
Received: by mail-io1-f70.google.com with SMTP id m25so648090ioh.18
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=I6Tv0mZbA3G3bm/uFU3fYpeMhFGdLavDRFYielkX/qA=;
        b=ggr0abyuz053su1eOuaIi82vBj86y7ih6KUvvGJ/6fXk4raxaRGwoLMMdz8aVIqEiE
         j88wXQofuGrBrYX7CX0PK/7lnPzpzNrTLTwZR2OaW6Aj/qgdGMWpAAWoV9S+V7WmFYKt
         6zBRcmIF3gaMNM+TrXGMWCFk6vZvsf12+DMZCytnvHb2+j1cjuQyDIK7xQVF2PInCmBz
         F3+ExpwuvAEK00TF2pNjuW023r8byVDARkdI+2gFYoWw2pkSfo9UefXkmK3zC4fNxS4a
         mWhGcAnui8AyAOUuT70OXSoBixuVUaImaHYrBaX8qsYPU9ZQV9xjelKRiKDUPp4nvMuS
         R0Ow==
X-Gm-Message-State: AOAM532FQZT/clRiV3H1llAzxDeL9e6y8cHjzlpwUY0CT4icsya+61ds
        2NrrDWFuBB9rTVpkn8eNBA71BQgHwi+1cakkZ3yc522rvkh8
X-Google-Smtp-Source: ABdhPJyvkYDWO+MkW+GPCkfakucDqW9Hg44YfadMBs6jV2DHt/jCKIE8L/gnqUoHI6yNY3G7ACZNkuRZvv0g+FRnZh3ag17bqYv1
MIME-Version: 1.0
X-Received: by 2002:a92:8746:: with SMTP id d6mr6602712ilm.255.1603899197781;
 Wed, 28 Oct 2020 08:33:17 -0700 (PDT)
Date:   Wed, 28 Oct 2020 08:33:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f07eb205b2bce11b@google.com>
Subject: WARNING: suspicious RCU usage in ovs_flow_tbl_masks_cache_resize
From:   syzbot <syzbot+9a8f8bfcc56e8578016c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dev@openvswitch.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pshelar@ovn.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6daa1da4 chelsio/chtls: fix memory leaks in CPL handlers
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10defae4500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46c6fea3eb827ae1
dashboard link: https://syzkaller.appspot.com/bug?extid=9a8f8bfcc56e8578016c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fed5bc500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12afff40500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a8f8bfcc56e8578016c@syzkaller.appspotmail.com

netlink: 44 bytes leftover after parsing attributes in process `syz-executor522'.
=============================
WARNING: suspicious RCU usage
5.9.0-syzkaller #0 Not tainted
-----------------------------
net/openvswitch/flow_table.c:393 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor522/8493:
 #0: ffffffff8c9af210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40 net/netlink/genetlink.c:810

stack backtrace:
CPU: 1 PID: 8493 Comm: syz-executor522 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 ovs_flow_tbl_masks_cache_resize+0x1bf/0x200 net/openvswitch/flow_table.c:393
 ovs_dp_change+0x231/0x2b0 net/openvswitch/datapath.c:1616
 ovs_dp_cmd_new+0x4c1/0xec0 net/openvswitch/datapath.c:1706
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440ad9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffff6e416d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440ad9
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004022e0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
